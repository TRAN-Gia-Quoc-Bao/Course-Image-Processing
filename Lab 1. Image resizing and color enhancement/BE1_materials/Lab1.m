%% Image analysis Lab 1 - TRAN Gia Quoc Bao

%% Default commands
close all;
clear all;
clc;

%% Loading & displaying the image
ImBabaraOriginal = double(imread('barbara.tif'));
[H, W]=size(ImBabaraOriginal); % return the image's size

%% I. Resampling
%% I. 1. Downsampling
%% Apply downsampling to the original image
ImBabaraDownsampled = zeros(size(ImBabaraOriginal)/2); % create a new image
% Perform downsampling
for i = 1:size(ImBabaraDownsampled)
    for j = 1:size(ImBabaraDownsampled)
        ImBabaraDownsampled(i, j) = ImBabaraOriginal(2*i - 1, 2*j - 1);
    end
end

figure(1);
subplot(121);
imshow(ImBabaraOriginal, []);
title('The original Babara image');
subplot(122);
imshow(ImBabaraDownsampled, []); 
title('The downsampled Babara image');

%% Apply a low-pass filter on the image
% The filter
filterLowPass1 = [-1/32, 0, 9/32, 1/2, 9/32, 0, -1/32];

figure(2);
plot(abs(fftshift(fft([filterLowPass1, zeros(1, 92)]))));
legend('The magnitude of the filter');
grid on;
title('Fourier transform of the filter');
xlabel('Frequency');
ylabel('Magnitude');

% Apply the filter to the image
ImBabaraFiltered1 = imfilter(ImBabaraOriginal, filterLowPass1, 'conv', 'replicate');

figure(3);
subplot(121);
imshow(ImBabaraOriginal, []);
title('The original Babara image');
subplot(122);
imshow(ImBabaraFiltered1, []); 
title('The Babara image filtered with filter 1');

%% Apply downsampling to the filtered image
ImBabaraFilteredDownsampled = zeros(size(ImBabaraOriginal)/2); % create a new image
% Perform downsampling
for i = 1:size(ImBabaraFilteredDownsampled)
    for j = 1:size(ImBabaraFilteredDownsampled)
        ImBabaraFilteredDownsampled(i, j) = ImBabaraFiltered1(2*i - 1, 2*j - 1);
    end
end

figure(4);
subplot(221);
imshow(ImBabaraOriginal, []);
title('The original Babara image');
subplot(222);
imshow(ImBabaraFiltered1, []); 
title('The Babara image filtered with filter 1');
subplot(223);
imshow(ImBabaraDownsampled, []);
title('The original Babara image downsampled');
subplot(224);
imshow(ImBabaraFilteredDownsampled, []); 
title('The filtered Babara image filtered with filter 1 and downsampled');

%% I. 2. Upsampling
%% Apply upsampling to the original image
ImBabaraUpsampled = zeros(2*size(ImBabaraOriginal)); % create a new image
% Perform upsampling
for i = 1:size(ImBabaraUpsampled)/2
    for j = 1:size(ImBabaraUpsampled)/2
        ImBabaraUpsampled(2*i - 1, 2*j - 1) = ImBabaraOriginal(i, j);
        ImBabaraUpsampled(2*i, 2*j) = 0;
    end
end

figure(5);
subplot(121);
imshow(ImBabaraOriginal, []);
title('The original Babara image');
subplot(122);
imshow(ImBabaraUpsampled, []); 
title('The upsampled Babara image');

%% Apply a low-pass filter on the image
% The filter
filterLowPass2 = 2*filterLowPass1;

figure(6);
plot(abs(fftshift(fft([filterLowPass2, zeros(1, 92)]))));
legend('The magnitude of the filter');
grid on;
title('Fourier transform of the filter');
xlabel('Frequency');
ylabel('Magnitude');

% Apply the filter to the image
ImBabaraFiltered2 = imfilter(ImBabaraOriginal, filterLowPass2, 'conv', 'replicate');

figure(7);
subplot(121);
imshow(ImBabaraOriginal, []);
title('The original Babara image');
subplot(122);
imshow(ImBabaraFiltered2, []); 
title('The abara image filtered with filter 2');

