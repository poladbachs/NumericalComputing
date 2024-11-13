% Benchmark for recursively partitioning meshes, based on various
% bisection approaches
%
% D.P & O.S for Numerical Computing at USI

% add necessary paths
addpaths_GP;
nlevels_a = 3;
nlevels_b = 4;

fprintf('       *********************************************\n')
fprintf('       ***  Recursive graph bisection benchmark  ***\n');
fprintf('       *********************************************\n')

% load cases
cases = {
     'mesh1e1.mat',
     'bodyy4.mat',
     'de2010.mat',
     'biplane-9.mat',
     'L-9.mat',
    };

nc = length(cases);
maxlen = 0;
for c = 1:nc
    if length(cases{c}) > maxlen
        maxlen = length(cases{c});
    end
end

for c = 1:nc
    fprintf('.');
    sparse_matrices(c) = load(cases{c});
end


fprintf('\n\n Report Cases         Nodes     Edges\n');
fprintf(repmat('-', 1, 40));
fprintf('\n');
for c = 1:nc
    spacers  = repmat('.', 1, maxlen+3-length(cases{c}));
    [params] = Initialize_case(sparse_matrices(c));
    fprintf('%s %s %10d %10d\n', cases{c}, spacers,params.numberOfVertices,params.numberOfEdges);
end

%% Create results table headers
fprintf('\n%7s %16s %20s %16s %16s\n','Bisection','Spectral','Metis 5.0.2','Coordinate','Inertial');
fprintf('%10s %10d %6d %10d %6d %10d %6d %10d %6d\n','Partitions',8,16,8,16,8,16,8,16);
fprintf(repmat('-', 1, 100));
fprintf('\n');

% Initialize results table
results_table = zeros(nc, 8);

% Recursive bisection and edge cut calculation for each mesh
for c = 1:nc
    spacers = repmat('.', 1, maxlen+3-length(cases{c}));
    fprintf('%s %s', cases{c}, spacers);
    sparse_matrix = load(cases{c});
    

    % Recursively bisect the loaded graphs in 8 and 16 subgraphs.
    % Steps
    % STEP 1. Initialize the problem
    [params] = Initialize_case(sparse_matrices(c));
    W = params.Adj;
    coords = params.coords; 
    % STEP 2. Recursive bisections
    % 1. Coordinate    
    % p = 8
    Coord8 = rec_bisection(@bisection_coordinate, 3, W, coords, 0);
    % p = 16
    Coord16 = rec_bisection(@bisection_coordinate, 4, W, coords, 0);
    % 2. Metis
    % p = 8
    Metis8 = rec_bisection(@bisection_metis, 3, W, coords, 0);
    % p = 16
    Metis16 = rec_bisection(@bisection_metis, 4, W, coords, 0);
    % 3. Spectral
    % p = 8
    SR8 = rec_bisection(@bisection_spectral, 3, W, coords, 0);
    % p = 16
    SR16 = rec_bisection(@bisection_spectral, 4, W, coords, 0);
    % 4. Inertial
    % p = 8
    Inertial8 = rec_bisection(@bisection_inertial, 3, W, coords, 0);
    % p = 16
    Inertial16 = rec_bisection(@bisection_inertial, 4, W, coords, 0);
    % STEP 3. Calculate number of cut edges
    spectral8cutsize = cutsize(W, SR8);
    spectral16cutsize = cutsize(W, SR16);

    metis8cutsize = cutsize(W, Metis8);
    metis16cutsize = cutsize(W, Metis16);

    coords8cutsize = cutsize(W, Coord8);
    coords16cutsize = cutsize(W, Coord16);

    inertial8cutsize = cutsize(W, Inertial8);
    inertial16cutsize = cutsize(W, Inertial16);
    
    % Save results in the table
    results_table(c, :) = [coords8cutsize, coords16cutsize, ...
                           metis8cutsize, metis16cutsize, ...
                           spectral8cutsize, spectral16cutsize, ...
                           inertial8cutsize, inertial16cutsize];

    % Update visualizations for 'de2010.mat' case
    if strcmp(cases{c}, 'de2010.mat')
        figure(1); clf;
        gplotmap(W, coords, Coord8);
        title('Coordinate Bisection - 8 Partitions');
        disp(' Hit space to continue ...');
        pause;

        figure(1); clf;
        gplotmap(W, coords, Coord16);
        title('Coordinate Bisection - 16 Partitions');
        disp(' Hit space to continue ...');
        pause;

        figure(1); clf;
        gplotmap(W, coords, Metis8);
        title('Metis Bisection - 8 Partitions');
        disp(' Hit space to continue ...');
        pause;

        figure(1); clf;
        gplotmap(W, coords, Metis16);
        title('Metis Bisection - 16 Partitions');
        disp(' Hit space to continue ...');
        pause;

        figure(1); clf;
        gplotmap(W, coords, SR8);
        title('Spectral Bisection - 8 Partitions');
        disp(' Hit space to continue ...');
        pause;

        figure(1); clf;
        gplotmap(W, coords, SR16);
        title('Spectral Bisection - 16 Partitions');
        disp(' Hit space to continue ...');
        pause;

        figure(1); clf;
        gplotmap(W, coords, Inertial8);
        title('Inertial Bisection - 8 Partitions');
        disp(' Hit space to continue ...');
        pause;

        figure(1); clf;
        gplotmap(W, coords, Inertial16);
        title('Inertial Bisection - 16 Partitions');
        disp(' Hit space to continue ...');
        pause;
    end
    
    fprintf('%6d %6d %10d %6d %10d %6d %10d %6d\n',spectral8cutsize,spectral16cutsize,...
    metis8cutsize,metis16cutsize,coords8cutsize,coords16cutsize,inertial8cutsize,inertial16cutsize);
    
end

% Display overall results in a table format after all calculations
fprintf('\nTable 2: Recursive bisection results for each method and mesh.\n');
fprintf('%12s %10s %10s %10s %10s %10s %10s %10s %10s\n', 'Mesh', 'Coord-8', 'Coord-16', 'Metis-8', 'Metis-16', 'Spectral-8', 'Spectral-16', 'Inertial-8', 'Inertial-16');

for c = 1:nc
    fprintf('%12s %10d %10d %10d %10d %10d %10d %10d %10d\n', cases{c}, results_table(c, :));
end