function [Magnitude, Phase, MagnitudeShifted, PhaseShifted] = ImageDFTWithShift(I, shiftNum, nameOfImage)
% Calculate the DFT and shift it to the center
ImageDFT = fftshift(fft2(I));
% Calculate the magnitude, and phase
Magnitude = log(1 + abs(ImageDFT)); % this one is in log scale
Phase = angle(ImageDFT);
% Shift the image, then calculate the DFT and shift it to the center
ImageDFTShifted = fftshift(fft2(circshift(I, shiftNum)));
% Calculate the magnitude, and phase of the shifted image
MagnitudeShifted = log(1 + abs(ImageDFTShifted)); % this one is in log scale
PhaseShifted = angle(ImageDFTShifted);
% Plot the maginitude, and phase to compare
figure();
subplot(221);
imshow(Magnitude, []);
title("The magnitude (in log scale) of the DFT of the " +nameOfImage+ " NO shifting");
subplot(222);
imshow(Phase, []);
title("The phase of the DFT of the " +nameOfImage+ " NO shifting");
subplot(223);
imshow(MagnitudeShifted, []);
title("The magnitude (in log scale) of the DFT of the " +nameOfImage+ " WITH shifting");
subplot(224);
imshow(PhaseShifted, []);
title("The phase of the DFT of the " +nameOfImage+ " WITH shifting");
