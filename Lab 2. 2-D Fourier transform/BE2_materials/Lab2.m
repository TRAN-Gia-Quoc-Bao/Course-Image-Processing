%% Lab 2 - TRAN Gia Quoc Bao

%% Default commands
close all;
clear all;
clc;

%% I. Fourier analysis of images
%% 1.1 Familiarizing with the Fourier domain
%% Synthetic images
%% A grid composed of black and white bars
w1 = 32; % case 128 is a multiple of w
[x1, y1] = meshgrid(0:127, 0:127); 
Igrid1 = (sign(sin(pi/w1*x1 + 1e-8)) + 1)*127.5;

[RealPartIgrid1, ImagPartIgrid1, MagnitudeIgrid1, PhaseIgrid1, DFTIgrid1] = ImageDFT(Igrid1/255, 'grid image (128 is a multiple of w)');

figure();
subplot(121);
imshow(Igrid1, []);
title('The grid image where 128 is a multiple of w');
subplot(122);
imshow(MagnitudeIgrid1, []);
title('The magnitude (in log scale) of the DFT of the grid image where 128 is a multiple of w');

w1 = 30; % case 128 is not a multiple of w
[x2, y2] = meshgrid(0:127, 0:127); 
Igrid2 = (sign(sin(pi/w1*x2 + 1e-8)) + 1)*127.5;

[RealPartIgrid2, ImagPartIgrid2, MagnitudeIgrid2, PhaseIgrid2, DFTIgrid2] = ImageDFT(Igrid2/255, 'grid image (128 is not a multiple of w)');

figure();
subplot(121);
imshow(Igrid2, []);
title('The grid image where 128 is not a multiple of w');
subplot(122);
imshow(MagnitudeIgrid2, []);
title('The magnitude (in log scale) of the DFT of the grid image where 128 is not a multiple of w');

%% Comparison
figure();
subplot(221);
imshow(Igrid1, []);
title('The grid image where 128 is a multiple of w');
subplot(222);
imshow(MagnitudeIgrid1, []);
title('The magnitude of the DFT of the grid image where 128 is a multiple of w');
subplot(223);
imshow(Igrid2, []);
title('The grid image where 128 is not a multiple of w');
subplot(224);
imshow(MagnitudeIgrid2, []);
title('The magnitude of the DFT of the grid image where 128 is not a multiple of w');

%% A disc of radius r
r1 = 25;
[x3, y3] = meshgrid(0:127, 0:127); 
Idisc1 = (sqrt((x3 - 64).^2+(y3 - 64).^2) <= r1)*255;

[RealPartIdisc1, ImagPartIdisc1, MagnitudeIdisc1, PhaseIdisc1, DFTIdisc1] = ImageDFT(Idisc1/255, 'disc image (r = 25)');

figure();
subplot(121);
imshow(Idisc1, []);
title('The grid image r = 25');
subplot(122);
imshow(MagnitudeIdisc1, []);
title('The magnitude (in log scale) of the DFT of the disc r = 25');

r2 = 50;
[x4, y4] = meshgrid(0:127, 0:127); 
Idisc2 = (sqrt((x4 - 64).^2+(y4 - 64).^2) <= r2)*255;

[RealPartIdisc2, ImagPartIdisc2, MagnitudeIdisc2, PhaseIdisc2, DFTIdisc2] = ImageDFT(Idisc2/255, 'disc image (r = 50)');

figure();
subplot(121);
imshow(Idisc2, []);
title('The grid image r = 50');
subplot(122);
imshow(MagnitudeIdisc2, []);
title('The magnitude (in log scale) of the DFT of the disc r = 50');

%% Comparison
figure();
subplot(221);
imshow(Idisc1, []);
title('The disc image r = 25');
subplot(222);
imshow(MagnitudeIdisc1, []);
title('The magnitude of the DFT of the disc image r = 25');
subplot(223);
imshow(Idisc2, []);
title('The disc image r = 50');
subplot(224);
imshow(MagnitudeIdisc2, []);
title('The magnitude of the DFT of the disc image r = 50');

%% Real images
%% "Camera"
ICamera = double(imread('camera.tif'));

[RealPartICamera, ImagPartICamera, MagnitudeICamera, PhaseICamera, DFTICamera] = ImageDFT(ICamera/255, 'camera image');

figure();
subplot(121);
imshow(ICamera, []);
title('The camera image');
subplot(122);
imshow(MagnitudeICamera, []);
title('The 2-D DFT of the camera image');

%% "Lena"
ILena = double(imread('Lena.tif'));

figure();
imshow(ILena, []);
title('The Lena image');

[RealPartILena, ImagPartILena, MagnitudeILena, PhaseILena, DFTILena] = ImageDFT(ILena/255, 'Lena image');

figure();
subplot(121);
imshow(ILena, []);
title('The Lena image');
subplot(122);
imshow(MagnitudeILena, []);
title('The 2-D DFT of the Lena image');

%% "City"
ICity = double(imread('ville.tif'))/255;

[RealPartICity, ImagPartICity, MagnitudeICity, PhaseICity,DFTICity] = ImageDFT(ICity/255, 'city image');

figure();
subplot(121);
imshow(ICity, []);
title('The City image');
subplot(122);
imshow(MagnitudeICity, []);
title('The 2-D DFT of the city image');

%% Texture images
%% Texture 1 (3)
ITexture1 = double(imread('texture3.pgm'));

