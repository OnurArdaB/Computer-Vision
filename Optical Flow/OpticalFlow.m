function OpticalFlow(ImPrev,ImCurr,k,Threshold,smoothener)
% Smooth the input images using a Box filter
% Calculate spatial gradients (Ix, Iy) using Prewitt filter
% Calculate temporal (It) gradient
ImPrev = double(ImPrev);
ImCurr = double(ImCurr);
if(smoothener=="gaussian")
    smoothened_ImPrev = imgaussfilt(ImPrev,2);
    smoothened_ImCurr = imgaussfilt(ImCurr,2);
elseif(smoothener=="box")
    box_filter = ones(3,3);
    smoothened_ImPrev = conv2(ImPrev,box_filter,"same");
    smoothened_ImCurr = conv2(ImCurr,box_filter,"same");
elseif(smoothener=="median")
    smoothened_ImPrev = medfilt2(ImPrev);
    smoothened_ImCurr = medfilt2(ImCurr);
end
% Calculate spatial gradients (Ix, Iy) using Prewitt filter
X_filter = [ -1 0 1 ; -1 0 1; -1 0 1 ];
Y_filter =  [-1 -1 -1 ; 0 0 0; 1 1 1];
%convolve with filters
Ix = conv2(smoothened_ImCurr,X_filter,"same");
Iy = conv2(smoothened_ImCurr,Y_filter,"same");

% Calculate temporal (It) gradient

It = smoothened_ImPrev - smoothened_ImCurr;

[Ydim,Xdim] = size(ImCurr);
Vx = zeros(Ydim,Xdim);
Vy = zeros(Ydim,Xdim);
G = zeros(2,2);
b = zeros(2,1);
    cx=k+1;
    for x=k+1:k:Xdim-k-1
        cy=k+1;
        for y=k+1:k:Ydim-k-1
         % Calculate the elements of G and b
         
            G(1,1)= sum(sum( Ix(y-k:y+k,x-k:x+k).^2 ));
            G(1,2)= sum(sum(Ix(y-k:y+k,x-k:x+k).*Iy(y-k:y+k,x-k:x+k)));
            G(2,1)= sum(sum(Ix(y-k:y+k,x-k:x+k).*Iy(y-k:y+k,x-k:x+k)));
            G(2,2)= sum(sum( Iy(y-k:y+k,x-k:x+k).^2 ));

            b(1,1)= sum(sum(Ix(y-k:y+k,x-k:x+k).*It(y-k:y+k,x-k:x+k)));
            b(2,1)= sum(sum(Iy(y-k:y+k,x-k:x+k).*It(y-k:y+k,x-k:x+k)));
            if (min(eig(G)) > Threshold)
            % Calculate u
            u = -1*(inv(G)* b);
            Vx(cy,cx)=u(1);
            Vy(cy,cx)=u(2);
            else
            Vx(cy,cx)=0;
            Vy(cy,cx)=0;
            end
        cy=cy+k;
        end
    cx=cx+k;
end
cla reset;
imagesc(ImPrev); hold on;
[xramp,yramp] = meshgrid(1:1:Xdim,1:1:Ydim);
quiver(xramp,yramp,Vx,Vy,10,'r');
colormap gray;
end