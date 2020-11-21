function I_out=Contrast_stretching(I_in,a,b,va,vb)

% Contrast stretching performs piecewise linear trasformation of the image
% levels of I_in mapping the interval [a,b] to the interval [va,vb]; the
% ouside ranges are mapped to cover the full available dynamic range
% [0,255]

I_max=255; 
I_out = uint8(zeros(size(I_in)));

alpha = va/a;
beta = (vb-va)/(b-a);
gamma = (I_max-vb)/(I_max-b);

IndA = find(I_in < a);
I_out(IndA)=I_in(IndA)*alpha;
IndB = find((I_in >= a) & (I_in <= b));
I_out(IndB)=va+(I_in(IndB)-a)*beta;
IndC = find(I_in > b);
I_out(IndC)=vb+(I_in(IndC)-b)*gamma;

end