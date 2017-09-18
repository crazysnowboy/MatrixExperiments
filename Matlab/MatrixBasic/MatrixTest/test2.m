h=10;
w=10;
A=zeros(h,w);
base=0;
interval=0.1;
for i=1:h
    A(i,:)=[base:interval:(base+interval*9)];
    base=base+interval*10;
end
detA=det(A) %行列式
A
rA=rank(A) %Rank
tA=rref(A) % 初等行变换
% invA=inv(A)

[U S V] = svd(double(A))

AA=U*S*V


