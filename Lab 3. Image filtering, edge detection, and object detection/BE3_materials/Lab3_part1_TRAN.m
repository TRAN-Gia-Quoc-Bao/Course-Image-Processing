%% Lab 3 - Tran Gia Quoc Bao (part 1)

%% Default commands
close all;
clear all;
clc;

%% Preparation
IFigure1 = double(imread('Figure1.jpg'))/255;

figure();
subplot(121);
imshow(IFigure1);
title('The given Figure 1');
subplot(122);
imhist(IFigure1);
title('The histogram of the given Figure 1');

sigmaFigure1 = 1;
IFigure1Gaussian = double(IFigure1) + sigmaFigure1*randn(size(IFigure1));

figure();
subplot(121);
imshow(IFigure1Gaussian);
title('The given Figure 1 with added Gaussian noise');
subplot(122);
imhist(IFigure1Gaussian);
title('The histogram of the given Figure 1 with added Gaussian noise');

IFigure1Pepper = imnoise(IFigure1,'salt & pepper', 0.05);

figure();
subplot(121);
imshow(IFigure1Pepper);
title('The given Figure 1 with added salt & pepper noise');
subplot(122);
imhist(IFigure1Pepper);
title('The histogram of the given Figure 1 with added salt & pepper noise');

lowerBoundFigure1 = 0.5;
upperBoundFigure1 = 1;
IFigure1Uniform = double(IFigure1) + lowerBoundFigure1 + randn(size(IFigure1))*(upperBoundFigure1 - lowerBoundFigure1);

figure();
subplot(121);
imshow(IFigure1Uniform);
title('The given Figure 1 with added uniform noise');
subplot(122);
imhist(IFigure1Uniform);
title('The histogram of the given Figure 1 with added uniform noise');

%% I. Noise filtering
%% 1.1 Noise simulation
sigma1 = 10;
sigma2 = 20;
dens1 = 0.1;
dens2 = 0.2;

%% Add noise to the cameraman image
ICamera = double(imread('cameraman.png'))/255;
ICameraGaussian1 = ICamera + sigma1*randn(size(ICamera))/255;
ICameraGaussian2 = ICamera + sigma2*randn(size(ICamera))/255;
ICameraPepper1 = imnoise(ICamera,'salt & pepper', dens1);
ICameraPepper2 = imnoise(ICamera,'salt & pepper', dens2);

figure();
subplot(231);
imshow(ICamera);
title('The original cameraman image');
subplot(232);
imshow(ICameraGaussian1);
title('Cameraman image, Gaussian noise, sigma1 = 10');
subplot(233);
imshow(ICameraGaussian2);
title('Cameraman image, Gaussian noise, sigma2 = 20');
subplot(234);
imhist(ICamera);
title('Histogram of the image above');
subplot(235);
imhist(ICameraGaussian1);
title('Histogram of the image above');
subplot(236);
imhist(ICameraGaussian2);
title('Histogram of the image above');

figure();
subplot(231);
imshow(ICamera);
title('The original cameraman image');
subplot(232);
imshow(ICameraPepper1);
title('Cameraman image, P & S noise, dens1 = 0.1');
subplot(233);
imshow(ICameraPepper2);
title('Cameraman image, P & S noise, dens2 = 0.2');
subplot(234);
imhist(ICamera);
title('Histogram of the image above');
subplot(235);
imhist(ICameraPepper1);
title('Histogram of the image above');
subplot(236);
imhist(ICameraPepper2);
title('Histogram of the image above');

%% Add noise to the baboon image
IBaboon = double(imread('baboon.tif'))/255;
IBaboonGaussian1 = IBaboon + sigma1*randn(size(IBaboon))/255;
IBaboonGaussian2 = IBaboon + sigma2*randn(size(IBaboon))/255;
IBaboonPepper1 = imnoise(IBaboon,'salt & pepper', dens1);
IBaboonPepper2 = imnoise(IBaboon,'salt & pepper', dens2);

figure();
subplot(231);
imshow(IBaboon);
title('The original baboon image');
subplot(232);
imshow(IBaboonGaussian1);
title('Baboon image, Gaussian noise, sigma1 = 10');
subplot(233);
imshow(IBaboonGaussian2);
title('Baboon image, Gaussian noise, sigma2 = 20');
subplot(234);
imhist(IBaboon);
title('Histogram of the image above');
subplot(235);
imhist(IBaboonGaussian1);
title('Histogram of the image above');
subplot(236);
imhist(IBaboonGaussian2);
title('Histogram of the image above');

