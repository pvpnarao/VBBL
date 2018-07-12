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

mkdir('constant/boundaryData/IN');
for j = 1:size(x',1)
    mkdir('constant/boundaryData/IN/',num2str(x(j)));
    U = (Vmag.*t(j)).*Unitnormal;
    figure('Visible','Off');
    set(gca,'FontSize',20,'GridAlpha',1,'MinorGridAlpha', 1); %setting plot background
    set(gcf,'position',[100,100,1000,800]); %setting plot size
    plot3(input(:,1),input(:,2),Vmag.*t(j),'.r');
    xlim([min(input(:,1)) max(input(:,1))]);
    ylim([min(input(:,2)) max(input(:,2))]);
    zlim([0 1]);
    grid on;grid minor;
    xlabel('X','FontSize',24,'interpreter','LaTex');
    ylabel('Y','FontSize',24,'interpreter','LaTex');
    zlabel('Velocity in the normal direction',);
    top = ['Unsteady non-uniform inlet velocity at t = ',num2str(x(j)),'s'];
    title(top,'FontSize',24,'interpreter','LaTex');
    file = ['constant/boundaryData/IN/',num2str(x(j)),'/U'];
    csvwrite(file,U);
    pic_name = ['pics/t_',num2str(j,'%04d'),'.png'];
    print('-dpng',pic_name);
    
end
csvwrite('times',x');


figure;
plot(data1(:,1),data1(:,2),'.b');
hold on;
plot(center(1),center(2),'+r','MarkerSize',12);
set(gca,'FontSize',20,'GridAlpha',1,'MinorGridAlpha', 1); %setting plot background
set(gcf,'position',[100,100,1000,800]); %setting plot size
grid on;grid minor;
xlabel('x','FontSize',24,'interpreter','LaTex');
ylabel('y','FontSize',24,'interpreter','LaTex');
title('Inlet point distribution','FontSize',24,'interpreter','LaTex');

figure;
plot(x,t,'-or');
set(gca,'FontSize',20,'GridAlpha',1,'MinorGridAlpha', 1); %setting plot background
set(gcf,'position',[100,100,1000,800]); %setting plot size
grid on;grid minor;
xlabel('time [s]','FontSize',24,'interpreter','LaTex');
ylabel('Multiplying factor','FontSize',24,'interpreter','LaTex');
ylim([0 1.2]);