%% Apply upsampling to the filtered image
ImBabaraFilteredUpsampled = zeros(2*size(ImBabaraOriginal)); % create a new image
% Perform downsampling
for i = 1:size(ImBabaraFilteredUpsampled)/2
    for j = 1:size(ImBabaraFilteredUpsampled)/2
        ImBabaraFilteredUpsampled(2*i - 1, 2*j - 1) = ImBabaraFiltered2(i, j);
        ImBabaraFilteredUpsampled(2*i, 2*j) = 0;
    end
end

figure(8);
subplot(221);
imshow(ImBabaraOriginal, []);
title('The original Babara image');
subplot(222);
imshow(ImBabaraFiltered2, []); 
title('The filtered Babara image');
subplot(223);
imshow(ImBabaraUpsampled, []);
title('The original Babara image upsampled');
subplot(224);
imshow(ImBabaraFilteredUpsampled, []); 
title('The Babara image filtered with filter 2 and upsampled');

% Comment: it does not work so we need to apply the filter after the
% upsampling

% Apply the filter to the upsampled image
ImBabaraFiltered2AfterUpsampled = imfilter(ImBabaraUpsampled, filterLowPass2, 'conv', 'replicate');

% Apply the filter to the upsampled image (again)
ImBabaraFiltered2TwiceAfterUpsampled = imfilter(ImBabaraFiltered2AfterUpsampled, filterLowPass2, 'conv', 'replicate');

figure(9);
subplot(221);
imshow(ImBabaraOriginal, []);
title('The original Babara image');
subplot(222);
imshow(ImBabaraUpsampled, []);
title('The original Babara image upsampled');
subplot(223);
imshow(ImBabaraFiltered2AfterUpsampled, []); 
title('The Babara image upsampled then filtered with filter 2');
subplot(224);
imshow(ImBabaraFiltered2TwiceAfterUpsampled, []); 
title('The Babara image upsampled then filtered with filter 2 twice');

%% I. 3. Do it as a function
% Apply image enlargement
image_enlargement();
% Check the solution
ImCameraman = double(imread('cameraman.tif'))/255;
ImCameramanUpsized = imresize(ImCameraman, 1.3);
ImCameramanDownsized = imresize(ImCameraman, 0.7);

% Compare solutions
figure(12);
imshow(ImCameramanUpsized);
title('The cameraman image enlarged by 1.3 using imresize');

figure(13);
imshow(ImCameramanDownsized);
title('The cameraman image reduced by 0.7 using imresize');

%% II. Color spaces
%% II. 1. Saturation
% Open the image and visualize it
ImColor1 = double(imread('imcolor1.tif'))/255;
figure(14);
imshow(ImColor1);
title('The color image');

% Change of basis
P = [(3)^(-0.5) (3)^(-0.5) (3)^(-0.5); (6)^(-0.5) (6)^(-0.5) -2*(6)^(-0.5); (2)^(-0.5) (2)^(-0.5) 0];
% The basis of the new color space
IL1 = (ImColor1(:,:,1) + ImColor1(:,:,2) + ImColor1(:,:,3))/sqrt(3);
IC11 = (ImColor1(:,:,1) + ImColor1(:,:,2) - 2*ImColor1(:,:,3))/sqrt(6);
IC12 = (ImColor1(:,:,1) - ImColor1(:,:,2))/sqrt(2);

%% Check by using rgb2hsv
ImColor1Check = rgb2ycbcr(ImColor1);
u = ImColor1Check(:,:,1);
ImColor1Check2 = zeros(size(ImColor1));
ImColor1Check2(:,:,1) = IL1;
ImColor1Check2(:,:,2) = IC11;
ImColor1Check2(:,:,3) = IC12;
figure(15);
subplot(121);
imshow(ImColor1Check);
subplot(122);
imshow(ImColor1Check2);

%%
% Double saturation
IC11_doubled = 2*IC11;
IC12_doubled = 2*IC12;

