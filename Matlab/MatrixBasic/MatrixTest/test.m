close all
clear
clc
root_path='/home/collin/Documents/MyProjects/AAAAAA/bs2dfitting/data/metrixdata/';

h=2;w=2;

A=rand(h,w)
SaveMat2Txt([root_path,'A.txt'],A)

X=rand(h,1)
SaveMat2Txt([root_path,'x.txt'],X)

At=A'
AtA=At*A
AAt=A*At
C=At*A*X
SaveMat2Txt([root_path,'C.txt'],C)

X2=inv(A'*A)*C
% invA=inv(A)
% B=A*inv(A)



