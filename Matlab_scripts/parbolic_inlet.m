clear;clc;clf;
x = 0:0.01:10;
t = ((sin(x))+1.2)/2;
%==============================================================================================
data1 = dlmread('Vin');
input = dlmread('Vin');
center =[mean(data1(:,1)),mean(data1(:,2)), mean(data1(:,3))];
R = zeros(size(data1,1),1);
for i = 1:size(data1,1)
    R(i) = sqrt((data1(i,1)-center(1))^2 + (data1(i,2)-center(2))^2 + (data1(i,3)-center(3))^2);
end

Rmax = max(R);
Vmag = 1-(R/Rmax).^2;

B = randi(size(data1,1));
display(B);
centerB = [(data1(B,1)-center(1)),(data1(B,2)-center(2)),(data1(B,3)-center(3))];

data1(B, :) = [];
C = randi(size(data1,1));
display(C);
centerC = [(data1(C,1)-center(1)),(data1(C,2)-center(2)),(data1(C,3)-center(3))];

normal = cross(centerB,centerC);
Unitnormal = normal/norm(normal);

InletVelocity = Vmag.*Unitnormal;
csvwrite('inletVelocity',InletVelocity);

