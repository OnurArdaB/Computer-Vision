function [median] = myMedian(img)

    [row,col,channels] = size(img);
    Card = row * col;
    
    if (channels == 3)
        img = rgb2gray(img);
    end
    
    img = double(img);
    img = reshape(img, [1 Card]);

    img = sort(img);
   
    if mod(Card,2) == 0
        ind = Card/2;
        median = (img(ind) + img(ind+1) )/2;
    else 
        ind = ( Card+1 ) /2 ;
        median = img(ind);
    end 
end