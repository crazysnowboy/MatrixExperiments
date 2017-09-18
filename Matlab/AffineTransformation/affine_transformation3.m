clear
close all
clc
movingPoints = [11 11;21 11; 21 21]
movingPoints(:,3)=1;
figure(1);
for k=1:3
    plot(movingPoints(k,1),movingPoints(k,2),'-r*');
    hold on
end
fill(movingPoints(:,1),movingPoints(:,2),'y');
axis([1 100 1 100])
    

tx=10;
ty=10;
q=0.5;
Translation=[1  0   0;
             0  1   0;
             tx ty  1];
         

rotation=[ cos(q)  sin(q)  0;
          -sin(q)  cos(q)  0;
            0        0     1];
        
        
fixedPoints=movingPoints*Translation;  
figure(2);
for k=1:3
    plot(fixedPoints(k,1),fixedPoints(k,2),'-g*');
    hold on
end
fill(fixedPoints(:,1),fixedPoints(:,2),'r');
axis([1 100 1 100])


fixedPoints=fixedPoints*rotation ; 
figure(3);
for k=1:3
    plot(fixedPoints(k,1),fixedPoints(k,2),'-g*');
    hold on
end
fill(fixedPoints(:,1),fixedPoints(:,2),'r');
axis([1 100 1 100])



fixedPoints=movingPoints*rotation*Translation ; 
figure(4);
for k=1:3
    plot(fixedPoints(k,1),fixedPoints(k,2),'-g*');
    hold on
end
fill(fixedPoints(:,1),fixedPoints(:,2),'r');
axis([1 100 1 100])
