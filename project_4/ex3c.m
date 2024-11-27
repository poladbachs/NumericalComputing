lambda = eig(A_test);

figure;
bar(1:length(lambda), abs(lambda));
set(gca, 'YScale', 'log');
xlabel('Eigenvalue Index');
ylabel('Eigenvalues');
title('Eigenvalues of A-test Matrix');

minEigenValue = min(abs(lambda));
maxEigenValue = max(abs(lambda));
condNum = maxEigenValue / minEigenValue;

% Combine the text into a single string with line breaks
infoText = {
    ['Minimum Eig Value: ' num2str(minEigenValue, '%.5f')]
    ['Maximum Eig Value: ' num2str(maxEigenValue, '%.5f')]
    ['Condition Number: ' num2str(condNum, '%.5e')]
};

% Add the text at the top-left corner
annotation('textbox', [0.15, 0.8, 0.2, 0.1], ... % [x, y, width, height]
    'String', infoText, ...
    'FitBoxToText', 'on', ...
    'BackgroundColor', 'white', ...
    'EdgeColor', 'black', ...
    'HorizontalAlignment', 'left', ...
    'VerticalAlignment', 'top');