figure();
subplot(231);
imshow(IBaboon);
title('The original baboon image');
subplot(232);
imshow(IBaboonPepper1);
title('Baboon image, P & S noise, dens1 = 0.1');
subplot(233);
imshow(IBaboonPepper2);
title('Baboon image, P & S noise, dens2 = 0.2');
subplot(234);
imhist(IBaboon);
title('Histogram of the image above');
subplot(235);
imhist(IBaboonPepper1);
title('Histogram of the image above');
subplot(236);
imhist(IBaboonPepper2);
title('Histogram of the image above');

%% %% Add noise to the cafe image
ICafe = double(imread('cafe.tif'))/255;
ICafeGaussian1 = ICafe + sigma1*randn(size(ICafe))/255;
ICafeGaussian2 = ICafe + sigma2*randn(size(ICafe))/255;
ICafePepper1 = imnoise(ICafe,'salt & pepper', dens1);
ICafePepper2 = imnoise(ICafe,'salt & pepper', dens2);

figure();
subplot(231);
imshow(ICafe);
title('The original cafe image');
subplot(232);
imshow(ICafeGaussian1);
title('Cafe image, Gaussian noise, sigma1 = 10');
subplot(233);
imshow(ICafeGaussian2);
title('Cafe image, Gaussian noise, sigma2 = 20');
subplot(234);
imhist(ICafe);
title('Histogram of the image above');
subplot(235);
imhist(ICafeGaussian1);
title('Histogram of the image above');
subplot(236);
imhist(ICafeGaussian2);
title('Histogram of the image above');

figure();
subplot(231);
imshow(ICafe);
title('The original cafe image');
subplot(232);
imshow(ICafePepper1);
title('Cafe image, P & S noise, dens1 = 0.1');
subplot(233);
imshow(ICafePepper2);
title('Cafe image, P & S noise, dens2 = 0.2');
subplot(234);
imhist(ICafe);
title('Histogram of the image above');
subplot(235);
imhist(ICafePepper1);
title('Histogram of the image above');
subplot(236);
imhist(ICafePepper2);
title('Histogram of the image above');

%% 1.2 Denoising
%% Mean filtering

s1 = 3; filter1 = ones(s1)/(s1^2);
s2 = 4; filter2 = ones(s2)/(s2^2);
s3 = 5; filter3 = ones(s3)/(s3^2);
%% The cameraman image
ICameraGaussianMeanFiltered1 = imfilter(ICameraGaussian2, filter1, 'replicate');
ICameraGaussianMeanFiltered2 = imfilter(ICameraGaussian2, filter2, 'replicate');
ICameraGaussianMeanFiltered3 = imfilter(ICameraGaussian2, filter3, 'replicate');

ICameraPepperMeanFiltered1 = imfilter(ICameraPepper2, filter1, 'replicate');
ICameraPepperMeanFiltered2 = imfilter(ICameraPepper2, filter2, 'replicate');
ICameraPepperMeanFiltered3 = imfilter(ICameraPepper2, filter3, 'replicate');

figure();
subplot(241);
imshow(ICamera);
title('The original cameraman image');
subplot(242);
imshow(ICameraGaussianMeanFiltered1);
title('Mean filtered, n1 = 3');
subplot(243);
imshow(ICameraGaussianMeanFiltered2);
title('Mean filtered, n2 = 4');
subplot(244);
imshow(ICameraGaussianMeanFiltered3);
title('Mean filtered, n3 = 5');
subplot(245);
imhist(ICamera);
title('Histogram of the image above');
subplot(246);
imhist(ICameraGaussianMeanFiltered1);
title('Histogram of the image above');
subplot(247);
imhist(ICameraGaussianMeanFiltered2);
title('Histogram of the image above');
subplot(248);
imhist(ICameraGaussianMeanFiltered3);
title('Histogram of the image above');

figure();
subplot(241);
imshow(ICamera);
title('The original cameraman image');
subplot(242);
imshow(ICameraPepperMeanFiltered1);
title('Mean filtered, n1 = 3');
subplot(243);
imshow(ICameraPepperMeanFiltered2);
title('Mean filtered, n2 = 4');
subplot(244);
imshow(ICameraPepperMeanFiltered3);
title('Mean filtered, n3 = 5');
subplot(245);
imhist(ICamera);
title('Histogram of the image above');
subplot(246);
imhist(ICameraPepperMeanFiltered1);
title('Histogram of the image above');
subplot(247);
imhist(ICameraPepperMeanFiltered2);
title('Histogram of the image above');
subplot(248);
imhist(ICameraPepperMeanFiltered3);
title('Histogram of the image above');

