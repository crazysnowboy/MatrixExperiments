clear
close all
clc
movingPoints = [11 11;21 11; 21 21]
movingPoints(:,3)=1;
fixedPoints  = [51 51;61 55; 61 61]
fixedPoints(:,3)=1;
transform=inv(movingPoints)*fixedPoints
figure(1);
for k=1:3
    plot(movingPoints(k,1),movingPoints(k,2),'-r*');
    hold on
end
fill(movingPoints(:,1),movingPoints(:,2),'y');
axis([1 100 1 100])
    

figure(2);
for k=1:3
    plot(fixedPoints(k,1),fixedPoints(k,2),'-g*');
    hold on
end
fill(fixedPoints(:,1),fixedPoints(:,2),'r');
axis([1 100 1 100])

tform = fitgeotrans(movingPoints(:,1:2),fixedPoints(:,1:2),'affine');
T=tform.T


res=movingPoints*T;


figure(3);
for k=1:3
    plot(res(k,1),res(k,2),'-g*');
    hold on
end
% fill(res(:,1),res(:,2),'r');
axis([1 100 1 100])