% Switch back to the original image
ImColor1SaturationDoubled = zeros(size(ImColor1));
ImColor1SaturationDoubled(:,:,1) = IL1*1/sqrt(3) + IC11_doubled*1/sqrt(6) + IC12_doubled*1/sqrt(2);
ImColor1SaturationDoubled(:,:,2) = IL1*1/sqrt(3) + IC11_doubled*1/sqrt(6) + IC12_doubled*(-1/sqrt(2));
ImColor1SaturationDoubled(:,:,3) = IL1*1/sqrt(3) + IC11_doubled*(-2/sqrt(6));

% Halve saturation
IC11_halved = 0.5*IC11;
IC12_halved = 0.5*IC12;

% Switch back to the original image
ImColor1SaturationHalved = zeros(size(ImColor1));
ImColor1SaturationHalved(:,:,1) = IL1*1/sqrt(3) + IC11_halved*1/sqrt(6) + IC12_halved*1/sqrt(2);
ImColor1SaturationHalved(:,:,2) = IL1*1/sqrt(3) + IC11_halved*1/sqrt(6) + IC12_halved*(-1/sqrt(2));
ImColor1SaturationHalved(:,:,3) = IL1*1/sqrt(3) + IC11_halved*(-2/sqrt(6));

% Comparison of the result
figure(16);
subplot(131);
imshow(ImColor1SaturationDoubled);
title('The color image with saturation doubled');
subplot(132);
imshow(ImColor1);
title('The original color image');
subplot(133);
imshow(ImColor1SaturationHalved);
title('The color image with saturation halved');

%% Changing the image's brightness

ImColor2 = double(imread('imcolor2.tif'))/255;
figure(17);
imshow(ImColor2);
title('The color image'); 

% Change of basis
% The basis of the new color space
IL2 = (ImColor2(:,:,1) + ImColor2(:,:,2) + ImColor2(:,:,3))/sqrt(3);
IC21 = (ImColor2(:,:,1) + ImColor2(:,:,2) - 2*ImColor2(:,:,3))/sqrt(6);
IC22 = (ImColor2(:,:,1) - ImColor2(:,:,2))/sqrt(2);

% Double brightness
IL2_doubled = 2*IL2;

% Switch back to the original image
ImColor2BrightnessDoubled = zeros(size(ImColor2));
ImColor2BrightnessDoubled(:,:,1) = IL2_doubled*1/sqrt(3) + IC21*1/sqrt(6) + IC22*1/sqrt(2);
ImColor2BrightnessDoubled(:,:,2) = IL2_doubled*1/sqrt(3) + IC21*1/sqrt(6) + IC22*(-1/sqrt(2));
ImColor2BrightnessDoubled(:,:,3) = IL2_doubled*1/sqrt(3) + IC21*(-2/sqrt(6));

% Halve brightness
IL2_halved = 0.5*IL2;

% Switch back to the original image
ImColor2BrightnessHalved = zeros(size(ImColor2));
IImColor1BrightnessHalved(:,:,1) = IL2_halved*1/sqrt(3) + IC21*1/sqrt(6) + IC22*1/sqrt(2);
ImColor2BrightnessHalved(:,:,2) = IL2_halved*1/sqrt(3) + IC21*1/sqrt(6) + IC22*(-1/sqrt(2));
ImColor2BrightnessHalved(:,:,3) = IL2_halved*1/sqrt(3) + IC21*(-2/sqrt(6));

% Comparison of the result
figure(18);
subplot(131);
imshow(ImColor2BrightnessDoubled);
title('The color image with brightness doubled');
subplot(132);
imshow(ImColor2);
title('The original color image');
subplot(133);
imshow(ImColor2BrightnessHalved);
title('The color image with brightness halved');

%% II. 2. Hue
% Open the image and visualize it
ImColor3 = double(imread('IM088.tif'))/255;
figure(19);
imshow(ImColor3);
title('The color image');

% Change of basis
% The basis of the new color space
IL3 = (ImColor3(:,:,1) + ImColor3(:,:,2) + ImColor3(:,:,3))/sqrt(3);
IC31 = (ImColor3(:,:,1) + ImColor3(:,:,2) - 2*ImColor3(:,:,3))/sqrt(6);
IC32 = (ImColor3(:,:,1) - ImColor3(:,:,2))/sqrt(2);

