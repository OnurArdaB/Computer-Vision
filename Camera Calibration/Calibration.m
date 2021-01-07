clear all; close all; clc;

img = imread('Img.jpg');
[row, col, ch]=size(img);
if ch==3
    img_gray = rgb2gray(img);
end

img_edge = edge(img_gray,'canny',[0.1,0.3]);
imshow(img_edge);

%% HOUGH TRANSFORM - Extract Lines

[H, theta, rho] = hough(img_edge,'RhoResolution',0.5,'Theta',-90:0.5:89);
P = houghpeaks(H,500,'threshold',0.1*max(H(:)));
line = houghlines(img_edge,theta,rho,P,'FillGap',50,'MinLength',15);
%% PLOT HOUGHLINES  

figure 
subplot(1,2,1), imshow(img)
subplot(1,2,2), imshow(img_gray)
hold on
for k = 1:length(line)
    xy = [line(k).point1; line(k).point2];
    plot(xy(:,1),xy(:,2),'LineWidth',1,'Color','green');
    plot(xy(1,1),xy(1,2),'x','MarkerSize',4,'Color','yellow');
    plot(xy(2,1),xy(2,2),'x','MarkerSize',4,'Color','red');
    len = norm(line(k).point1 - line(k).point2);
end
hold off

%% SELECT TWO INTERSECTING LINES MANUALLY

% l1 = [2238,3012;2398,3077]; 
% l2 = [2359,2925;2338,3326];
% 
% l3 = [910,2425;1001,2399];
% l4 = [977,2759;1013,2776];
% 
% % Extract corresponding theta (T) and rho (R) values from the output of 'houghlines' function
% 
% for k=1:length(line)
%     if isequal([line(k).point1;line(k).point2],l1)
%         l1_index= k;
%     elseif isequal([line(k).point1;line(k).point2],l2)
%         l2_index= k;
%     elseif isequal([line(k).point1;line(k).point2],l2)
%         l3_index=k;
%     elseif isequal([line(k).point1;line(k).point2],l2)
%         l4_index=k;
%     end;
% end
line1_theta =  line(l1_index).theta 
line1_rho= line(l1_index).rho

line2_theta= line(l2_index).theta
line2_rho= line(l2_index).rho

%% PLOT INTERSECTING LINES

x_v = 0:size(img,1);
x_h = 0:size(img,2);

figure
imshow(img)
hold on 

xPoint = [0,size(img,1)];
yPoint_1 = (line1_rho- xPoint*cosd(line1_theta))/sind(line1_theta);
yPoint_2 = (line2_rho- xPoint*cosd(line2_theta))/sind(line2_theta);

plot(xPoint,yPoint_1,'LineWidth',2,'Color','m');
plot(xPoint,yPoint_2,'LineWidth',2,'Color','m');

%%  Solving the 2 line equations to find intersection point (corner)

A = [cosd(line1_theta) , sind(line1_theta);
     cosd(line2_theta) , sind(line2_theta)]
B = [line1_rho;line2_rho];
value = inv(A) * B;

%% HARRIS CORNERS
C = corner(img_gray,'harris');
%% PLOTTING CORNERS FOR COMPARISON
plot(C(:,1),C(:,2),"mo","MarkerSize",6);
plot(value(1),value(2),"m","MarkerSize",6);