%% The baboon image
IBaboonGaussianMeanFiltered1 = imfilter(IBaboonGaussian2, filter1, 'replicate');
IBaboonGaussianMeanFiltered2 = imfilter(IBaboonGaussian2, filter2, 'replicate');
IBaboonGaussianMeanFiltered3 = imfilter(IBaboonGaussian2, filter3, 'replicate');

IBaboonPepperMeanFiltered1 = imfilter(IBaboonPepper2, filter1, 'replicate');
IBaboonPepperMeanFiltered2 = imfilter(IBaboonPepper2, filter2, 'replicate');
IBaboonPepperMeanFiltered3 = imfilter(IBaboonPepper2, filter3, 'replicate');

figure();
subplot(241);
imshow(IBaboon);
title('The original baboon image');
subplot(242);
imshow(IBaboonGaussianMeanFiltered1);
title('Mean filtered, n1 = 3');
subplot(243);
imshow(IBaboonGaussianMeanFiltered2);
title('Mean filtered, n2 = 4');
subplot(244);
imshow(IBaboonGaussianMeanFiltered3);
title('Mean filtered, n3 = 5');
subplot(245);
imhist(IBaboon);
title('Histogram of the image above');
subplot(246);
imhist(IBaboonGaussianMeanFiltered1);
title('Histogram of the image above');
subplot(247);
imhist(IBaboonGaussianMeanFiltered2);
title('Histogram of the image above');
subplot(248);
imhist(IBaboonGaussianMeanFiltered3);
title('Histogram of the image above');

figure();
subplot(241);
imshow(IBaboon);
title('The original baboon image');
subplot(242);
imshow(IBaboonPepperMeanFiltered1);
title('Mean filtered, n1 = 3');
subplot(243);
imshow(IBaboonPepperMeanFiltered2);
title('Mean filtered, n2 = 4');
subplot(244);
imshow(IBaboonPepperMeanFiltered3);
title('Mean filtered, n3 = 5');
subplot(245);
imhist(IBaboon);
title('Histogram of the image above');
subplot(246);
imhist(IBaboonPepperMeanFiltered1);
title('Histogram of the image above');
subplot(247);
imhist(IBaboonPepperMeanFiltered2);
title('Histogram of the image above');
subplot(248);
imhist(IBaboonPepperMeanFiltered3);
title('Histogram of the image above');

%% The cafe image
ICafeGaussianMeanFiltered1 = imfilter(ICafeGaussian2, filter1, 'replicate');
ICafeGaussianMeanFiltered2 = imfilter(ICafeGaussian2, filter2, 'replicate');
ICafeGaussianMeanFiltered3 = imfilter(ICafeGaussian2, filter3, 'replicate');

ICafePepperMeanFiltered1 = imfilter(ICafePepper2, filter1, 'replicate');
ICafePepperMeanFiltered2 = imfilter(ICafePepper2, filter2, 'replicate');
ICafePepperMeanFiltered3 = imfilter(ICafePepper2, filter3, 'replicate');

figure();
subplot(241);
imshow(ICafe);
title('The original cafe image');
subplot(242);
imshow(ICafeGaussianMeanFiltered1);
title('Mean filtered, n1 = 3');
subplot(243);
imshow(ICafeGaussianMeanFiltered2);
title('Mean filtered, n2 = 4');
subplot(244);
imshow(ICafeGaussianMeanFiltered3);
title('Mean filtered, n3 = 5');
subplot(245);
imhist(ICafe);
title('Histogram of the image above');
subplot(246);
imhist(ICafeGaussianMeanFiltered1);
title('Histogram of the image above');
subplot(247);
imhist(ICafeGaussianMeanFiltered2);
title('Histogram of the image above');
subplot(248);
imhist(ICafeGaussianMeanFiltered3);
title('Histogram of the image above');

