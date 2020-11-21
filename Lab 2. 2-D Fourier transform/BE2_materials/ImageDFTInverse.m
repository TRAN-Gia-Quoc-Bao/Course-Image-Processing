function [ImageDFTInverse] = ImageDFTInverse(Magnitude, Phase, nameOfImage)
% Calculate the IDFT after shifting back the low frequency parts to the edges
I = zeros(size(Magnitude));
for m = 1:size(Magnitude)
    for n = 1:size(Magnitude)
        I(m, n) = Magnitude(m, n)*cos(Phase(m, n)) + j*Magnitude(m, n)*sin(Phase(m, n));
    end
end
ImageDFTInverse = ifft2(ifftshift(I));
% Plot the image
figure();
imshow(ImageDFTInverse*255, []);
title("The " +nameOfImage+ " recovered from its DFT");



