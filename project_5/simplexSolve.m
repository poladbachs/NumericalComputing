function [x_B,c_B,index_B] = simplexSolve (type,B,D,c_B,c_D,h,x_B,x_D,index_B,index_D,itMax)
% Solving a maximization problem with the simplex method

% Initialize the number of iterations
nIter = 0;

% Compute B^{-1}*D and B^{-1}*h
BiD = B\D;
Bih = B\h;

% TODO: Compute the reduced cost coefficients
r_D = c_D - c_B * BiD;

tol = max(size(r_D)); % the optimality condition is satisfied if all reduced cost coefficients are positive or negative (depending on the problem)

% TODO: Check the optimality condition, in order to skip the loop if the solution is already optimal)
if(strcmp(type,'max'))
    optCheck = all(r_D <= 0);
elseif(strcmp(type,'min'))
    optCheck = all(r_D >= 0);
else
    error('Incorrect type specified. Choose either a maximisation (max) or minimisation (min) problem.')
end

while(optCheck~=tol)
    disp(x_B);
    if optCheck
        break;
    end

    % TODO: Find the index of the entering variable
    if(strcmp(type,'max'))
        [~, idxIN] = max(r_D);
    elseif(strcmp(type,'min'))
        [~, idxIN] = min(r_D);
    else
        error('Incorrect type specified. Choose either a maximisation (max) or minimisation (min) problem.')
    end


    in = D(:,idxIN);
    c_in = c_D(1,idxIN);
    index_in = index_D(1,idxIN);
    
    % TODO: Evaluate the coefficients ratio for the column corresponding to the entering variable
    ratio = Bih./BiD(:,idxIN);

    % TODO: Find the smallest positive ratio
    for i = 1:length(ratio)
        if(ratio(i,1)<0)
            ratio(i,1) = Inf;
        end
    end
    idxOUT = find(ratio==min(ratio));
    
    out = B(:,idxOUT);
    c_out = c_B(1,idxOUT);
    index_out = index_B(1,idxOUT);
    
    % TODO: Update the matrices by exchanging the columns
    B(:,idxOUT) = in;
    D(:,idxIN) = out;
    c_B(1,idxOUT) = c_in;
    c_D(1,idxIN) = c_out;
    index_B(1,idxOUT) = index_in;
    index_D(1,idxIN) = index_out;
     
    % Compute B^{-1}*D and B^{-1}*h
    BiD = B\D;
    Bih = B\h;
    
    % TODO: Compute the reduced cost coefficients
    r_D = c_D - (c_B * BiD);

    % TODO: Check the optimality condition 
    if(strcmp(type,'max'))
        optCheck = all(r_D <= 0);
    elseif(strcmp(type,'min'))
        optCheck = all(r_D >= 0);
    else
        error('Incorrect type specified. Choose either a maximisation (max) or minimisation (min) problem.')
    end
    
    % Detect inefficient looping if nIter > total number of basic solutions
    nIter = nIter + 1;
    if nIter > itMax
        warning('Iteration limit exceeded. Stopping to avoid infinite loop.');
        return;
    end

    % TODO: Compute the new x_B
    x_B = Bih - (BiD * x_D);
end

end