highPassFilter_RC = 2.8e-4;%3.5e3;
P = 1;
I = 0.003;
setPoint = -0.87;
fsampling = 125e6;
nDelay = 0150;

initialWaitTime = 8e-4;

laserNoise = table2array(readtable("laserNoise.csv"));
laserNoise_tia2 = table2array(readtable("laserNoise_tia2.csv"));
rpFloor = table2array(readtable("rpFloor.csv"));

actualLaserNoise = table2array(readtable("C:/Users/lastline/Documents/PID_first_test/laserNoise_tia1.csv"));
actualLaserNoise(:,2) = (actualLaserNoise(:,2) - mean(actualLaserNoise(:,2))) / (5600 * 0.2);
laserNoiseAvg = mean(actualLaserNoise(:,2));
fNoiseSampling = 1 / (rpFloor(2,1) - rpFloor(1,1));
alpha = 0.9998;%exp(-1/fsampling/highPassFilter_RC);


