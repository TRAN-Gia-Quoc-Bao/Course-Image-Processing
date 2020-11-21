%% Lab 3 - Tran Gia Quoc Bao (part 2)

%% Default commands
close all;
clear all;
clc;

%% Edge detection

% horizontal = imfilter with sobel,
% vertical = sobel inverse
% grad = sqrt(h ^ 2 + v ^2 )

FilterSobel = fspecial('sobel');

ICamera = double(imread('cameraman.png'))/255;
IBaboon = double(imread('baboon.tif'))/255;
ICafe = double(imread('cafe.tif'))/255;

ICameraHorizontal = imfilter(ICamera, FilterSobel);
IBaboonHorizontal = imfilter(IBaboon, FilterSobel);
ICafeHorizontal = imfilter(ICafe, FilterSobel);

figure();
subplot(231);
imshow(ICamera);
title('The cameraman image');
subplot(232);
imshow(IBaboon);
title('The baboon image');
subplot(233);
imshow(ICafe);
title('The cafe image');
subplot(234);
imshow(ICameraHorizontal);
title('The corresponding horizontal edge');
subplot(235);
imshow(IBaboonHorizontal);
title('The corresponding horizontal edge');
subplot(236);
imshow(ICafeHorizontal);
title('The corresponding horizontal edge');

ICameraVertical = imfilter(ICamera, FilterSobel');
IBaboonVertical = imfilter(IBaboon, FilterSobel');
ICafeVertical = imfilter(ICafe, FilterSobel');

figure();
subplot(231);
imshow(ICamera);
title('The cameraman image');
subplot(232);
imshow(IBaboon);
title('The baboon image');
subplot(233);
imshow(ICafe);
title('The cafe image');
subplot(234);
imshow(ICameraVertical);
title('The corresponding vertical edge');
subplot(235);
imshow(IBaboonVertical);
title('The corresponding vertical edge');
subplot(236);
imshow(ICafeVertical);
title('The corresponding vertical edge');

ICameraGrad = sqrt(ICameraHorizontal.^2 + ICameraVertical.^2);
IBaboonGrad = sqrt(IBaboonHorizontal.^2 + IBaboonVertical.^2);
ICafeGrad = sqrt(ICafeHorizontal.^2 + ICafeVertical.^2);

figure();
subplot(231);
imshow(ICamera);
title('The cameraman image');
subplot(232);
imshow(IBaboon);
title('The baboon image');
subplot(233);
imshow(ICafe);
title('The cafe image');
subplot(234);
imshow(ICameraGrad);
title('The corresponding gradient magnitude');
subplot(235);
imshow(IBaboonGrad);
title('The corresponding gradient magnitude');
subplot(236);
imshow(ICafeGrad);
title('The corresponding gradient magnitude');

%% Object detection by phase correlation
% cau cuoi: tinh dft (shift), lay lien hop r theo cong thuc lam, cuoi cung
% shift roi idft

ITokens = double(imread('tokens.tif'))/255;

% Simulate disc
[x, y] = meshgrid(0:620, 0:444); 
r = 32;
IDisc = (sqrt((x).^2+(y).^2) <= r) + (sqrt((x - 620).^2+(y).^2) <= r) + (sqrt((x).^2+(y - 444).^2) <= r) + (sqrt((x - 620).^2+(y - 444).^2) <= r);

% Take the DFTs
ITokensDFT = fftshift(fft2(ITokens));
IDiscDFT = fftshift(fft2(IDisc));
% Calculate R
product = ITokensDFT.*conj(IDiscDFT);
R = real(ifft2(ifftshift(product./abs(product)))); % calculate the cross power spectrum
ICenter = im2bw(R, 0.015); % threshold the result

imageRecov = real(ifft2(ifftshift(IDiscDFT.*R)));

% Compare results
[C, Radius] = imfindcircles(ITokens, [10 75]);
ICompare = zeros([445 621]);
P = floor(C);

for i = 1:29;
    ICompare(P(i,2), P(i,1))=1;
end

figure();
subplot(121);
imshow(ITokens);
title('The tokens image');
subplot(122);
imshow(IDisc*255);
title('Simulated disk');

figure();
imshow(ICenter);
title('Phase correlation results');

figure();
imshow(ICompare);
title('Imfindcircles results');