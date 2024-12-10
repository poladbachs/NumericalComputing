% Define the coefficients of the objective function
c = [60; 70]; % Profits for trousers type 1 and type 2

% Define the inequality constraints
A = [25, 40; 1, 1]; % Coefficients of inequalities
b = [7000; 265];    % Right-hand side of inequalities

% Initialize the vertices matrix
vertices = []; 

% Calculate intersections of constraints and axes
n = size(A, 1);
for i = 1:n
    for j = i+1:n
        % Compute the intersection of two constraints
        M = [A(i, :); A(j, :)];
        rhs = [b(i); b(j)];
        if rank(M) == 2
            point = M \ rhs; 
            vertices = [vertices; point']; % Add to vertices
        end
    end
    % Add intersections with the axes
    if A(i, 1) > 0
        x_intercept = b(i) / A(i, 1);
        vertices = [vertices; x_intercept, 0];
    end
    if A(i, 2) > 0
        y_intercept = b(i) / A(i, 2);
        vertices = [vertices; 0, y_intercept];
    end
end

% Ensure vertices are within bounds and satisfy constraints
valid_vertices = [];
for i = 1:size(vertices, 1)
    if all(A * vertices(i, :)' <= b) && all(vertices(i, :) >= 0)
        valid_vertices = [valid_vertices; vertices(i, :)];
    end
end

% Evaluate the objective function at valid vertices
profits = valid_vertices * c;

% Sort the vertices and profits for consistent output
[profits, sort_idx] = sort(profits, 'descend');
valid_vertices = valid_vertices(sort_idx, :);

% Find the optimal solution
optimal_point = valid_vertices(1, :);
optimal_profit = profits(1);

% Display vertices and objective function values as integers
disp('Vertices of the feasible region:');
disp(round(valid_vertices)); % Round to integers

disp('Objective function values at vertices:');
disp(round(profits)); % Round to integers

% Display the optimal solution
fprintf('\nOptimal Solution: x = %d, y = %d, z = %d\n', ...
    round(optimal_point(1)), round(optimal_point(2)), round(optimal_profit));

% Plot the feasible region and constraints
figure; hold on;
fimplicit(@(x, y) 25*x + 40*y - 7000, 'r', 'LineWidth', 2, 'DisplayName', '25x + 40y \leq 7000');
fimplicit(@(x, y) x + y - 265, 'b', 'LineWidth', 2, 'DisplayName', 'x + y \leq 265');

x_vals = linspace(0, 300, 500);
y_fill = min((7000 - 25 * x_vals) / 40, 265 - x_vals); 
y_fill(y_fill < 0) = 0;
fill([x_vals, 0, 0], [y_fill, 0, 0], 'y', 'FaceAlpha', 0.3, 'DisplayName', 'Feasible Region');

plot(optimal_point(1), optimal_point(2), 'ro', 'MarkerSize', 10, 'LineWidth', 2, 'DisplayName', 'Optimal Solution');
xlabel('x (Trousers Type 1)'); ylabel('y (Trousers Type 2)'); title('Feasible Region and Optimal Solution');
legend(); grid on; xlim([0, 300]); ylim([0, 300]); hold off;