[RealPartITexture1, ImagPartITexture1, MagnitudeITexture1, PhaseITexture1, DFTITexture1] = ImageDFT(ITexture1/255, 'texture image 1');

figure();
subplot(121);
imshow(ITexture1, []);
title('The texture image 1');
subplot(122);
imshow(MagnitudeITexture1, []);
title('The 2-D DFT of the texture image 1');

%% Texture 2 (4)
ITexture2 = double(imread('texture4.pgm'));

[RealPartITexture2, ImagPartITexture2, MagnitudeITexture2, PhaseITexture2, DFTITexture2] = ImageDFT(ITexture2/255, 'texture image 2');

figure();
subplot(121);
imshow(ITexture2, []);
title('The texture image 2');
subplot(122);
imshow(MagnitudeITexture2, []);
title('The 2-D DFT of the texture image 2');

%% 1.2 Amplitude and phase information

[RealPartILenaShifted, ImagPartILenaShifted, MagnitudeILenaShifted, PhaseILenaShifted] = ImageDFTWithShift(ILena/255, 100, 'Lena image');

[RealPartICityShifted, ImagPartICityShifted, MagnitudeICityShifted, PhaseICityShifted] = ImageDFTWithShift(ICity/255, 100, 'city image');

%% Restore information

[ILenaRecovered1] = ImageDFTInverse(MagnitudeILena, zeros(225, 225), 'Lena image');

[ILenaRecovered2] = ImageDFTInverse(200*ones(225, 225), PhaseILena, 'Lena image');

%% II. Filtering in frequency domain

%% 2.1 Filtering
[xf, yf] = meshgrid(0:255, 0:255);

%% Ideal isotropic low-pass filter
D01 = 15;
isotropicLowPassFilter = (sqrt((xf - 128).^2 + (yf - 128).^2) <= D01)*255;

figure();
subplot(121);
imshow(isotropicLowPassFilter, []);
xlabel('u');
ylabel('v');
zlabel('filter');
title('The isotropic low-pass filter in frequency domain');
subplot(122);
surf(xf, yf, isotropicLowPassFilter);
xlabel('u');
ylabel('v');
zlabel('filter');
title('Surface plot of the isotropic low-pass filter');

% Use the filter
ICameraLowFilteredFreq = ifft2(ifftshift(DFTICamera.*isotropicLowPassFilter));

% Results
figure();
subplot(121);
imshow(ICamera, []);
title('The original Cameraman image');
subplot(122);
imshow(ICameraLowFilteredFreq, []);
title('The low-pass filtered Cameraman image');


%% Ideal isotropic high-pass filter
D02 = 15;
isotropicHighPassFilter = (sqrt((xf - 128).^2 + (yf - 128).^2) >= D02)*255;

figure();
subplot(121);
imshow(isotropicHighPassFilter, []);
xlabel('u');
ylabel('v');
zlabel('filter');
title('The isotropic high-pass filter in frequency domain');
subplot(122);
surf(xf, yf, isotropicHighPassFilter);
xlabel('u');
ylabel('v');
zlabel('filter');
title('Surface plot of the isotropic high-pass filter');

% Use the filter
ICameraHighFilteredFreq = ifft2(ifftshift(DFTICamera.*isotropicHighPassFilter));

% Results
figure();
subplot(121);
imshow(ICamera, []);
title('The original Cameraman image');
subplot(122);
imshow(ICameraHighFilteredFreq, []);
title('The high-pass filtered Cameraman image');

%% Butterworth filter
D03 = 25;
n = 4;
butterworthFilter = 255./(1 + (((xf - 128).^2 + (yf - 128).^2)/D03^2)^n);

figure();
subplot(121);
imshow(butterworthFilter, []);
xlabel('u');
ylabel('v');
zlabel('filter');
title('The Butterworth filter in frequency domain');
subplot(122);
surf(xf, yf, butterworthFilter);
xlabel('u');
ylabel('v');
zlabel('filter');
title('Surface plot of the Butterworth filter');

% Use the filter
ICameraButterworthFilteredFreq = real(ifft2(ifftshift(DFTICamera.*butterworthFilter)));

% Results
figure();
subplot(121);
imshow(ICamera, []);
title('The original Cameraman image');
subplot(122);
imshow(ICameraButterworthFilteredFreq, []);
title('The Butterworth filtered Cameraman image, order n = 2');

%% 2.2 Equivalence with convolution in spatial domain
% The filter
filterMean33 = ones(3,3)/9;

% Filter in Space domain
ICityButterworthFilteredSpatial = imfilter(ICity, filterMean33, 'replicate'); 

% Filter in Freq domain
% Find the filter's DFT
filterMean33Freq = fftshift(fft2(filterMean33, 254, 254));
% Use the filter (multiplication in Freq % switch back to Spatial domain)
ICityButterworthFilteredFreq = real(ifft2(ifftshift(DFTICity.*filterMean33Freq)))*255;

% Results
figure();
subplot(131);
imshow(ICity, []);
title('The original City image');
subplot(132);
imshow(ICityButterworthFilteredFreq, []);
title('The City image filtered in FREQUENCY domain');
subplot(133);
imshow(ICityButterworthFilteredSpatial, []);
title('The City image filtered in SPATIAL domain');

% Comparison
err = immse(ICityButterworthFilteredFreq, ICityButterworthFilteredSpatial);