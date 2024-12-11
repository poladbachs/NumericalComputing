type = 'max';

h = [18; 32; 25; 17; 11930; 22552; 11209; 5870; 16; 32; 40; 28];

prices = [135, 200, 410, 520];
c = [];
factors = [1, 1.1, 1.2, 1.3];
for i = 1:length(factors)
    c = [c; factors(1, i) * prices];
end
c = reshape(c, [], 1);
c = c';

A = [1 zeros(1, 3) 1 zeros(1, 3) 1 zeros(1, 3) 1 zeros(1, 3);
    0   1 zeros(1, 3) 1 zeros(1, 3) 1 zeros(1, 3) 1   0   0;
    0   0   1 zeros(1, 3) 1 zeros(1, 3) 1 zeros(1, 3) 1   0;
    zeros(1, 3) 1 zeros(1, 3) 1 zeros(1, 3) 1 zeros(1, 3) 1;
    320 zeros(1, 3) 510 zeros(1, 3) 630 zeros(1, 3) 125 zeros(1, 3);
    0   320 zeros(1, 3) 510 zeros(1, 3) 630 zeros(1, 3) 125 0   0;
    0   0   320 zeros(1, 3) 510 zeros(1, 3) 630 zeros(1, 3) 125 0;
    zeros(1, 3) 320 zeros(1, 3) 510 zeros(1, 3) 630 zeros(1, 3) 125;
    1   1   1   1 zeros(1, 12);
    zeros(1, 4) 1   1   1   1 zeros(1, 8);
    zeros(1, 8) 1   1   1   1 zeros(1, 4);
    zeros(1, 12) 1   1   1   1];

sign = -1 * ones(1, 12);

[z, x_B, index_B] = simplex(type, A, h, c, sign);

decision_vars = zeros(1, size(A, 2)); 
decision_vars(index_B) = x_B;

result = reshape(decision_vars(1:16), 4, 4)';

disp('Optimal Allocation:');
disp(result);
disp(['Maximum Profit: ', num2str(z)]);

compartments = categorical({'S1', 'S2', 'S3', 'S4'});
compartments = reordercats(compartments, {'S1', 'S2', 'S3', 'S4'});

figure;
bar(compartments, result', 'stacked');

xlabel('Compartments', 'FontSize', 14);
ylabel('Allocation (tons)', 'FontSize', 14);
title('Cargo Allocation Across Compartments', 'FontSize', 16);

legend({'C1', 'C2', 'C3', 'C4'}, 'Location', 'northeastoutside', 'NumColumns', 1);

grid on;