figure();
subplot(241);
imshow(ICafe);
title('The original baboon image');
subplot(242);
imshow(ICafePepperMeanFiltered1);
title('Mean filtered, n1 = 3');
subplot(243);
imshow(ICafePepperMeanFiltered2);
title('Mean filtered, n2 = 4');
subplot(244);
imshow(ICafePepperMeanFiltered3);
title('Mean filtered, n3 = 5');
subplot(245);
imhist(ICafe);
title('Histogram of the image above');
subplot(246);
imhist(ICafePepperMeanFiltered1);
title('Histogram of the image above');
subplot(247);
imhist(ICafePepperMeanFiltered2);
title('Histogram of the image above');
subplot(248);
imhist(ICafePepperMeanFiltered3);
title('Histogram of the image above');

%% Median filtering
m1 = 3; n1 = 2; 
m2 = 4; n2 = 3;
m3 = 5; n3 = 4;

%% The cameraman image
ICameraGaussianMedFiltered1 = medfilt2(ICameraGaussian2, [m1 n1]);
ICameraGaussianMedFiltered2 = medfilt2(ICameraGaussian2, [m2 n2]);
ICameraGaussianMedFiltered3 = medfilt2(ICameraGaussian2, [m3 n3]);

ICameraPepperMedFiltered1 = medfilt2(ICameraPepper2, [m1 n1]);
ICameraPepperMedFiltered2 = medfilt2(ICameraPepper2, [m2 n2]);
ICameraPepperMedFiltered3 = medfilt2(ICameraPepper2, [m3 n3]);

figure();
subplot(241);
imshow(ICamera);
title('The original cameraman image');
subplot(242);
imshow(ICameraGaussianMedFiltered1);
title('Median filtered, [3 2]');
subplot(243);
imshow(ICameraGaussianMedFiltered2);
title('Median filtered, [4 3]');
subplot(244);
imshow(ICameraGaussianMedFiltered3);
title('Median filtered, [5 4]');
subplot(245);
imhist(ICamera);
title('Histogram of the image above');
subplot(246);
imhist(ICameraGaussianMedFiltered1);
title('Histogram of the image above');
subplot(247);
imhist(ICameraGaussianMedFiltered2);
title('Histogram of the image above');
subplot(248);
imhist(ICameraGaussianMedFiltered3);
title('Histogram of the image above');

figure();
subplot(241);
imshow(ICamera);
title('The original cameraman image');
subplot(242);
imshow(ICameraPepperMedFiltered1);
title('Median filtered, [3 2]');
subplot(243);
imshow(ICameraPepperMedFiltered2);
title('Median filtered, [4 3]');
subplot(244);
imshow(ICameraPepperMedFiltered3);
title('Median filtered, [5 4]');
subplot(245);
imhist(ICamera);
title('Histogram of the image above');
subplot(246);
imhist(ICameraPepperMedFiltered1);
title('Histogram of the image above');
subplot(247);
imhist(ICameraPepperMedFiltered2);
title('Histogram of the image above');
subplot(248);
imhist(ICameraPepperMedFiltered3);
title('Histogram of the image above');

%% The baboon image
IBaboonGaussianMedFiltered1 = medfilt2(IBaboonGaussian2, [m1 n1]);
IBaboonGaussianMedFiltered2 = medfilt2(IBaboonGaussian2, [m2 n2]);
IBaboonGaussianMedFiltered3 = medfilt2(IBaboonGaussian2, [m3 n3]);

IBaboonPepperMedFiltered1 = medfilt2(IBaboonPepper2, [m1 n1]);
IBaboonPepperMedFiltered2 = medfilt2(IBaboonPepper2, [m2 n2]);
IBaboonPepperMedFiltered3 = medfilt2(IBaboonPepper2, [m3 n3]);

figure();
subplot(241);
imshow(IBaboon);
title('The original baboon image');
subplot(242);
imshow(IBaboonGaussianMedFiltered1);
title('Median filtered, [3 2]');
subplot(243);
imshow(IBaboonGaussianMedFiltered2);
title('Median filtered, [4 3]');
subplot(244);
imshow(IBaboonGaussianMedFiltered3);
title('Median filtered, [5 4]');
subplot(245);
imhist(IBaboon);
title('Histogram of the image above');
subplot(246);
imhist(IBaboonGaussianMedFiltered1);
title('Histogram of the image above');
subplot(247);
imhist(IBaboonGaussianMedFiltered2);
title('Histogram of the image above');
subplot(248);
imhist(IBaboonGaussianMedFiltered3);
title('Histogram of the image above');

