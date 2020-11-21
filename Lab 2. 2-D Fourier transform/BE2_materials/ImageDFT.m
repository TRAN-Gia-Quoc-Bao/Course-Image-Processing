function [RealPart, ImagPart, Magnitude, Phase, ImageDFT] = ImageDFT(I, nameOfImage)
% Calculate the DFT and shift it to the center
ImageDFT = fftshift(fft2(I));
% Calculate the real part, imaginary part, magnitude, and phase
RealPart = real(ImageDFT);
ImagPart = imag(ImageDFT);
Magnitude = log(1 + abs(ImageDFT)); % this one is in log scale
Phase = angle(ImageDFT);
% Plot all the the real part, imaginary part, maginitude, and phase
figure();
subplot(221);
imshow(RealPart, []);
title("The real part of the DFT of the " +nameOfImage);
subplot(222);
imshow(ImagPart, []);
title("The imaginary part of the DFT of the " +nameOfImage);
subplot(223);
imshow(Magnitude, []);
title("The magnitude (in log scale) of the DFT of the " +nameOfImage);
subplot(224);
imshow(Phase, []);
title("The phase of the DFT of the " +nameOfImage);

figure();
imshow(Magnitude, []);
title("The magnitude (in log scale) of the DFT of the " +nameOfImage);