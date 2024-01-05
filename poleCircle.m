% Initialize arrays to store results
delays = 5:5:400;
centers_real = zeros(1, length(delays));
radii = zeros(1, length(delays));

% Parameters of system A(z)
Num_A = [I-P P]; % Numerator coefficients of A(z)
Den_A = [1 -1]; % Denominator coefficients of A(z)

% Iterate over different values of nDelay
idx=1;
for nDelay = delays

    % Define the denominator
    Num_G = conv([1 zeros(1, nDelay)], Den_A);
    denominator = Num_G + [zeros(1, length(Num_G) - length(Num_A)), Num_A];

    % Extract poles and add complex conjugates
    poles = roots(denominator);
    poles = [poles; conj(poles)];

    % Separate real and imaginary parts
    x = real(poles);
    y = imag(poles);

    % Function to minimize (squared differences between radii)
    objective = @(params) sum((sqrt((x - params(1)).^2 + (y - params(2)).^2) - params(3)).^2);

    % Initial guess for parameters (center and radius)
    initial_guess = [mean(x), mean(y), std(x)];

    % Minimize the objective function
    result = fminsearch(objective, initial_guess);

    % Extract the optimized parameters
    cx_opt = result(1);
    cy_opt = result(2);
    r_opt = result(3);

    % Store results
    centers_real(idx) = cx_opt;
    radii(idx) = r_opt;
    idx=idx+1;
end

% Plot the results
figure;
subplot(2, 1, 1);
plot(delays, centers_real, '-o');
xlabel('nDelay');
ylabel('Center (Real Part)');
title('Center of the Circle vs. nDelay');
grid on;

subplot(2, 1, 2);
plot(delays, radii, '-o');
xlabel('nDelay');
ylabel('Radius');
title('Radius of the Circle vs. nDelay');
grid on;

sgtitle('Pole-Zero Map Parameters vs. nDelay');
