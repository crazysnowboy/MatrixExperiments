close all
clear
clc
syms tx ty tz sx sy sz
Translation=[1  0   0  0;
             0  1   0  0;
             0  0   1  0;
             tx ty  tz 1];
         
scale=[sx 0  0  0;
       0  sy 0  0;
       0  0  sz 0
       0  0  0  1];
   
syms a b c 
ShearXY=[1  0  0  0;
         0  1  0  0;
         a  b  1  0;
         0  0  0  1];
     
ShearXZ=[1  0  0  0;
         a  1  c  0;
         0  0  1  0;
         0  0  0  1];

ShearYZ=[1  b  c  0;
         0  1  0  0;
         0  0  1  0;
         0  0  0  1];
    
syms qz qy qx

rotationX=[   1        0       0       0;
              0     cos(qx)  sin(qx)   0;
              0    -sin(qx)  cos(qx)   0;
              0        0       0       1];
          
rotationY=[ cos(qy)    0   -sin(qy)     0;
              0        1     0          0;
            sin(qy)    0    cos(qy)     0;
              0        0     0          1];
          
rotationZ=[ cos(qz)  sin(qz)   0   0;
           -sin(qz)  cos(qz)   0   0;
              0        0       1   0;
              0        0       0   1];
          

        
syms x1 x2 x3 y1 y2 y3 z1 z2 z3
P=[x1,y1 z1 1;
    x2,y2 z2 1;
    x3,y3 z3 1]


P2=P*Translation
P3=P*scale
P4=P*ShearXY*ShearXZ*ShearYZ
P5=P*rotationX*rotationY*rotationZ
   