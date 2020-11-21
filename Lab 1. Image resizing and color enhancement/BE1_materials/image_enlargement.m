function main()
	I = double(imread('cameraman.png'))/255;
	figure(10);
	imshow(I); axis image; colormap gray;
    title('The original cameraman image');
% 	factor = 1.3;	
    factor = 0.7;
	J=enlargement(I, factor);
	figure(11);
	imshow(J); axis image; colormap gray;
    if factor > 1, title(['The cameraman image enlarged by ', num2str(factor)]);
	elseif factor < 1, title(['The cameraman image reduced by ', num2str(factor)]); 
	else title('The cameraman image "enlarged" by 1');
	end;
    ;
end


function J = enlargement(I,factor);						
	[sizey,sizex]=size(I);
	sizeJx = floor(sizex*factor);
	sizeJy = floor(sizey*factor);
	J=zeros(sizeJy,sizeJx);  %it will contain the enlarged image
	for kx=1:sizeJx		%spans on every pixel of the image J
		for ky=1:sizeJy
            % compute the position where we want the value of the pixel in the initial image
            % => multiply by the factor
			posx = kx/factor; 
			posy = ky/factor; 
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
	if x>=2, v=0;
	elseif x>1, v=x*(-4+x*(5-x)/2)+2; 
	else v=1+x*x*(3*x-5)/2;
	end;
end