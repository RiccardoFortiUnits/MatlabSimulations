highPassFilter_RC = 2.8e-4;%3.5e3;
P = 1;
I = 0.003;
setPoint = -0.87;
fsampling = 125e6;
nDelay = ceil(350*.5);

initialWaitTime = 8e-4;

laserNoise = table2array(readtable("laserNoise.csv"));
laserNoise_tia2 = table2array(readtable("laserNoise_tia2.csv"));
rpFloor = table2array(readtable("rpFloor.csv"));

actualLaserNoise = table2array(readtable("C:/Users/lastline/Documents/PID_first_test/laserNoise_tia1.csv"));
actualLaserNoise(:,2) = (actualLaserNoise(:,2) - mean(actualLaserNoise(:,2))) / (5600 * 0.2);
laserNoiseAvg = mean(actualLaserNoise(:,2));
fNoiseSampling = 1 / (rpFloor(2,1) - rpFloor(1,1));


tia3_g1 = 20e3;
tia3_g2 = 4.9;

% 
% sim('tia3_controller.slx');
% 
% 
% 
% % Access the saved signal data
% lnt = out.laserNoise.Data;
% firstTransient = find(out.laserNoise.Time > 4000/fsampling, 1, 'first');
% secondTransient = find(out.laserNoise.Time > initialWaitTime, 1, 'first') + firstTransient;
% lnt(1:(firstTransient-1)) = 0;
% lnt(firstTransient:(secondTransient-firstTransient)) = lnt(firstTransient:(secondTransient-firstTransient)) - mean(lnt(firstTransient:(secondTransient-firstTransient)));
% lnt(secondTransient-firstTransient + 1 : secondTransient - 1) = 0;
% lnt(secondTransient:end) = lnt(secondTransient:end) - mean(lnt(secondTransient:end));
% 
% 
% % Plot the modified data
% figure;
% plot(lnt);
% hold on
% plot(out.inputNoise.signals(1).values-mean(out.inputNoise.signals(1).values))
% hold off
% title('Modified Signal Data');
% xlabel('Time');
% ylabel('Amplitude');
% grid on;
% 
