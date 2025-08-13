function plot_results(results, opts)
    
    if isfield(results, 'methods')
        plot_comparison(results, opts);
    elseif isfield(results, 'error')
        plot_analysis(results, opts);
    else
        plot_single(results, opts);
    end
end

function plot_single(results, opts)

    n_vars = size(results.x, 2);
    
    switch n_vars
        case 1
            figure;
            plot(results.t, results.x, 'b-', 'LineWidth', 1.5);
            xlabel('Time'); ylabel('x(t)');
            title(sprintf('Solution using %s', results.method));
            grid on;
            
        case 2
            figure;
            subplot(2,1,1);
            plot(results.t, results.x(:,1), 'r-', results.t, results.x(:,2), 'b-', 'LineWidth', 1.5);
            xlabel('Time'); ylabel('x(t), y(t)');
            legend('x(t)', 'y(t)');
            title(sprintf('Solution using %s', results.method));
            grid on;
            
            subplot(2,1,2);
            plot(results.x(:,1), results.x(:,2), 'g-', 'LineWidth', 1.5);
            xlabel('x'); ylabel('y');
            title('Phase Portrait');
            grid on;
            
        case 3
            figure;
            plot3(results.x(:,1), results.x(:,2), results.x(:,3), 'r-', 'LineWidth', 1.5);
            xlabel('x'); ylabel('y'); zlabel('z');
            title(sprintf('3D Trajectory using %s', results.method));
            grid on;
    end
end

function plot_comparison(results, opts)

    n_methods = length(results.methods);
    colors = lines(n_methods);
    
    figure;
    hold on;
    for i = 1:n_methods
        if size(results.x{i}, 2) == 1
            plot(results.t{i}, results.x{i}, 'Color', colors(i,:), 'LineWidth', 1.5, ...
                 'DisplayName', results.methods{i});
        else
            % For multi-dimensional, plot first component
            plot(results.t{i}, results.x{i}(:,1), 'Color', colors(i,:), 'LineWidth', 1.5, ...
                 'DisplayName', results.methods{i});
        end
    end
    xlabel('Time');
    ylabel('x(t)');
    title('Method Comparison');
    legend('show');
    grid on;
    hold off;
end

function plot_analysis(results, opts)

    figure;
    
    if size(results.x, 2) == 1
        subplot(2,1,1);
        plot(results.t, results.x, 'b-', 'LineWidth', 1.5, 'DisplayName', results.method);
        if isfield(results, 'x_exact')
            hold on;
            plot(results.t, results.x_exact, 'r--', 'LineWidth', 1.5, 'DisplayName', 'Exact');
            hold off;
        end
        xlabel('Time'); ylabel('x(t)');
        title(sprintf('Solution: %s vs %s', results.method, results.reference));
        legend('show'); grid on;
        
        subplot(2,1,2);
        semilogy(results.t, results.error.absolute, 'r-', 'LineWidth', 1.5);
        xlabel('Time'); ylabel('Absolute Error');
        title(sprintf('Error Analysis (Global Max: %.2e)', results.error.global_max));
        grid on;
    else
        % Multi-dimensional case
        subplot(2,1,1);
        plot(results.t, results.x(:,1), 'b-', 'LineWidth', 1.5);
        xlabel('Time'); ylabel('x_1(t)');
        title(sprintf('First Component: %s', results.method));
        grid on;
        
        subplot(2,1,2);
        error_norm = sqrt(sum(results.error.absolute.^2, 2));
        semilogy(results.t, error_norm, 'r-', 'LineWidth', 1.5);
        xlabel('Time'); ylabel('Error Norm');
        title(sprintf('Error Analysis (Global Max: %.2e)', results.error.global_max));
        grid on;
    end
end
