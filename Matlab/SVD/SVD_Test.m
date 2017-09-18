%%%%%%%%%%%%%%%%%%%%%%%%%%  
%修改第9行的图像路径即可，图像格式不限  
%2013.1.12 yangxin_szu  
%%%%%%%%%%%%%%%%%%%%%%%%%%  
%%  
clear all;  
clc;  
close all
%导入图像  
X = imread('1.jpg');  
if (size(X,3) ~= 1)   
   X = rgb2gray(X);  
end  
%奇异值分解  
[U S V] = svd(double(X));  
%绘制奇异值的分布曲线  
plot(diag(S),'b-','LineWidth',3);  
title('图像矩阵的奇异值');  
ylabel('奇异值');  
%图像大小  
[m n] = size(X);  
%图像矩阵的秩  
Rank = rank(double(X));  
%显示原图  
figure,subplot(1,2,1),imshow(X);  
Image_Rank = ['图像矩阵的秩 = ' int2str(Rank)];  
title(Image_Rank,'Color','b');  
%%  
%循环改变奇异值选取的个数，动态观察图像压缩的效果  
%循环次数  
it = 1;  
iter = floor((Rank/4 - 1)/10 +1);  
%保存奇异值的个数  
K_Store = ones(iter);  
%保存不同奇异值个数对应的压缩比  
CR_store = ones(iter);  
for K=1:10:Rank/16  
    figure
    K_Store(it) = K;  
    %选取K个奇异值，并恢复原图  
    R = U(:,1:K)*S(1:K,1:K)*V(:,1:K)';  
    T = uint8(R);  
    %显示恢复结果  
    imshow(T);  
    SVD_number = ['选取的奇异值的个数 = ' int2str(K)];  
    title(SVD_number,'Color','b');  
    %计算压缩比  
    src_elements = m*n;  
    compress_elements = m*K + K*K + K*n;  
    compress_ratio = (1 - compress_elements/src_elements)*100;  
    CR_store(it) = compress_ratio;  
    it = it+1;  
    fprintf('Rank = %d : K = %d 个: compress_ratio = %.2f\n',Rank,K,compress_ratio);  
    %暂停0.5秒，便于观察效果  
    pause(0.5);  
end  
%%  
%绘制奇异值个数与压缩比的关系曲线  
figure,plot(K_Store,CR_store,'b-','LineWidth',3);  
title('奇异值个数与压缩比的关系');  
xlabel('奇异值个数');  
ylabel('压缩比');  