figure();
subplot(241);
imshow(IBaboon);
title('The original cameraman image');
subplot(242);
imshow(IBaboonPepperMedFiltered1);
title('Median filtered, [3 2]');
subplot(243);
imshow(IBaboonPepperMedFiltered2);
title('Median filtered, [4 3]');
subplot(244);
imshow(IBaboonPepperMedFiltered3);
title('Median filtered, [5 4]');
subplot(245);
imhist(IBaboon);
title('Histogram of the image above');
subplot(246);
imhist(IBaboonPepperMeanFiltered1);
title('Histogram of the image above');
subplot(247);
imhist(IBaboonPepperMeanFiltered2);
title('Histogram of the image above');
subplot(248);
imhist(IBaboonPepperMeanFiltered3);
title('Histogram of the image above');

%% The cafe image
ICafeGaussianMedFiltered1 = medfilt2(ICafeGaussian2, [m1 n1]);
ICafeGaussianMedFiltered2 = medfilt2(ICafeGaussian2, [m2 n2]);
ICafeGaussianMedFiltered3 = medfilt2(ICafeGaussian2, [m3 n3]);

ICafePepperMedFiltered1 = medfilt2(ICafePepper2, [m1 n1]);
ICafePepperMedFiltered2 = medfilt2(ICafePepper2, [m2 n2]);
ICafePepperMedFiltered3 = medfilt2(ICafePepper2, [m3 n3]);

figure();
subplot(241);
imshow(ICafe);
title('The original cafe image');
subplot(242);
imshow(ICafeGaussianMedFiltered1);
title('Median filtered, [3 2]');
subplot(243);
imshow(ICafeGaussianMedFiltered2);
title('Median filtered, [4 3]');
subplot(244);
imshow(ICafeGaussianMedFiltered3);
title('Median filtered, [5 4]');
subplot(245);
imhist(ICafe);
title('Histogram of the image above');
subplot(246);
imhist(ICafeGaussianMedFiltered1);
title('Histogram of the image above');
subplot(247);
imhist(ICafeGaussianMedFiltered2);
title('Histogram of the image above');
subplot(248);
imhist(ICafeGaussianMedFiltered3);
title('Histogram of the image above');

figure();
subplot(241);
imshow(ICafe);
title('The original cameraman image');
subplot(242);
imshow(ICafePepperMedFiltered1);
title('Median filtered, [3 2]');
subplot(243);
imshow(ICafePepperMedFiltered2);
title('Median filtered, [4 3]');
subplot(244);
imshow(ICafePepperMedFiltered3);
title('Median filtered, [5 4]');
subplot(245);
imhist(ICafe);
title('Histogram of the image above');
subplot(246);
imhist(ICafePepperMeanFiltered1);
title('Histogram of the image above');
subplot(247);
imhist(ICafePepperMeanFiltered2);
title('Histogram of the image above');
subplot(248);
imhist(ICafePepperMeanFiltered3);
title('Histogram of the image above');

%% 1.3 Quality assessment
d2 = 255^2;
% We cannot compare between the sizes of the filters. We can only compare
% the types of filters. Here we see that: For Gaussian noise, a mean filter
% is better than a median filter. For Pepper noise, a median filter is
% better.

%% The cameraman image
PSNRcameraGaussianMean1 = 10*log10(d2/immse(ICamera, ICameraGaussianMeanFiltered1)); % 73.0844 
PSNRcameraGaussianMean2 = 10*log10(d2/immse(ICamera, ICameraGaussianMeanFiltered2)); % 71.3421
PSNRcameraGaussianMean3 = 10*log10(d2/immse(ICamera, ICameraGaussianMeanFiltered3)); % 70.9718

PSNRcameraGaussianMed1 = 10*log10(d2/immse(ICamera, ICameraGaussianMedFiltered1)); % 71.6700
PSNRcameraGaussianMed2 = 10*log10(d2/immse(ICamera, ICameraGaussianMedFiltered2)); % 72.2494 
PSNRcameraGaussianMed3 = 10*log10(d2/immse(ICamera, ICameraGaussianMedFiltered3)); % 71.0100

PSNRcameraPepperMean1 = 10*log10(d2/immse(ICamera, ICameraPepperMeanFiltered1)); % 67.3764
PSNRcameraPepperMean2 = 10*log10(d2/immse(ICamera, ICameraPepperMeanFiltered2)); % 67.8056
PSNRcameraPepperMean3 = 10*log10(d2/immse(ICamera, ICameraPepperMeanFiltered3)); % 68.1314 

