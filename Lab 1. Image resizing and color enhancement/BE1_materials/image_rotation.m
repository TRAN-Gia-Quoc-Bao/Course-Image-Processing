% function image_rotation()
% 	I=double(imread('cameraman.png'))/255;
% 	figure
% 	imshow(I); axis image; colormap gray;
% 	theta=0.2;			%angle de rotation en radians
% 	J=rotation(I,theta);
% 	figure
% 	imshow(J); axis image; colormap gray;
% 	J2=rotation(J,-theta);
% 	figure
% 	imshow(J2); axis image; colormap gray;
% end


function J = rotation(I,theta)					
	[sizey,sizex]=size(I);
	J=zeros(sizey,sizex);  	%it will contain the rotated image
	for kx=1:sizex			%spans on every pixel of the image J
		for ky=1:sizey
            %we compute the position where we want the value of the pixel in the initial image
			posx=(kx-sizex/2)*cos(theta)-(ky-sizey/2)*sin(theta)+sizex/2;
			posy=(kx-sizex/2)*sin(theta)+(ky-sizey/2)*cos(theta)+sizey/2;
			%it spans on the neighborhood of this pixel
			for lx=max(ceil(posx-2),1):min(floor(posx+2),sizex) 
				for ly=max(ceil(posy-2),1):min(floor(posy+2),sizey)
					J(ky,kx)=J(ky,kx)+I(ly,lx)*keys2D(ly-posy,lx-posx);
				end
			end
		end
	end
end


%Keys' cubic interpolation function. Its support is [-2,2]
function v = keys2D(x,y)
	v=keys1D(x)*keys1D(y);
end


%Keys' cubic interpolation function. Its support is [-2,2]
function v = keys1D(x)
	x=abs(x);
	if x>=2
        v=0;
    elseif x>1
        v=x*(-4+x*(5-x)/2)+2;
    else
        v=1+x*x*(3*x-5)/2;
    end
end