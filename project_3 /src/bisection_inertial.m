function [part1, part2] = bisection_inertial(A, xy, picture)
    % bisection_inertial: Inertial partition of a graph.
    %
    % [part1, part2] = bisection_inertial(A, xy, picture) returns a list of the vertices on 
    % one side of a partition obtained by bisection with a line normal to a moment 
    % of inertia of the vertices, considered as points in Euclidean space.
    %
    % A is the adjacency matrix (used only for the picture),
    % and each row of xy contains the coordinates of a point in d-space.

    disp(' ');
    disp(' Numerical Computing @ USI Lugano:   ');
    disp(' Implementing inertial bisection');
    disp(' ');

    % Step 1: Calculate the center of mass
    x_mean = mean(xy(:, 1));
    y_mean = mean(xy(:, 2));

    % Step 2: Construct the matrix M
    Sxx = sum((xy(:, 1) - x_mean).^2);
    Syy = sum((xy(:, 2) - y_mean).^2);
    Sxy = sum((xy(:, 1) - x_mean) .* (xy(:, 2) - y_mean));
    M = [Sxx, Sxy; Sxy, Syy];

    % Step 3: Calculate the smallest eigenvector of M
    [V, ~] = eig(M);
    u = V(:, 1);

    % Step 4: Compute the perpendicular vector to u
    dividing_vector = [-u(2); u(1)];

    % Step 5: Partition points around the dividing line using partition.m
    [part1, part2] = partition(xy, dividing_vector);

    % Step 6: Plot the partition if requested
    if picture == 1
        gplotpart(A, xy, part1);
        title('Inertial bisection based on center of mass');
    end
end