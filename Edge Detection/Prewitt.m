function [I_edge] = Prewitt(I,T)
[r,c,ch] = size(I);
if(ch == 3)
    Im = rgb2gray(I);
end

Im =double(Im);



Sx = [ -1 0 1 ; -1 0 1; -1 0 1 ];
Sy =  [-1 -1 -1 ; 0 0 0; 1 1 1];
Gx = zeros(size(Im));
Gy = zeros(size(Im));
    k=1;
    for i=k+1:1:r-k-1
        for j=k+1:1:c-k-1
            Window = Im(i-k:i+k,j-k:j+k);
            Xvalue = sum(sum(Window.*Sx));
            Yvalue = sum(sum(Window.*Sy));
            Gx(i,j) = Xvalue;
            Gy(i,j) = Yvalue;
        end
    end
gradient_magnitude = (Gx.^2 + Gy.^2).^(1/2);

I_edge = zeros(size(Im));
Enhanced = find(gradient_magnitude > T);
I_edge(Enhanced) = 255;

figure
subplot(2,3,1)
imshow(uint8(Im));
title("Original Image");

subplot(2,3,2)
imshow(uint8(Gx));
title("Prewitt X filtered Image");

subplot(2,3,3)
imshow(uint8(Gy));
title("Prewitt Y filtered Image");

subplot(2,3,5)
imshow(uint8(gradient_magnitude));
title("Prewitt Gradient");

subplot(2,3,6)
I_edge = uint8(I_edge);
imshow(I_edge);
title("Prewitt Edges");
end