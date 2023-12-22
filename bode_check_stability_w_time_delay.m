P = 0.1;
Z = 0.02;
alpha = 0.9998;
fs = 1/8e-9;
nDelay = 319;
sys = tf([P -P+I], [1 -alpha], 1/fs);

frequencies = logspace(0, 8, 1000); % Adjust the range as needed

% Compute the frequency response
[magnitude, phase] = bode(sys, frequencies);
magnitude = squeeze(magnitude);
phase = squeeze(phase);
semilogx(frequencies,phase)
hold on
% semilogx(frequencies,(180-360*frequencies/fs*nDelay))
semilogx(frequencies,mod((180-360*frequencies/fs*nDelay) + 180, 360) - 180)
hold off