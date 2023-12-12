fileName = "C:\Users\lastline\Documents\SignalHound\laserNoise_1_200k_mv.csv";


M = table2array(readtable(fileName));
fs = 1e6;
bw = 1e0;%bin bandwidth, to approssimate the ffts with less samples

%add one last point to the data, to simulate the PSD going to 0 at higher frequencies
x = [M(:,1); fs/2];
y = [sqrt(M(:,2) / 2);0];
clear M;

l = ceil(fs / bw);
whiteNoise = randn(l,1);
Wn = fft(whiteNoise,l);

psdXvalues = [0:bw:x(end), (x(end) - bw):-bw:bw]';

W = Wn .* interp1(x,y,psdXvalues);
W(isnan(W)) = 0;%set to 0 every point that cannot be obtained by the interpolation (outside of the x range)

laserNoise = real(ifft(W));
%       debug plots
    % plot(bw:bw:fs, log10(max(abs(W),1e-10)));
    % hold on
    % plot(bw:bw:fs, log10(max(abs(Wn),1e-10)));
    % plot(bw:bw:fs, log10(max(interp1(x,y,psdXvalues), 1e-10)));
    % plot(log10(abs(fft(laserNoise)).^2));
    % hold off

% Create the data to be written to the CSV file
data = [(0:1/fs:(l-1)/fs)', laserNoise];

% Write the data to the CSV file
writematrix(data,'filename.mcsv', "FileType", "text");

