%% BE4 _ Tran Gia Quoc Bao

%% Default commands
close all;
clear all;
clc;

%% Preparation
ImPrepa = double(imread('scissors.png'));

SEPrepa = strel('square', 3);

% Dilation
ImPrepaDilated = imdilate(ImPrepa, SEPrepa);

% Erosion
ImPrepaEroded = imerode(ImPrepa, SEPrepa);

% Opening
ImPrepaOpened = imopen(ImPrepa, SEPrepa);

% Closing
ImPrepaClosed = imclose(ImPrepa, SEPrepa);

% Results
figure();
subplot(221);
imshow(ImPrepaDilated, []);
title('The scissors image dilated');
subplot(222);
imshow(ImPrepaEroded, []);
title('The scissors image eroded');
subplot(223);
imshow(ImPrepaOpened, []);
title('The scissors image opened');
subplot(224);
imshow(ImPrepaClosed, []);
title('The scissors image closed');

%% I. Familiarize yourself with the tools
%% 1.1 Structuring element
SE1 = strel('diamond', 3);
SE2 = strel('disk', 3, 4); % r must be a multiple of 3, n = 4 by default
SE3 = strel('octagon', 3); % r must be a multiple of 3
SE4 = strel('line', 3, 45);
SE5 = strel('rectangle', [2 3]);
SE6 = strel('square', 3);

% figure();
% subplot(231);
% imshow(getnhood(SE1));
% title('The diamond SE, r = 3');
% subplot(232);
% imshow(getnhood(SE2));
% title('The disk SE, r = 3, n = 4');
% subplot(233);
% imshow(getnhood(SE3));
% title('The octagon SE, r = 3');
% subplot(234);
% imshow(getnhood(SE4));
% title('The line SE, length = 3, degree = 0');
% subplot(235);
% imshow(getnhood(SE5));
% title('The rectangle SE, m = 2, n = 3');
% subplot(236);
% imshow(getnhood(SE6));
% title('The square SE, w = 3');

figure();
subplot(131);
imshow(getnhood(SE1));
title('The diamond SE, r = 3');
subplot(132);
imshow(getnhood(SE4));
title('The line SE, length = 3, degree = 45');
subplot(133);
imshow(getnhood(SE3));
title('The octagon SE, r = 3');

%% 1.2 Morphological operators
% We choose the square SE w = 3
SESquare = strel('square', 3);
SESquareReflected = reflect(SESquare);

ImCamera = double(imread('cameraman.png'));

% Erosion
ImCameraEroded = imerode(ImCamera, SESquare); 
% Dilation
ImCameraDilated = imdilate(ImCamera, SESquare);
% Opening
ImCameraOpened = imopen(ImCamera, SESquare);
% Closing
ImCameraClosed = imclose(ImCamera, SESquare);
% White Top Hat (top hat)
ImCameraWTH = imtophat(ImCamera, SESquare);
% Black Top Hat (bottom hat)
ImCameraBTH = imbothat(ImCamera, SESquare);

% Results
figure();
subplot(231);
imshow(ImCameraEroded, []);
title('The cameraman image eroded');
subplot(232);
imshow(ImCameraOpened, []);
title('The cameraman image opened');
subplot(233);
imshow(ImCameraWTH, []);
title('The cameraman image WTH');
subplot(234);
imshow(ImCameraDilated, []);
title('The cameraman image dilated');
subplot(235);
imshow(ImCameraClosed, []);
title('The cameraman image closed');
subplot(236);
imshow(ImCameraBTH, []);
title('The cameraman image BTH');

%% 1.3 Other useful operators
% Thresholding
ImCameraThresheld = double(ImCamera > 128);
% Regional extrema
ImCameraRegionalMax = imregionalmax(ImCamera);
ImCameraRegionalMin = imregionalmin(ImCamera);
% Median filtering
ImCameraMedianFiltered = medfilt2(ImCamera);
% Region labeling
ImCameraRegionLabeled = bwlabel(ImCameraThresheld);

% Results
figure();
subplot(231);
imshow(ImCamera, []);
title('The original cameraman image');
subplot(232);
imshow(ImCameraThresheld, []);
title('The cameraman image thresheld at 120');
subplot(233);
imshow(ImCameraRegionLabeled, []);
title('The cameraman image after region labeling');
subplot(234);
imshow(ImCameraRegionalMax, []);
title('The local maxima of the cameraman image');
subplot(235);
imshow(ImCameraRegionalMin, []);
title('The local minima of the cameraman image');
subplot(236);
imshow(ImCameraMedianFiltered, []);
title('The cameraman image after median filtering');