% Calculate saturation & hue
saturation3 = sqrt(IC31.^2 + IC32.^2);
hue3 = atan2(IC31, IC32);

% Increase the hue
addAngle = 0.5;
hue3Add = hue3 + addAngle;
% Get back the chronominances
IC31HueAdd = saturation3.*sin(hue3Add);
IC32hueAdd = saturation3.*cos(hue3Add);

% Switch back to the original image - 
ImColor3HueAdded = zeros(size(ImColor3));
ImColor3HueAdded(:,:,1) = IL3*1/sqrt(3) + IC31HueAdd*1/sqrt(6) + IC32hueAdd*1/sqrt(2);
ImColor3HueAdded(:,:,2) = IL3*1/sqrt(3) + IC31HueAdd*1/sqrt(6) + IC32hueAdd*(-1/sqrt(2));
ImColor3HueAdded(:,:,3) = IL3*1/sqrt(3) + IC31HueAdd*(-2/sqrt(6));

% Decrease the hue
subtractAngle = 0.5;
hue3Subtract = hue3 - subtractAngle;
% Get back the chronominances
IC31HueSubtract = saturation3.*sin(hue3Subtract);
IC32HueSubtract = saturation3.*cos(hue3Subtract);

% Switch back to the original image
ImColor3HueSubtracted = zeros(size(ImColor3));
ImColor3HueSubtracted(:,:,1) = IL3*1/sqrt(3) + IC31HueSubtract*1/sqrt(6) + IC32HueSubtract*1/sqrt(2);
ImColor3HueSubtracted(:,:,2) = IL3*1/sqrt(3) + IC31HueSubtract*1/sqrt(6) + IC32HueSubtract*(-1/sqrt(2));
ImColor3HueSubtracted(:,:,3) = IL3*1/sqrt(3) + IC31HueSubtract*(-2/sqrt(6));

% Comparison of the result
figure(20);
subplot(131);
imshow(ImColor3HueAdded);
title(['The color image with hue increased by ', num2str(addAngle), ' rad']);
subplot(132);
imshow(ImColor3);
title('The original color image');
subplot(133);
imshow(ImColor3HueSubtracted);
title(['The color image with hue decreased by ', num2str(subtractAngle), ' rad']);

%% III. Histograms
%% III. 1. Contrast stretching
% Open the image 
ImEarth = double(imread('SUD_CH1.tif'))/255;

% Crop a zone from the image (bottom-left)
ImEarthCropped = zeros(2*size(ImEarth)/5);
for i = 1:size(ImEarthCropped)
    for j = 1:size(ImEarthCropped)
        ImEarthCropped(i, j) = ImEarth(i + 300 , j);
    end
end

% Visualize the image and the cropped corner
figure(21);
subplot(221);
imshow(ImEarth);
title('The earth image');
subplot(222);
imshow(ImEarthCropped);
title('The bottom-left corner of the earth image');
% Plot the histogram of the cloud image
subplot(223);
imhist(ImEarth);
title('The histogram of the earth image (in 0-1 range)');
subplot(224);
imhist(ImEarthCropped);
title('The histogram of the bottom-left corner of the earth image (in 0-1 range)');

%% Use contrast stretching on the cropped image
ImEarthContrastStretched = Contrast_stretching(ImEarthCropped*255, 5, 20, 0, 255);

figure(22);
subplot(221);
imshow(ImEarthCropped);
title('The cropped image');
subplot(222);
imshow(ImEarthContrastStretched);
title('The cropped image after contrast stretching');
subplot(223);
imhist(ImEarthCropped);
title('The histogram of the cropped image (in 0-1 range)');
subplot(224);
imhist(ImEarthContrastStretched);
title('The histogram of the cropped image after contrast stretching (in 0-255 range)');

%% Try clipping
ImEarthContrastStretchedWithClipping = Contrast_stretching(ImEarthCropped*255, 5, 20, 0, 500);

