
a = 0.999;
k=10;

Num_A = [0 k*(1-a)]; % Numerator coefficients of A(z)
Den_A = [1 -a]; % Denominator coefficients of A(z)

delays = 5:20:350;
angles = zeros(length(delays),1);
magnitudes = zeros(length(delays),1);

for i = 1:length(delays)
    n = delays(i);
    Num_G = conv([1 zeros(1, n)], Den_A);
    Den_G = Num_G + [zeros(1, length(Num_G) - length(Num_A)), Num_A];
    poles = roots(Den_G);
    mods = mod(angle(poles), 2*pi);
    mods(mods == 0) = 2*pi;
    angles(i) = min(mods);
    magnitudes(i) = max(abs(poles));
end
plot(delays, angles);
hold on
plot(delays, pi./delays);
instabilities = delays(magnitudes>=1);
plot(instabilities, zeros(length(instabilities),1), 'bx');
hold off