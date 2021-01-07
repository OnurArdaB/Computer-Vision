function [ResImg] = GaussianFilter(Img)
    
    [h,w,ch] = size(Img);
    
    if(ch==3)
        Img = rgb2gray(Img);
    end

    GaussianMatrix = (1/273.) * [ 1 4 7 4 1;
                                   4 16 26 16 4;
                                   7 26 41 26 7;
                                   4 16 26 16 4;
                                   1 4 7 4 1];
    Img = double(Img);
    FilteredImg = zeros(size(Img));
    k = 2; %since the filter functioin (2k+1)^2
    
%     for i = 1+k:1:h-k-1
%         for j = 1+k:1:w-k-1
%             Window = Img(i-k:i+k , j-k:j+k);
%             value = sum(sum(Window.*GaussianMatrix));
%             FilteredImg(i,j) = value;
%         end
%     end
%%%%Method 2:conv2 which only applicable for linear filters
    FilteredImg = conv2(Img,GaussianMatrix,'same');
    ResImg = uint8(FilteredImg);
    figure;
    subplot(1,2,1);
    imshow(uint8(Img));
    title 'Original';
    subplot(1,2,2);
    imshow(ResImg);
    title 'Gaussian Filtered';
end