function [Corners_Filtered] = TomasiKanadeCornerDetection(img)

[r,c,channel] = size(img);
if (channel ==3)
    img = rgb2gray(img);
end

Corners_Filtered = zeros(size(img));
img = double(img);
Corners_Filtered = double(Corners_Filtered);
[Gx,Gy] = imgradientxy(img); 

T=100000
k=1;
corners = [];
Simg = lab2gaussfilt(img);
%Simg = imgaussfilt(img,2); %BUILT-IN METHOD
for i = k+1:1:r-k-1
    for j=k+1:1:c-k-1
        Gx_window = Gx(i-k:i+k,j-k:j+k);
        Gy_window = Gy(i-k:i+k,j-k:j+k);
        
        I_x2= Gx_window .* Gx_window;
        I_xy= Gx_window .* Gy_window;
        I_y2= Gy_window .* Gy_window;
        
        I_x2= sum(I_x2(:));%sum all elements
        I_xy= sum(I_xy(:));
        I_y2= sum(I_y2(:));
        
        H = [I_x2, I_xy;
             I_xy, I_y2];
        e = eig(H);
        lambda1 = e(1);
        lambda2 = e(2);
        
        if (min(lambda1,lambda2) > T)
            corners = [corners; i,j];
        end
    end
end
img = int8(img);
figure
imshow(img)
hold on;
plot(corners(:,2),corners(:,1),'r.')
title('Kanade-Tomasi corner detection');
disp(corners)
end
