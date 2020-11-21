%% BE4 _ Tran Gia Quoc Bao (part 2)

%% Default commands
close all;
clear all;
clc;

%% 2 Image processing
%% 2.1 Extracting the tablets
ImTablets = double(imread('tablets.png'));

%% Approach 1
% Thresholding
ImTabletsThresheld = double(ImTablets > 210);
% Median filtering
ImTabletsThresheldMedianFiltered = medfilt2(ImTabletsThresheld);

% Results
figure();
subplot(131);
imshow(ImTablets, []);
title('The original tablets image');
subplot(132);
imshow(ImTabletsThresheld, []);
title('The tablets image thresheld at 120');
subplot(133);
imshow(ImTabletsThresheldMedianFiltered, []);
title('The tablets image after filtering');

%% Approach 2
SETablets = strel('disk', 20);
ImTabletsOpened = imopen(ImTablets, SETablets);
ImTabletsOpenedRegionalMax = imregionalmax(ImTabletsOpened);

% Results
figure();
subplot(131);
imshow(ImTablets, []);
title('The original tablets image');
subplot(132);
imshow(ImTabletsOpened, []);
title('The tablets image opened with a disk SE of radius 20');
subplot(133);
imshow(ImTabletsOpenedRegionalMax, []);
title('The tablets image after taking regional maxima');

%% 2.2 Broken cookies
ImCookies = double(imread('cookies_broken.png'));

ImCookiesThresheld = double(ImCookies > 50);

SECookies = strel('disk', 60);
ImCookiesWTH = imtophat(ImCookiesThresheld, SECookies);


% Results
figure();
subplot(131);
imshow(ImCookies, []);
title('The original cookies image');
subplot(132);
imshow(ImCookiesThresheld, []);
title('The cookies image thresheld');
subplot(133);
imshow(ImCookiesWTH, []);
title('The cookies image White Top Hat with a disk SE of radius 60');

%% 2.3 Area of chocolates
ImChocos = double(imread('chocos.jpg'));
% Extract the chocolates
ImChocosThresheld = double(ImChocos < 40);
% Deal with the edges
SECookies = strel('square', 9);
ImChocosThresheldOpened = imopen(ImChocosThresheld, SECookies);
% % Region labeling (not neccessary)
% ImChocosThresheldOpenedLabeled = bwlabel(ImChocosThresheldOpened);

[counts, binLocations] = imhist(ImChocosThresheldOpened);
areaChocos = counts(end);

% Results
figure();
subplot(221);
imshow(ImChocos, []);
title('The original cookies image');
subplot(222);
imshow(ImChocosThresheld, []);
title('The original cookies image thresheld');
subplot(223);
imshow(ImChocosThresheldOpened, []);
title('The original cookies image opened');
subplot(224);
imhist(ImChocosThresheldOpened);

%% 2.4 Caps of bottles
ImCaps = double(imread('bottles.png'));
% Deal with the edges
SECaps = strel('disk', 5, 4);
ImCapsOpened = imopen(ImCaps, SECaps);
% Extract the chocolates
ImCapsThresheld = double(ImCapsOpened > 217);

% Results
figure();
subplot(131);
imshow(ImCaps, []);
title('The original caps image');
subplot(132);
imshow(ImCapsOpened, []);
title('The original caps image opened');
subplot(133);
imshow(ImCapsThresheld, []);
title('The original caps image thresheld');

%% 2.5 Retina
ImRetina = double(imread('retina.png'));

%% Extract the vessels
SEVessels = strel('disk', 6);
ImRetinaVesselsOpened = imbothat(ImRetina, SEVessels);
ImRetinaVesselsThresheld = double(ImRetinaVesselsOpened > 4000); % will get some salt & pepper noise
ImRetinaVesselsFiltered = medfilt2(ImRetinaVesselsThresheld);

% Results
figure();
subplot(221);
imshow(ImRetina, []);
title('The original retina image');
subplot(222);
imshow(ImRetinaVesselsOpened, []);
title('The retina image White Top Hat');
subplot(223);
imshow(ImRetinaVesselsThresheld, []);
title('The retina image thresheld');
subplot(224);
imshow(ImRetinaVesselsFiltered, []);
title('The retina image median filtered');

%% Extract the nerve
SENerve = strel('disk', 100);
ImRetinaNerveOpened = imtophat(ImRetina, SENerve);
ImRetinaNerveThresheld = double(ImRetinaNerveOpened > 35000); % will get some salt & pepper noise
ImRetinaNerveFiltered = medfilt2(ImRetinaNerveThresheld);

% Results
figure();
subplot(221);
imshow(ImRetina, []);
title('The original retina image');
subplot(222);
imshow(ImRetinaNerveOpened, []);
title('The retina image White Top Hat');
subplot(223);
imshow(ImRetinaNerveThresheld, []);
title('The retina image thresheld');
subplot(224);
imshow(ImRetinaNerveFiltered, []);
title('The retina image median filtered');

%% Enhance the original image
ImRetinaBackground = double(ImRetina < 20000);
ImRetinaEnhanced = ImRetina + 65535/15*ImRetinaBackground;
ImRetinaSmooth = medfilt2(ImRetinaEnhanced);

% Results
figure();
subplot(221);
imshow(ImRetina, []);
title('The original retina image');
subplot(222);
imshow(ImRetinaBackground, []);
title('The background of the retina image');
subplot(223);
imshow(ImRetinaEnhanced, []);
title('The enhanced retina image');
subplot(224);
imshow(ImRetinaSmooth, []);
title('The smooth retina image');

%% 2.6 Aligned cookies
clear all;
ImLines = imread('cookies_lines_misal.png');
SEDisk = strel('disk', 33, 0);
ImLinesClosed = imclose(ImLines, SEDisk);
SERec = strel('rectangle', [550 25]);
ImLinesOpened = imopen(ImLinesClosed, SERec);
ImLinesThresheld = (ImLinesOpened > 125);

% Results
figure();
subplot(221);
imshow(ImLines, []);
title('The original cookies image');
subplot(222);
imshow(ImLinesClosed, []);
title('The cookies image closed');
subplot(223);
imshow(ImLinesOpened, []);
title('The cookies image opened');
subplot(224);
imshow(ImLinesThresheld, []);
title('The cookies image thresheld');