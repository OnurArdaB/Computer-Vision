function[I_edge] = Sobel(I,T)
[r,c,ch] = size(I);
if(ch == 3)
    Im = rgb2gray(I);
end

Im =double(Im);

X_filter = [ -1 0 1 ; -2 0 2; -1 0 1 ];
Y_filter =  [-1 -2 -1 ; 0 0 0; 1 2 1];

x_der = conv2(Im,X_filter,"same");
y_der = conv2(Im,Y_filter,"same");
gradient_magnitude = (x_der.^2 + y_der.^2).^(1/2);

I_edge = zeros(size(Im));
Enhanced = find(gradient_magnitude > T);
I_edge(Enhanced) = 255;

figure
    subplot(2,3,1)
        imshow(uint8(Im));
        title("Original Image");

    subplot(2,3,2)
        imshow(uint8(x_der));
        title("Sobel X filtered Image");

    subplot(2,3,3)
        imshow(uint8(y_der));
        title("Sobel Y filtered Image");

    subplot(2,3,5)
        imshow(uint8(gradient_magnitude));
        title("Sobel Gradient");

    subplot(2,3,6)
    I_edge= I_edge
    imshow(I_edge);
        title("Sobel Edges");
end                