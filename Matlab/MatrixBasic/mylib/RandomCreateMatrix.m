function A=RandomCreateMatrix(w,h,type)
    Src=rand(w,h);
%     fprintf('RandomCreateMatrix:creat %s matrix \r\n',type);
    if Equal(type,'orthogonal') %正交矩阵
        [Q,R]=qrhs(Src);
        A=Q;
    elseif Equal(type,'unitary')
        [U,S,V]=svd(Src);
        A=U;
    end

end
function res=Equal(Com1,Com2)
    res=0;
    if length(Com1)==length(Com2)
        if Com1==Com2
            res=1;
        end
    end
end
function [Q,R]=qrhs(A)
% 基于Householder变换，将方阵A分解为A=QR，其中Q为正交矩阵，R为上三角阵
%
% 参数说明
% A：需要进行QR分解的方阵
% Q：分解得到的正交矩阵
% R：分解得到的上三角阵
%
% 实例说明
% A=[-12 3 3;3 1 -2;3 -2 7];
% [Q,R]=qr(A) % 调用MATLAB自带的QR分解函数进行验证
% [q,r]=qrhs(A) % 调用本函数进行QR分解
% q*r-A % 验证 A=QR
% q'*q % 验证q的正交性
% norm(q) % 验证q的标准化，即二范数等于1
%
% 线性代数基础知识
% 1.B=P*A*inv(P)，称A与B相似，相似矩阵具有相同的特征值
% 2.Q*Q'=I，称Q为正交矩阵，正交矩阵的乘积仍为正交矩阵
%
% 注意：我们也可以基于Givens变换，对方阵A进行QR分解，但是相对繁琐些，参见http://www.matlabsky.com/thread-4850-1-1.html
%
% by dynamic of Matlab技术论坛
% see also http://www.matlabsky.com
% contact me matlabsky@gmail.com
% 2010-01-17 22:49:51
%
n=size(A,1);
R=A;
Q=eye(n);
for i=1:n-1
    x=R(i:n,i);
    y=[1;zeros(n-i,1)];
    Ht=householder(x,y);
    H=blkdiag(eye(i-1),Ht);
    Q=Q*H;
    R=H*R;
end
end

function [H,rho]=householder(x,y)
% 求解正交对称的Householder矩阵H，使Hx=rho*y，其中rho=-sign(x(1))*||x||/||y||
%
% 参数说明
% x：列向量
% y：列向量，x和y必须具有相同的维数
%
% 实例说明
% x=[3 5 6 8]';
% y=[1 0 0 0]';
% [H,rho]=householder(x,y);
% H*x-rho*y % 验证Hx=rho*y
% H'*H % 验证正交
%
% 关于HouseHolder变换
% 1.H=I-2vv'，其中||v||=1，我们称H为反射(HouseHolder)矩阵，易证H对称且正交
% 2.如果||x||=||y||，那么存在HouseHolder矩阵H=I-2vv，其中v=±(x-y)/||x-y||，使Hx=y
% 3.如果||x||≠||y||，那么存在HouseHolder矩阵H，使Hx=rho*y，其中rho=-sign(x(1))*||x||/||y||
% 4.Householder矩阵，常用于将一个矩阵A通过正交变换对角阵
%
x=x(:);
y=y(:);
if length(x)~=length(y)
    error('The Column Vectors X and Y Must Have The Same Length!');
end
rho=-sign(x(1))*norm(x)/norm(y);
y=rho*y;
v=(x-y)/norm(x-y);
I=eye(length(x));
H=I-2*v*v';
end