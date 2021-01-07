function[ResImg] = Sharpening(Img,lambda,M)
    [h,w,channel] = size(Img);
    if (channel ==3)
        Img = rgb2gray(Img);
    end
    Img =double(Img);

    if (M ==1) 
        Smoothed = lab1locbox(Img,5);
    elseif (M ==2)
        Smoothed = lab2gaussfilt(Img); 
    elseif (M==3) 
        Smoothed = lab2medfilt(Img,5);
    end

    residual = Img - double(Smoothed)
    scale = lambda * residual
    ResImg = Img + scale;

    ResImg = uint8(ResImg);
    Img = uint8(Img);
    Smoothed = uint8(Smoothed);
    
    figure
    subplot(1,3,1);
    imshow(Img);
        title 'Original Image';
    subplot(1,3,2);
    imshow(Smoothed);
        title 'Smoothened Image';
    subplot(1,3,3);
    imshow(ResImg);
        title 'Sharpened Image';

end