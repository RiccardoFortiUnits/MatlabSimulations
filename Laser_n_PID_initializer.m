highPassFilter_RC = 2.8e-4;%3.5e3;
P = 1;
I = 0.003;
setPoint = -0.87;
fsampling = 125e6;
nDelay = 150;

laserNoise = table2array(readtable("laserNoise.csv"));
laserNoise_tia2 = table2array(readtable("laserNoise_tia2.csv"));
rpFloor = table2array(readtable("rpFloor.csv"));

fNoiseSampling = 1 / (rpFloor(2,1) - rpFloor(1,1));
alpha = 0.9998;%exp(-1/fsampling/highPassFilter_RC);


