P = 0.01;
I = 0.00005;
totalGain = db2pow(18.4);
alpha = 0.9998;
fs = 1/8e-9;
nDelay = 319;
sys = tf([P -P+I], [1 -alpha], 1/fs);
sys = totalGain * sys;

frequencies = logspace(0, 8, 1000); % Adjust the range as needed

% Compute the frequency response
[magnitude, phase] = bode(sys, frequencies);
magnitude = squeeze(magnitude);
phase = squeeze(phase);
%with a delay, the phase at which the output of the system is in
%counterphase to respect to the input is shifted:
%total delay of the closed loop system = delay + openLoopSysPhase(f)/(2*pi*f/fs)
%delay at which the magnitude has to be < 0dB to have stability = 1 / (2*f/fs)
%=> let's check the frequencies at which openLoopSysPhase == pi-2*pi*f*delay
instabilityCurve = 180 - 360*frequencies/fs*nDelay;
instabilityCurve = mod(instabilityCurve + 180, 360) - 180;
intersections = find_curve_intersections(phase, instabilityCurve);
semilogx(frequencies,phase)
hold on
semilogx(frequencies,instabilityCurve)

semilogx(frequencies(intersections),phase(intersections), 'go', 'MarkerSize', 10)

hold off

pointsToCheck = magnitude(intersections);
pointsToCheck(pointsToCheck >= 1)
