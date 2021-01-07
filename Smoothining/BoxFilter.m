function [Knew] = BoxFilter(Im,ws)
%ws is k in tutorial
[h,w,c]=size(Im);

if c==3
    disp('RGB TO RED');
    Im = rgb2gray(Im);
end

I = double(Im);

[h,w,c]=size(I);
Knew = zeros(h,w);
for i = ws+1:h-ws
    for j = ws+1:w-ws
        wp=I(i-ws:i+ws,j-ws:j+ws);
        Knew(i,j)=mean(wp(:));
    end
end
Knew = uint8(Knew);
subplot(2,1,1),imshow(uint8(Im));
title 'Original'
subplot(2,1,2),imshow(Knew);
strTo = num2str(ws);
strTo = append('Filtered k=' , strTo);
title(strTo);
disp(num2str(ws));
end