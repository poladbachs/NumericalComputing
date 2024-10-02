% Load the ETH500 dataset
load('ETH500.mat');

% Define alpha values to test
alpha_values = [0.8, 0.9, 0.95, 1];

% Preallocate an array to store the number of iterations
iterations_count = zeros(length(alpha_values), 1);

% Run the pagerank2 function for each alpha
for i = 1:length(alpha_values)
    alpha = alpha_values(i);
    disp(['Running pagerank2 for alpha = ', num2str(alpha)]);
    [page_rank, iterations] = pagerank2(U, G, alpha);
    iterations_count(i) = iterations;
    disp(['Iterations: ', num2str(iterations)]);
end

% Display the results
disp('Alpha Values:');
disp(alpha_values);
disp('Iterations Count:');
disp(iterations_count);