PSNRcameraPepperMed1 = 10*log10(d2/immse(ICamera, ICameraPepperMedFiltered1)); % 69.2745
PSNRcameraPepperMed2 = 10*log10(d2/immse(ICamera, ICameraPepperMedFiltered2)); % 71.4854
PSNRcameraPepperMed3 = 10*log10(d2/immse(ICamera, ICameraPepperMedFiltered3)); % 70.0588

%% The baboon image
PSNRbaboonGaussianMean1 = 10*log10(d2/immse(IBaboon, IBaboonGaussianMeanFiltered1)); % 71.3224 
PSNRbaboonGaussianMean2 = 10*log10(d2/immse(IBaboon, IBaboonGaussianMeanFiltered2)); % 70.0196
PSNRbaboonGaussianMean3 = 10*log10(d2/immse(IBaboon, IBaboonGaussianMeanFiltered3)); % 69.6121 

PSNRbaboonGaussianMed1 = 10*log10(d2/immse(IBaboon, IBaboonGaussianMedFiltered1)); % 70.6361
PSNRbaboonGaussianMed2 = 10*log10(d2/immse(IBaboon, IBaboonGaussianMedFiltered2)); % 70.1803
PSNRbaboonGaussianMed3 = 10*log10(d2/immse(IBaboon, IBaboonGaussianMedFiltered3)); % 69.5328

PSNRbaboonPepperMean1 = 10*log10(d2/immse(IBaboon, IBaboonPepperMeanFiltered1)); % 67.5138
PSNRbaboonPepperMean2 = 10*log10(d2/immse(IBaboon, IBaboonPepperMeanFiltered2)); % 67.8574
PSNRbaboonPepperMean3 = 10*log10(d2/immse(IBaboon, IBaboonPepperMeanFiltered3)); % 68.0554

PSNRbaboonPepperMed1 = 10*log10(d2/immse(IBaboon, IBaboonPepperMedFiltered1)); % 68.7935
PSNRbaboonPepperMed2 = 10*log10(d2/immse(IBaboon, IBaboonPepperMedFiltered2)); % 69.9317
PSNRbaboonPepperMed3 = 10*log10(d2/immse(IBaboon, IBaboonPepperMedFiltered3)); % 69.3357

%% The cafe image
PSNRcafeGaussianMean1 = 10*log10(d2/immse(ICafe, ICafeGaussianMeanFiltered1)); % 69.0769 
PSNRcafeGaussianMean2 = 10*log10(d2/immse(ICafe, ICafeGaussianMeanFiltered2)); % 67.2909
PSNRcafeGaussianMean3 = 10*log10(d2/immse(ICafe, ICafeGaussianMeanFiltered3)); % 66.9267

PSNRcafeGaussianMed1 = 10*log10(d2/immse(ICafe, ICafeGaussianMedFiltered1)) % 68.7099 
PSNRcafeGaussianMed2 = 10*log10(d2/immse(ICafe, ICafeGaussianMedFiltered2)) % 68.3581
PSNRcafeGaussianMed3 = 10*log10(d2/immse(ICafe, ICafeGaussianMedFiltered3)) % 67.4245

PSNRcafePepperMean1 = 10*log10(d2/immse(ICafe, ICafePepperMeanFiltered1)); % 65.6235 
PSNRcafePepperMean2 = 10*log10(d2/immse(ICafe, ICafePepperMeanFiltered2)); % 65.3597
PSNRcafePepperMean3 = 10*log10(d2/immse(ICafe, ICafePepperMeanFiltered3)); % 65.3607 

PSNRcafePepperMed1 = 10*log10(d2/immse(ICafe, ICafePepperMedFiltered1)) % 66.8195  
PSNRcafePepperMed2 = 10*log10(d2/immse(ICafe, ICafePepperMedFiltered2)) % 67.7423
PSNRcafePepperMed3 = 10*log10(d2/immse(ICafe, ICafePepperMedFiltered3)) % 66.9690

% Explanation: the Gaussian noise has a mean of zero and does not have
% outliers, so a mean filter is better. For the pepper noise, it's like we
% add the dots and black points to the image, so we have outliers instead
% of a distribution. If we calculate the average it's not near to the gray
% color of the original image. If we take the median, it includes sorting
% the dots, then taking the middle value, and this value is close to the
% gray background color.