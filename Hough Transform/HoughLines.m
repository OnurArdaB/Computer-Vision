
function [H,theta,rho]= HoughLines(I)
[row,col,ch] = size(I)
if(ch==3)
    I = rgb2gray(I);
end

canny =  edge(I,'Canny');

figure('Name','Hough Transform','NumberTitle','off')
subplot(2,2,1)
imshow(uint8(I))
title("Original Image")
subplot(2,2,2)
imshow(canny)
title("Edges using Canny Edge Detecor")


    [H,theta,rho] = hough(canny,'RhoResolution',0.5,'Theta',-90:0.5:89);
    peaks = houghpeaks(H, 20, 'Threshold',0.7*max(H(:)));
    lines = houghlines(canny,theta,rho,peaks,'FillGap',10,'MinLength',40);

    subplot(2,2,3)
    imshow(imadjust(rescale(H)),'XData',theta,'YData',rho,'InitialMagnification','fit');
    title("Hough Transform")
    xlabel('\theta'), ylabel('\rho');
    axis on, axis normal;

    figure
    imshow(H,[],'XData',theta,'YData',rho,'InitialMagnification','fit');
    xlabel('\theta'), ylabel('\rho');
    axis on, axis normal, hold on;
    title("Hough with peaks")
    plot(theta(peaks(:,2)),rho(peaks(:,1)),"s",'color','white');


    figure,imshow(uint8(I)),hold on

    max_len = 40%0;
    min_len = 2000%200;
    
for k = 1:length(lines)
       xy = [lines(k).point1; lines(k).point2];
       plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

      
       plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
       plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

       
       len = norm(lines(k).point1 - lines(k).point2);
       if ( len > max_len)
          max_len = len;
          xy_long = xy;
       end
       if( len < min_len)
           min_len = len;
           xy_short = xy;
       end
       
    end
    plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','cyan');
    plot(xy_short(:,1),xy_short(:,2),'LineWidth',2,'Color','red');
    title(sprintf("Lines with Max: %3.0f Min: %3.0f",sqrt(max_len),sqrt(min_len)))

end
