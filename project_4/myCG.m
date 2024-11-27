function [x, rvec] = myCG(A, b, x0, max_itr, tol)
    x = x0;
    r = b - A * x0;
    d = r;
    rvec = [];
    p_old = dot(r, r);
    for k = 1:max_itr
        s = A * d;
        alpha = p_old / dot(d ,s);
        x = x + alpha * d;
        r = r - alpha * s;
        p_new = dot(r, r);
        rvec = [rvec, p_new];
        if sqrt(p_new) <= tol
            fprintf('Converged at iteration %d\n', k);
            break;
        end

        beta = p_new / p_old;
        d = r + beta * d;
        p_old = p_new;
    end
end