close all
clear
clc
syms tx ty sx sy shx shy q
Translation=[1  0   0;
             0  1   0;
             tx ty  1];
         
scale=[sx 0 0;
       0 sy 0;
       0 0 1 ];
   
Shear=[1  shy  0;
       shx 1   0;
       0   0   1];
rotation=[ cos(q)  sin(q)  0;
          -sin(q)  cos(q)  0;
            0        0     1];
        
        
syms x1 x2 x3 y1 y2 y3
P=[x1,y1 1;
    x2,y2 1;
    x3,y3 1]


P2=P*Translation
P3=P*scale
P4=P*Shear
P5=P*rotation
   