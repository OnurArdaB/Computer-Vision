function [E] = LoG(I,T1,T2)
%% Step 1: Input image convert to grayscale
[r,c,channel] = size(I);
if (channel ==3)
    I = rgb2gray(I);
end
%% Step 2:Blur the image , using Gaussian
J = imgaussfilt(I);
%% Step 3: Perform the G on the blurred image
W = [ 0 1 0 ; 1 -4 1 ; 0 1 0 ];
G = conv2(J,W,'same');
%% Step 4:Find the zero crossing of the G and compare the local change at this point to a threshold
E = zeros(r,c);
k = 1;
for i = k+1:1:r-k-1
    for j=k+1:1:c-k-1
        if (abs(G(i,j)) >= T1)
            if (( G(i,j) * G(i-1,j) < 0) &&  (abs(G(i,j) - G(i-1,j)) >= T2))
               E(i,j) = 255;
            elseif (( G(i,j) * G(i+1,j) < 0) &&  (abs(G(i,j) - G(i+1,j)) >= T2))
               E(i,j) = 255;
            elseif (( G(i,j) * G(i,j-1) < 0) &&  (abs(G(i,j) - G(i,j-1)) >= T2))
               E(i,j) = 255;
            elseif (( G(i,j) * G(i,j+1) < 0) &&  (abs(G(i,j) - G(i,j+1)) >= T2))
               E(i,j) = 255;
            end
        else 
               if (( G(i+1,j) * G(i-1,j) < 0) &&  (abs(G(i+1,j) - G(i-1,j)) >= T2))
                   E(i,j) = 255;
               elseif (( G(i,j+1) * G(i,j-1) < 0) && (abs(G(i,j+1) - G(i,j-1)) >= T2))
                   E(i,j) = 255;
               end
        end
    end
end
%% Visualization
I =uint8(I);
E = uint8(E);
figure
subplot(1,3,1)
imshow(I)
title("Original Image");

subplot(1,3,2)
imshow(G,[])
title("Laplacian of the image");

subplot(1,3,3)
imshow(E)
title("LoG edges");

end
