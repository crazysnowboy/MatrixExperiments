clear
close all
clc
cb = checkerboard;
imshow (cb)

Rcb = imref2d(size(cb))
A = [1 0 0;
    0 1 0;
    20 20 1]
tform = affine2d(A);


[out, rout] = imwarp (cb, tform);
figure;
subplot (1, 2, 1);
imshow (cb, Rcb);
subplot (1, 2, 2);
imshow (out, rout)

rout = Rcb;
rout.XWorldLimits (2) = rout.XWorldLimits (2) +20;
rout.YWorldLimits (2) = rout.YWorldLimits (2) +20;

[out, rout] = imwarp (cb, tform, 'OutputView' , rout);

figure, subplot (1, 2, 1);
imshow (cb, Rcb);
subplot (1, 2, 2);
imshow (out, rout)
