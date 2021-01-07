function [centersBright, radiiBright,centersDark, radiiDark] = lab4houghcircles(I)

[row,col,ch] = size(I);
    img = I;
    if (ch==3)
        img = rgb2gray(img);
    end
    
Rmin = 20;Rmax = 60;Sens = 0.9;

[centersBright, radiiBright] = imfindcircles(I,[Rmin Rmax],'ObjectPolarity','bright','Sensitivity',Sens);
[centersDark, radiiDark] = imfindcircles(I,[Rmin Rmax],'ObjectPolarity','dark','Sensitivity',Sens);

imshow(I),title(sprintf('Detected Circles using Hough Transform \n %d =< Radius =< %d & Sensitivity = %.2d', Rmin, Rmax, Sens)), hold on

viscircles(centersBright, radiiBright,'Color','b');
viscircles(centersDark, radiiDark,'LineStyle','--');


end
