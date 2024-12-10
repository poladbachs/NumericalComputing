% exercise1a.m
% Graphical solution for the minimization problem

clc; clear;

% Define constraint equations
A = [1, 2; 1, 1; 2, 3];
b = [40; 30; 72];

% Solve intersection points programmatically
% Preallocate points array
points = [];

% Iterate through all pairs of constraints
for i = 1:size(A, 1)
    for j = i+1:size(A, 1)
        % Solve the linear system of equations
        coeffs = [A(i, :); A(j, :)];
        rhs = [b(i); b(j)];
        if rank(coeffs) == 2 % Ensure the equations are not parallel
            point = coeffs \ rhs; % Solve Ax = b
            if all(point >= 0) && (point(1) + 2*point(2) <= 40) && (point(1) + point(2) >= 30) && (2*point(1) + 3*point(2) >= 72)
                points = [points; point']; % Add valid point
            end
        end
    end
end

% Unique feasible points (vertices of the feasible region)
vertices = unique(points, 'rows');

% Add boundary points for x and y axes intersections
vertices = [vertices; 40, 0; 36, 0]; % These are boundary points from the plot

% Sort vertices for plotting the feasible region
[~, idx] = sort(vertices(:, 1));
vertices = vertices(idx, :);

% Objective function z = 4x + y
z_values = 4 * vertices(:, 1) + vertices(:, 2);

% Find the optimal solution
[min_z, min_idx] = min(z_values);

% Display results
disp('Vertices of the feasible region:');
disp(vertices);
disp('Objective function values at vertices (z = 4x + y):');
disp(z_values);
fprintf('Optimal Solution: x = %d, y = %d, z = %d\n', ...
        round(vertices(min_idx, 1)), round(vertices(min_idx, 2)), round(min_z));

% Plot constraints and feasible region
figure;
hold on;

% Plot constraint lines
fimplicit(@(x, y) x + 2*y - 40, 'r', 'LineWidth', 1.5, 'DisplayName', 'x + 2y \leq 40');
fimplicit(@(x, y) x + y - 30, 'g', 'LineWidth', 1.5, 'DisplayName', 'x + y \geq 30');
fimplicit(@(x, y) 2*x + 3*y - 72, 'b', 'LineWidth', 1.5, 'DisplayName', '2x + 3y \geq 72');

% Highlight the feasible region
fill(vertices(:, 1), vertices(:, 2), 'y', 'FaceAlpha', 0.3, 'DisplayName', 'Feasible Region');

% Mark the optimal solution
plot(vertices(min_idx, 1), vertices(min_idx, 2), 'ro', 'MarkerSize', 8, 'LineWidth', 2, ...
    'DisplayName', 'Optimal Solution');

% Set plot properties
xlim([0 50]); ylim([0 50]);
xlabel('x'); ylabel('y');
title('Feasible Region and Optimal Solution');
legend;
grid on;
hold off;
