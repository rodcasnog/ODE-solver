function [results] = ode_simulator(varargin)
% ODE_SIMULATOR - Unified API for solving ODEs with multiple methods
%
% USAGE:
%   results = ode_simulator('method', method_name, 'problem', problem_name, options...)
%   results = ode_simulator('compare', {method1, method2, ...}, 'problem', problem_name, options...)
%   results = ode_simulator('analyze', method_name, 'problem', problem_name, options...)
%
% PARAMETERS:
%   'method'     - Single method to run: 'euler', 'rk4', 'ab2', 'ab3', 'ab4', etc.
%   'compare'    - Cell array of methods to compare
%   'analyze'    - Method to analyze against exact solution or ode45
%   'problem'    - Problem name: 'oscillator', 'lorenz', 'vanderpol', 'custom'
%   'interval'   - Time interval [t0, tf] (default: [0, 10])
%   'x0'         - Initial conditions (default: depends on problem)
%   'N'          - Number of steps (default: 1000)
%   'f'          - Custom ODE function (for 'custom' problem)
%   'exact'      - Exact solution function (optional)
%   'plot'       - Enable plotting (default: true)
%   'verbose'    - Enable verbose output (default: false)
%
% RETURNS:
%   results - Structure containing:
%             .t        - Time vector
%             .x        - Solution matrix
%             .method   - Method name(s)
%             .error    - Error analysis (if applicable)
%             .stats    - Performance statistics

    % Parse input arguments
    p = inputParser;
    
    % Main operation mode
    addParameter(p, 'method', '', @ischar);
    addParameter(p, 'compare', {}, @iscell);
    addParameter(p, 'analyze', '', @ischar);
    
    % Problem specification
    addParameter(p, 'problem', 'oscillator', @ischar);
    addParameter(p, 'f', [], @(x) isa(x, 'function_handle'));
    addParameter(p, 'exact', [], @(x) isa(x, 'function_handle'));
    addParameter(p, 'g', [], @(x) isa(x, 'function_handle')); % For Taylor methods
    
    % Numerical parameters
    addParameter(p, 'interval', [], @(x) length(x)==2);
    addParameter(p, 'x0', [], @isnumeric);
    addParameter(p, 'N', 1000, @isnumeric);
    
    % Output options
    addParameter(p, 'plot', true, @islogical);
    addParameter(p, 'verbose', false, @islogical);
    
    parse(p, varargin{:});
    
    % Include methods directory path
    script_path = mfilename('fullpath');
    [project_dir, ~, ~] = fileparts(script_path);
    methods_dir = fullfile(project_dir, 'methods');
    if ~isfolder(methods_dir)
        display(fileparts(script_path));
        error('The "methods" directory was not found. Please ensure it is in the same directory as solve_ode.m');
    end
    addpath(methods_dir);
    
    [f, interval, x0, exact_sol] = get_problem_params(p.Results.problem, ...
        p.Results.f, p.Results.interval, p.Results.x0, p.Results.exact);
    
    if ~isempty(p.Results.method)
        results = run_single_method(p.Results.method, f, interval, x0, p.Results.N, p.Results);
    elseif ~isempty(p.Results.compare)
        results = compare_methods(p.Results.compare, f, interval, x0, p.Results.N, p.Results);
    elseif ~isempty(p.Results.analyze)
        results = analyze_method(p.Results.analyze, f, interval, x0, p.Results.N, exact_sol, p.Results);
    else
        error('Must specify either ''method'', ''compare'', or ''analyze''');
    end
    
    if p.Results.plot
        plot_results(results, p.Results);
    end
end

function results = run_single_method(method_name, f, interval, x0, N, opts)
% Execute a single numerical method
    
    method_func = get_method_function(method_name);
    
    if opts.verbose
        fprintf('Running method: %s\n', method_name);
    end
    
    tic;
    [t, x] = method_func(f, interval, x0, N);
    elapsed_time = toc;
    
    results = struct();
    results.t = t;
    results.x = x;
    results.method = method_name;
    results.stats.time = elapsed_time;
    results.stats.steps = length(t);
end

function results = compare_methods(methods, f, interval, x0, N, opts)
% Compare different numerical methods

    results = struct();
    results.methods = methods;
    results.t = {};
    results.x = {};
    results.stats = struct();
    
    if opts.verbose
        fprintf('Comparing %d methods\n', length(methods));
    end
    
    for i = 1:length(methods)
        method_func = get_method_function(methods{i});
        
        tic;
        [t, x] = method_func(f, interval, x0, N);
        elapsed_time = toc;
        
        results.t{i} = t;
        results.x{i} = x;
        results.stats.time(i) = elapsed_time;
        results.stats.steps(i) = length(t);
        
        if opts.verbose
            fprintf('  %s: %.4f seconds, %d steps\n', methods{i}, elapsed_time, length(t));
        end
    end
end

function results = analyze_method(method_name, f, interval, x0, N, exact_sol, opts)
% Analyze method against exact solution or ode45
    
    method_func = get_method_function(method_name);
    [t, x] = method_func(f, interval, x0, N);
    
    results = struct();
    results.t = t;
    results.x = x;
    results.method = method_name;
    
    if ~isempty(exact_sol)
        x_exact = exact_sol(t);
        if size(x_exact, 1) == 1 && size(x_exact, 2) > 1
            x_exact = x_exact';
        end
        results.x_exact = x_exact;
        results.error.absolute = abs(x - x_exact);
        results.error.global_max = max(sqrt(sum((x - x_exact).^2, 2)));
        results.reference = 'exact';
    else
        [t_ref, x_ref] = ode45(@(t,x) f(t,x)', t, x0);
        results.x_reference = x_ref;
        results.error.absolute = abs(x - x_ref);
        results.error.global_max = max(sqrt(sum((x - x_ref).^2, 2)));
        results.reference = 'ode45';
    end
    
    if opts.verbose
        fprintf('Method: %s\n', method_name);
        fprintf('Global error vs %s: %.6e\n', results.reference, results.error.global_max);
    end
end
