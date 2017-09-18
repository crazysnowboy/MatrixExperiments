clear;clc;

w1=[1 0 0]';
w2=[0 1 0]';
w3=[0 0 1]';

w=[w1 w2 w3];

rank=rank(w)  %秩 线性无关数量


xi=[5 6 7]';

zi1=w1'*xi
zi2=w2'*xi
zi3=w3'*xi

xr=zi1*w1+zi2*w2