function [f, interval, x0, exact_sol] = get_problem_params(problem_name, custom_f, custom_interval, custom_x0, custom_exact)
% Retrieves predefined ODE problems or uses custom.
%
% PREDEFINED PROBLEMS
%   'sine_product'             - 1D example.
%   'harmonic_oscillator'      - 2D simple harmonic oscillator.
%   'forced_oscillator_2d'     - 2D forced oscillator.
%   'lorenz'                   - 3D Lorenz system (classic chaotic).
%   'lorenz_high_r'            - 3D Lorenz system with r = 99.5.
%   'lorenz_low_r'             - 3D Lorenz system with r = 470/19.
%   'damped_spiral_exact'      - 2D system with a known exact solution.
%   'forced_oscillator_exact'  - 2D forced system with a known exact solution.
%   'pendulum_damped_forced'   - 2D non-linear pendulum.
%   'pendulum_small_angle'     - 2D linearized pendulum.
%   'lotka_volterra'           - 2D predator-prey model.
%   'lotka_volterra_capacity'  - 2D predator-prey with carrying capacity.
%   'van_der_pol'              - 2D Van der Pol oscillator (classic).
%   'van_der_pol_stiff'        - 2D stiff Van der Pol oscillator (mu=8).
%   'duffing'                  - 2D Duffing equation oscillator.
%   'forced_harmonic'          - 2D forced harmonic oscillator near resonance.

    f = []; interval = []; x0 = []; g = []; exact_sol = [];

    if nargin < 2
        custom_params = struct();
    end

    switch lower(problem_name)
        
        case 'sine_product' % 1D
            f = @(t,x) sin(t.*x);
            g = @(t,x) cos(t.*x).*(x+t.*sin(t.*x)); % For Taylor method
            interval = [0, 8*pi];
            x0 = 4;
            
        case 'harmonic_oscillator' % 2D
            k=1; m=1;
            f = @(t,x) [x(2), -(k/m)*x(1)];
            interval = [0, 10];
            x0 = [1, 0];
            exact_sol = @(t) [cos(t), -sin(t)];

        case 'forced_oscillator_2d' % 2D
            f = @(t,x) [x(2), -9*x(1)+8*sin(t)];
            interval = [0, 2*pi];
            x0 = [0, 4];
            
        case 'lorenz' % 3D Classic Chaotic
            sigma = 10; rho = 28; beta = 8/3;
            f = @(t,x) [sigma*(x(2)-x(1)), rho*x(1)-x(1)*x(3)-x(2), x(1)*x(2)-beta*x(3)];
            interval = [0, 40];
            x0 = [1, 1, 1];
            
        case 'lorenz_high_r' % 3D
            sigma = 10; rho = 99.5; beta = 8/3;
            f = @(t,x) [sigma*(x(2)-x(1)), rho*x(1)-x(1)*x(3)-x(2), x(1)*x(2)-beta*x(3)];
            interval = [0, 100];
            x0 = [5, -5, 15];
            
        case 'lorenz_low_r' % 3D
            sigma = 10; rho = 470/19; beta = 8/3;
            f = @(t,x) [sigma*(x(2)-x(1)), rho*x(1)-x(1)*x(3)-x(2), x(1)*x(2)-beta*x(3)];
            interval = [0, 100];
            x0 = [5, -5, 15];
            
        case 'damped_spiral_exact' % 2D with exact solution
            f = @(t,x) [-.1*x(1)+2*x(2), -2*x(1)-.1*x(2)];
            interval = [0, 10];
            x0 = [0, 1];
            exact_sol = @(t) [exp(-.1*t).*sin(2*t), exp(-.1*t).*cos(2*t)];
            
        case 'forced_oscillator_exact' % 2D with exact solution
            f = @(t,x) [x(2), -2*x(1)+cos(3*t)];
            interval = [0, 10];
            x0 = [1, 0];
            exact_sol = @(t) [8/7*cos(sqrt(2)*t)-1/7*cos(3*t), -sqrt(2)*8/7*sin(sqrt(2)*t)+3/7*sin(3*t)];
            
        case 'pendulum_damped_forced' % 2D Non-linear
            m=1; L=1; g_const=9.8; b=0.5; F=1.1; T=10;
            theta0 = asin(1/g_const); v0 = 0;
            f = @(t,x) [x(2), (F - m*g_const*sin(x(1)) - 2*L*b*x(2))/(m*L)];
            interval = [0, T];
            x0 = [theta0, v0];
            
        case 'pendulum_small_angle' % 2D Linearized
            m=1; L=1; g_const=9.8; b=0; F=0; T=20;
            theta0 = pi/20; v0 = 0;
            f = @(t,x) [x(2), (F - m*g_const*x(1) - 2*L*b*x(2))/(m*L)];
            interval = [0, T];
            x0 = [theta0, v0];
            
        case 'lotka_volterra' % 2D Predator-Prey
            a=3; b=.2; c=.6; d=5;
            f = @(t,x) [a*x(1)-b*x(1).*x(2), -c*x(2)+d*x(1).*x(2)];
            interval = [0, 10];
            x0 = [5, 5];
            
        case 'lotka_volterra_capacity' % 2D Predator-Prey with carrying capacity
            a=1; b=1; c=1; d=1; e=.4; f_param=.02;
            f = @(t,x) [a*x(1)-b*x(1).*x(2)-e*x(1).^2, -c*x(2)+d*x(1).*x(2)-f_param*x(2).^2];
            interval = [0, 20];
            x0 = [5, 5];

        case 'van_der_pol' % 2D Classic
            mu = 2;
            f = @(t,x) [x(2), mu*(1-x(1)^2)*x(2)-x(1)];
            interval = [0, 20];
            x0 = [2, 0];
            
        case 'van_der_pol_stiff' % 2D Stiff version
            a=8; b=1;
            f = @(t,x) [x(2), -a*(x(1).^2-b).*x(2)-x(1)];
            interval = [0, 40];
            x0 = [2, 0];
            
        case 'duffing' % 2D Duffing Equation
            a=.5;
            f = @(t,x) [x(2), -a*x(2)-x(1).^3+x(1)];
            interval = [0, 40];
            x0 = [1, 1];

        case 'forced_harmonic' % 2D Forced Harmonic Oscillator
            A=10; a=10; b=0; w=10.5; % Near resonance (w is close to a)
            f = @(t,x) [x(2), -2*b*x(2)-a^2*x(1)+A*cos(w*t)];
            interval = [0, 10*pi];
            x0 = [0, 0];
            
        case 'custom'
            if isempty(custom_f)
                error('Custom function f must be provided for custom problem');
            end
            f = custom_f;
            interval = custom_interval;
            x0 = custom_x0;
            
        otherwise
            error('Unknown problem: %s.', problem_name);
    end
    
end