figure(23);
subplot(221);
imshow(ImEarthCropped);
title('The cropped image');
subplot(222);
imshow(ImEarthContrastStretchedWithClipping );
title({'The cropped image after contrast stretching with clipping', '(stretched into 500 instead of 255)'});
subplot(223);
imhist(ImEarthCropped);
title('The histogram of the cropped image (in 0-1 range)');
subplot(224);
imhist(ImEarthContrastStretchedWithClipping );
title({'The histogram of the cropped image after contrast stretching (in 0-255 range)', 'with clipping (stretched into 500 instead of 255)'});

%% Try thresholding
ImEarthThresheld = im2bw(ImEarthCropped, 0.03);

figure(24);
subplot(221);
imshow(ImEarthCropped);
title('The cropped image');
subplot(222);
imshow(ImEarthThresheld);
title('The cropped image thresheld at 0.03');
subplot(223);
imhist(ImEarthCropped);
title('The histogram of the cropped image (in 0-1 range)');
subplot(224);
imhist(ImEarthThresheld*255);
title('The histogram of the cropped image thresheld at 0.03');

%% Comparing everything
figure(25);
subplot(241);
imshow(ImEarthCropped);
title('The cropped image');
subplot(242);
imshow(ImEarthContrastStretched);
title('After contrast stretching');
subplot(243);
imshow(ImEarthContrastStretchedWithClipping );
title({'After contrast stretching with clipping', '(stretched into 500 instead of 255)'});
subplot(244);
imshow(ImEarthThresheld);
title('Thresheld at 0.03');
subplot(245);
imhist(ImEarthCropped);
title({'Corresponding', 'histogram (in 0-1 range)'});
subplot(246);
imhist(ImEarthContrastStretched);
title({'Corresponding', 'histogram (in 0-255 range)'});
subplot(247);
imhist(ImEarthContrastStretchedWithClipping);
title({'Corresponding', 'histogram (in 0-255 range)'});
subplot(248);
imhist(ImEarthThresheld*255);
title({'Corresponding', 'histogram (in 0-1 range)'});

%% III. 2. Histogram matching
% Open the image and visualize it
ImConcordaerial = double(imread('concordaerial.png'))/255;
ImConcordaerialRed = ImConcordaerial(:,:,1);
ImConcordaerialGreen = ImConcordaerial(:,:,2);
ImConcordaerialBlue = ImConcordaerial(:,:,3);

% Open the reference image and visualize it
ImConcordorthophoto = double(imread('concordorthophoto.png'))/255;

figure(26);
subplot(241);
imshow(ImConcordaerial);
title('The color image');
subplot(242);
[countsRed, grayLevelsRed] = imhist(ImConcordaerialRed);
bar(grayLevelsRed, countsRed, 'EdgeColor', 'r');
title('Red histogram');
subplot(243);
[countsGreen, grayLevelsGreen] = imhist(ImConcordaerialGreen);
bar(grayLevelsGreen, countsGreen, 'EdgeColor', 'g');
title('Green histogram');
subplot(244);
[countsBlue, grayLevelsBlue] = imhist(ImConcordaerialBlue);
bar(grayLevelsBlue, countsBlue, 'EdgeColor', 'b');
title('Blue histogram');
subplot(245);
imshow(ImConcordorthophoto);
title('The reference image');
subplot(246);
imhist(ImConcordorthophoto);
title('Reference histogram');
subplot(247);
imhist(ImConcordorthophoto);
title('Reference histogram');
subplot(248);
imhist(ImConcordorthophoto);
title('Reference histogram');

%% Find mean and standard deviation
% Find mean and standard deviation of Red
sumRed = 0;
for i = 1:256
    sumRed = sumRed + countsRed(i)*grayLevelsRed(i);
end
AveRed = sumRed/(2036*3060);

SumRed = 0;
for i = 1:256
    SumRed = SumRed + countsRed(i)*((grayLevelsRed(i) - AveRed)^2);
end
StdRed = sqrt(SumRed/(2036*3060));

