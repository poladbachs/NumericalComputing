c = [60; 70];

A = [25, 40; 1, 1];
b = [7000; 265];

vertices = []; 

n = size(A, 1);
for i = 1:n
    for j = i+1:n
        M = [A(i, :); A(j, :)];
        rhs = [b(i); b(j)];
        if rank(M) == 2
            point = M \ rhs; 
            vertices = [vertices; point'];
        end
    end
    if A(i, 1) > 0
        x_intercept = b(i) / A(i, 1);
        vertices = [vertices; x_intercept, 0];
    end
    if A(i, 2) > 0
        y_intercept = b(i) / A(i, 2);
        vertices = [vertices; 0, y_intercept];
    end
end

valid_vertices = [];
for i = 1:size(vertices, 1)
    if all(A * vertices(i, :)' <= b) && all(vertices(i, :) >= 0)
        valid_vertices = [valid_vertices; vertices(i, :)];
    end
end

profits = valid_vertices * c;

[profits, sort_idx] = sort(profits, 'descend');
valid_vertices = valid_vertices(sort_idx, :);

optimal_point = valid_vertices(1, :);
optimal_profit = profits(1);

disp('Vertices of the feasible region:');
disp(round(valid_vertices));

disp('Objective function values at vertices:');
disp(round(profits));

fprintf('\nOptimal Solution: x = %d, y = %d, z = %d\n', ...
    round(optimal_point(1)), round(optimal_point(2)), round(optimal_profit));

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
