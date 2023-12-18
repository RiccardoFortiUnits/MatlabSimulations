fileName = "C:\Users\lastline\Documents\SignalHound\laserNoise_1_200k_mv.csv";
finalWaveFileName = 'oneRow.wfm'
nOfSamples = cast(0x400 * 8, "double");
M = table2array(readtable(fileName));
fs = 1e6;
period = nOfSamples / fs
bw = 1e0;%bin bandwidth, to approssimate the ffts with less samples

%add one last point to the data, to simulate the PSD going to 0 at higher
%frequencies

x = [M(:,1); fs/2];%slow fade to 0 (linear descent)
y = [sqrt(M(:,2) / 2);0];

% x = [M(:,1); M(end,1) + 0.1;fs/2];%really fast fade to 0 (immediately after the end of data)
% y = [sqrt(M(:,2) / 2);0;0];

clear M;

l = ceil(fs / bw);
whiteNoise = randn(l,1);
Wn = fft(whiteNoise,l);

psdXvalues = [0:bw:x(end), (x(end) - bw):-bw:bw]';

W = Wn .* interp1(x,y,psdXvalues);
W(isnan(W)) = 0;%set to 0 every point that cannot be obtained by the interpolation (outside of the x range)

laserNoise = real(ifft(W));%real part, just for safety

%       debug plots
    % plot(bw:bw:fs, log10(max(abs(W),1e-10)));
    % hold on
    % plot(bw:bw:fs, log10(max(abs(Wn),1e-10)));
    % plot(bw:bw:fs, log10(max(interp1(x,y,psdXvalues), 1e-10)));
    % plot(log10(abs(fft(laserNoise)).^2));
    % hold off

finalSamples = laserNoise(1:nOfSamples)';
M = max(max(finalSamples), -min(finalSamples));
%amplitude normalization
% finalSamples = floor(finalSamples / M * 10000)/10000;%normalize output, for generic amplitude

finalSamples = floor(finalSamples /25e-3 * 10000)/10000;%we can't give the real values to the asg, because 
% they are too low to be sampled. On the ASG we can set a minimum maxAmplitude of 25mV (50mVpp), so if you 
% set this amplitude, the signal amplitude will be the correct one, and with the best possible resolution

writematrix(finalSamples,finalWaveFileName, "FileType", "text");
data = [(0:1/fs:(nOfSamples-1)/fs)',finalSamples'];
writematrix(data,"filename.mcsv", "FileType", "text");

