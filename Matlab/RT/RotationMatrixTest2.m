
clear
clc
syms x y z
Rx=[1, 0,     0;
    0, 1,-sin(x);
    0,sin(x),1];
Ry=[1,0,sin(y);
    0,1,0;
    -sin(y),0,1];
Rz=[1,-sin(z),0;
    sin(z),1,0;
    0,0,1];
R=Rx*Ry*Rz