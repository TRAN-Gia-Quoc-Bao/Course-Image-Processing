function J = myrotation(I,theta)					
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