function [Imax,Imin] = MaxMinFilterComparison(Im,ws)
%ws is k in tutorial
[h,w,c]=size(Im);

if c==3
    Im = rgb2gray(Im);
end

I = double(Im);

[h,w,c]=size(I);

Imax = zeros(h,w);
Imin = zeros(h,w);

for i = ws+1:h-ws
    for j = ws+1:w-ws
        wp=I(i-ws:i+ws,j-ws:j+ws);
        Imax(i,j)=max(wp(:));
        Imin(i,j)=min(wp(:));
    end
end

Imax=uint8(Imax);
Imin=uint8(Imin);

subplot(1,3,1),imshow(Im);
title 'Original'
subplot(1,3,2),imshow(Imax);
title 'Local Max Filter'

subplot(1,3,3),imshow(Imin);
title 'Local Min Filter'

end