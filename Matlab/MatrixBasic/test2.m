clc
clear

%酉矩阵
fprintf('-----------------酉矩阵--------------------\r\n');
U=RandomCreateMatrix(5,5,'unitary')
fprintf('酉矩阵性质为： \r\n');
fprintf('1：行列式为1\r\n');

Det_U=det(U)
fprintf('2：与自身转置矩阵相乘为单位矩阵\r\n');
Multi_TS=U*U'
fprintf('3：与自身伴随矩阵相乘为单位矩阵\r\n');
Company_U=inv(U)*det(U); %伴随矩阵
Multi_cS=U*Company_U

%正交矩阵
fprintf('--------------------正交矩阵-------------------\r\n');
Q=RandomCreateMatrix(5,5,'orthogonal')
fprintf('正交矩阵的性质为： \r\n');
fprintf('1：和自身转置相乘得单位矩阵  \r\n');
Qres_E=Q'*Q
fprintf('2：满秩  \r\n');
Q_rank=rank(Q)