function [Jnew]=ConditionalScaling(Im,Iref)

[h,w,c]=size(Im);

if c==3
    Im = rgb2gray(Im);
end

[h,w,c_r]=size(Iref);

if c_r==3
    Iref = rgb2gray(Iref);
end

J=double(Im);
I=double(Iref);


b = std(I(:))/std(J(:));

a = mean(I(:))/b-mean(J(:));

Jnew=b*(J+a);
disp([ mean(I(:)),mean(J(:)),mean(Jnew(:))]);
disp([ std(I(:)),std(J(:)),std(Jnew(:))]);

Jnew=uint8(Jnew);
subplot(2,2,1),imshow(Iref);
title("Reference Image");
subplot(2,2,3),imshow(Im);
title("Original Image");

subplot(2,2,4),imshow(Jnew);
title("Scaled Image");

end