function [ResImg] = MedianFilter(Img,k)
    [h,w,c] = size(Img);
%     if(c==3)
%        Img = rgb2gray(Img) 
%     end
    
    Img = double(Img);
    
    ResImg = zeros(h,w);
    GaussianFiltered = lab2gaussfilt(Img);
    for i=k+1:1:h-k-1
        for j=k+1:1:w-k-1
            Window = Img(i-k:i+k,j-k:j+k);
            value = myMedian(Window);
            ResImg(i,j) = value;
        end
    end
    Img = uint8(Img);
    ResImg = uint8(ResImg);
    figure
    subplot(1,3,1);
    imshow(Img);
        title 'Original Image'
    subplot(1,3,2);
    imshow(GaussianFiltered);
        title 'Gaussian Filtered Image'
    subplot(1,3,3);
    imshow(ResImg);
        title 'Median Filtered Image'
end