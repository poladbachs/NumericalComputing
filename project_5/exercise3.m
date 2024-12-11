clear; clc;

type = 'max';
A = [4, 3, 1, 0, 0;
     4, 1, 0, 1, 0;
     4, 2, 0, 0, 1];
h = [12; 8; 8];
c = [3, 4, 0, 0, 0];
sign = zeros(1, size(A, 1));

[z, x_B, index_B] = simplex(type, A, h, c, sign);

disp('Optimal Solution:');
disp(['Basic Variables = ', num2str(x_B')]);
disp(['Maximum Profit (z) = ', num2str(z)]);

x1 = linspace(0, 10, 100);
x2_1 = (12 - 4 * x1) / 3;
x2_2 = (8 - 4 * x1);
x2_3 = (8 - 4 * x1) / 2;

figure;
hold on;
fill([0, 0, 2, 4], [0, 4, 0, 0], 'y', 'FaceAlpha', 0.3, 'EdgeColor', 'none', 'DisplayName', 'Feasible Region');
plot(x1, x2_1, 'r-', 'LineWidth', 2, 'DisplayName', '4x_1 + 3x_2 \leq 12');
plot(x1, x2_2, 'b-', 'LineWidth', 2, 'DisplayName', '4x_1 + x_2 \leq 8');
plot(x1, x2_3, 'g-', 'LineWidth', 2, 'DisplayName', '4x_1 + 2x_2 \leq 8');

scatter(2, 0, 100, 'k', 'filled', 'DisplayName', 'Optimal Solution (x_1 = 2, x_2 = 0)');
xlabel('x_1', 'FontSize', 14);
ylabel('x_2', 'FontSize', 14);
title('Feasible Region and Constraints', 'FontSize', 16);
legend('Location', 'northeastoutside');
grid on;

xlim([0, 10]);
ylim([0, 10]);

hold off;