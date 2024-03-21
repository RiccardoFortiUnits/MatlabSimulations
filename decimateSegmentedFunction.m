function [a,c] = decimateSegmentedFunction(x,y, finalLength)
    % reduces the number of samples used to represent a nonlinear 
    % function y = f(x), starting from a more precise approximation (x,y)
    % The final "sample points" a and their respective values c = f(a) are
    % chosen to reduce the overall error respect to the initial
    % approximation
n = finalLength;

useSecondDerivativeDistribution = false;

if(useSecondDerivativeDistribution)%return slightly better results since it chooses the initial 
    % guess of fsolve by analyzing the 2nd derivative of the function (a low derivative in a 
    % certain point means that the function is almost a segment, and so there's no need to have 
    % an edge of the segmented function there)
    y1 = [(y(2:end) - y(1:end-1)) ./ (x(2:end) - x(1:end-1)), 0];
    y2 = [0, (y1(2:end) - y1(1:end-1)) ./ (x(2:end) - x(1:end-1))];
    
    % y1 = exp(- (y1 .^ 2));y1(end) = 0;
    y2 = abs(y2);
    y2 = y2 / sum(y2);
    % plot(x,y1/sum(y1))
    % plot(x,y2/sum(y2))
    
    distribution = y2 + 0.5 / length(y);
    
    distribution = distribution / sum(distribution);
    
    % plot(x,distribution)
    
    distribution = cumsum(distribution);
    distribution(1) = 0;
    distribution(end) = 1;
    
    initialGuess = segmentedFunction_(linspace(0,1,n), distribution, x);
    % initialGuess = [x(1), initialGuess, x(end)];
    
    % plot(initialGuess,segmentedFunction_(initialGuess,x,y))
    
    initialGuess = [initialGuess;segmentedFunction_(initialGuess,x,y)];
else
    initialGuess = [linspace(x(1), x(end), n);segmentedFunction_(linspace(x(1), x(end), n),x,y)];
end

initialGuess(:,1) = [];%remove initial and final values, since they will be fixed
initialGuess(:,end) = [];

f = @(X) (segmentedFunction_(x,[x(1), X(1,:), x(end)], [y(1), X(2,:), y(end)]) - y);

options = optimset('Display', 'off');
res = fsolve(f, initialGuess, options);

sum(abs(f(res)))

a = [x(1), res(1,:), x(end)];
c = [y(1), res(2,:), y(end)];
end

function y = segmentedFunction_(x,a,c)
    if(~issorted(a))
        y = ones(size(x))*inf;
        return
    end
    aIndex = sum(a' <= x);
    if(aIndex(end) == length(a))
        aIndex(end) = length(a) - 1;
    end
    A = a(aIndex);
    B = a(aIndex+1);
    C = c(aIndex);
    D = c(aIndex+1);
    m=(D-C)./(B-A);
    y = C + m.*(x-A);
end

