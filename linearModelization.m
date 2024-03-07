

% table = table2array(readtable("C:\Users\lastline\Documents\aom_acquisitions\C2--whiteNoise.csv"));
% delay = 0;
% size = 30000;
% x = table(         1:size,  1);
% y = table(delay + (1:size), 2);
% y = y / mean(y.^2);

size=4000;
x=randn(size,1);
y=zeros(size,1);
y(3:size)=x(1:size-2)-x(2:size-1);
for(i = 3:size)
    y(i) = y(i)+0.1*y(i-1);
end

delay=0;
s = estimate_iir_transfer_function(x,y,3,1);


function sys = estimate_iir_transfer_function(u, y, M, N)
    usedSamples = length(y) - max(M,N+1);
    A = zeros(usedSamples, M + N);
    for i = 1:M
        A(:, i) = u(length(y) - i - usedSamples + 2: length(y) - i + 1);
    end
    for i = 1:N
        A(:, M+i) = y(length(y) - i - usedSamples + 1 : length(y) - i);
    end
    B = y(length(y) - usedSamples + 1: length(y));

    x = A \ B;
    plot(x)

    sys = tf(x(1:M)',[1; x(M+1:M+N)]',0.1)
    % u: Input signal (column vector)
    % y: Output signal (column vector)
    % M: Order of numerator polynomial (number of zeros)
    % N: Order of denominator polynomial (number of poles)

    % Estimate transfer function using least squares
    % sys = tfest(u, y, N, M, 1, 'Ts', 1);

    % Display the estimated transfer function
    disp('Estimated Transfer Function:');
    disp(sys);

    mean((A * x - B).^2)

end
