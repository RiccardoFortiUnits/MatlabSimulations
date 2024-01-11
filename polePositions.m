%% find the position of the movable pole of the high-frequency controller
%high-frequency controller composed by:
%   noisy laser system (output: laser intensity)
%   tia circuit with high-pass filter (necessary to have a great gain, the DC is handled by another controller)
%   low-pass digital filter, whose gain and cutoff frequency can be adjusted
%we want for the magnitude of the overall open-loop system to reach 0dB at a certain frequency


G=1;%overall gain (variable)
circuitFrequency = 1e3;
freq_0dB = 200e3;

allGains = linspace(0.5,100,100);

root = zeros(length(allGains),1);
for i=1:length(allGains)
    G=allGains(i);
    f=@(x) abs(freq_0dB*1i*G*m./(20000i+1)./(freq_0dB*1i./x+1))-1;
    root(i) = fzero(f, [0,200000]);
end
plot(allGains,root)

Ts = 8e-9;
chosenGain = 10;
f=@(x) abs(freq_0dB*1i*G*m./(20000i+1)./(freq_0dB*1i./x+1))-1;
chosenPole = fzero(f, [0,200000]);
discreteCircuitPole = 1 - Ts * circuitFrequency;
discretePole = 1 - Ts * chosenPole
1 - discretePole