delaySteps = 319;
highPassFilter_RC = 2.8e-4;%3.5e3;
P = 0.4;
I = 0.01;
fsampling = 125e6;
nDelay = 150;

laserNoise = table2array(readtable("laserNoise.csv"));
rpFloor = table2array(readtable("rpFloor.csv"));

fNoiseSampling = 1 / (rpFloor(2,1) - rpFloor(1,1));
alpha = 0.9998;%exp(-1/fsampling/highPassFilter_RC);