% Find mean and standard deviation of Green
sumGreen = 0;
for i = 1:256
    sumGreen = sumGreen + countsGreen(i)*grayLevelsGreen(i);
end
AveGreen = sumGreen/(2036*3060);

SumGreen = 0;
for i = 1:256
    SumGreen = SumGreen + countsGreen(i)*((grayLevelsGreen(i) - AveGreen)^2);
end
StdGreen = sqrt(SumGreen/(2036*3060));

% Find mean and standard deviation of Blue
sumBlue = 0;
for i = 1:256
    sumBlue = sumBlue + countsBlue(i)*grayLevelsBlue(i);
end
AveBlue = sumBlue/(2036*3060);

SumBlue = 0;
for i = 1:256
    SumBlue = SumBlue + countsBlue(i)*((grayLevelsBlue(i) - AveBlue)^2);
end
StdBlue = sqrt(SumBlue/(2036*3060));

% Find mean and standard deviation of Reference

[countsRef, grayLevelsRef] = imhist(ImConcordorthophoto);

sumRef = 0;
for i = 1:256
    sumRef = sumRef + countsRef(i)*grayLevelsRef(i);
end
AveRef = sumRef/(2215*2956);

SumRef = 0;
for i = 1:256
    SumRef = SumRef + countsRef(i)*((grayLevelsRef(i) - AveRef)^2);
end
StdRef = sqrt(SumRef/(2215*2956));

%% Match histograms
% Match histograms
ImConcordaerialRedMatched = (ImConcordaerialRed - AveRed)*StdRef/StdRed + AveRed;
ImConcordaerialGreenMatched = (ImConcordaerialGreen - AveGreen)*StdRef/StdGreen + AveGreen;
ImConcordaerialBlueMatched = (ImConcordaerialBlue - AveBlue)*StdRef/StdBlue + AveBlue;

% Make a new image
ImConcordaerialMatched = zeros(size(ImConcordaerial));
ImConcordaerialMatched(:,:,1) = ImConcordaerialRedMatched;
ImConcordaerialMatched(:,:,2) = ImConcordaerialGreenMatched;
ImConcordaerialMatched(:,:,3) = ImConcordaerialBlueMatched;

% Display results
figure(27);
subplot(341);
imshow(ImConcordaerial);
title('The color image');
subplot(342);
[countsRed, grayLevelsRed] = imhist(ImConcordaerialRed);
bar(grayLevelsRed, countsRed, 'EdgeColor', 'r');
title('Red histogram');
subplot(343);
[countsGreen, grayLevelsGreen] = imhist(ImConcordaerialGreen);
bar(grayLevelsGreen, countsGreen, 'EdgeColor', 'g');
title('Green histogram');
subplot(344);
[countsBlue, grayLevelsBlue] = imhist(ImConcordaerialBlue);
bar(grayLevelsBlue, countsBlue, 'EdgeColor', 'b');
title('Blue histogram');
subplot(345);
imshow(ImConcordorthophoto);
title('The reference image');
subplot(346);
imhist(ImConcordorthophoto);
title('Reference histogram');
subplot(347);
imhist(ImConcordorthophoto);
title('Reference histogram');
subplot(348);
imhist(ImConcordorthophoto);
title('Reference histogram');
subplot(349);
imshow(ImConcordaerialMatched);
title('The image with matched histograms');
subplot(3,4,10);
[countsRedMatched, grayLevelsRedMatched] = imhist(ImConcordaerialRedMatched);
bar(grayLevelsRedMatched, countsRedMatched, 'EdgeColor', 'r');
title('Red histogram matched');
subplot(3,4,11);
[countsGreenMatched, grayLevelsGreenMatched] = imhist(ImConcordaerialGreenMatched);
bar(grayLevelsGreenMatched, countsGreenMatched, 'EdgeColor', 'g');
title('Green histogram matched');
subplot(3,4,12);
[countsBlueMatched, grayLevelsBlueMatched] = imhist(ImConcordaerialBlueMatched);
bar(grayLevelsBlueMatched, countsBlueMatched, 'EdgeColor', 'b');
title('Blue histogram matched');
% Of course this cannot be done in 2 hours!