%% draw surf1
clc,clear,close all
%下载输入输出数据
load data.mat; %原始数据以列向量的方式存放在workplace文件中
n=size(data);
datax1=data(:,1);%作为 Ultrasonic power(W) 输入
datax2=data(:,2);%作为 Ultrasonic temperature(oC) 输入
datax3=data(:,3);%作为 Ultrasonic time(min) 输入
datay=data(:,4);%作为 anti-glycated activity(%) 目标向量

datax11=150:2:400;%作为 Ultrasonic power(W) 输入
datax22=20:2:80;%作为 Ultrasonic temperature(oC) 输入
[datax111,datax222]=meshgrid(datax11,datax22);
datay1=griddata(datax1,datax2,datay,datax111,datax222,'v4');% 'v4'MATLAB 4 格点样条函数内插
surf(datax11,datax22,datay1);
xlabel('Ultrasonic power(W)');
ylabel('Ultrasonic temperature(oC)');
zlabel('anti-glycated activity(%)');
grid on
axis tight
%% draw surf2
clc,clear,close all
%下载输入输出数据
load data.mat; %原始数据以列向量的方式存放在workplace文件中
n=size(data);
datax1=data(:,1);%作为 Ultrasonic power(W) 输入
datax2=data(:,2);%作为 Ultrasonic temperature(oC) 输入
datax3=data(:,3);%作为 Ultrasonic time(min) 输入
datay=data(:,4);%作为 anti-glycated activity(%) 目标向量

datax11=150:2:400;%作为 Ultrasonic power(W) 输入
datax33=5:2:35;%作为 Ultrasonic time(min) 输入
[datax111,datax333]=meshgrid(datax11,datax33);
datay2=griddata(datax1,datax3,datay,datax111,datax333,'v4');% 'v4'MATLAB 4 格点样条函数内插
surf(datax11,datax33,datay2);
xlabel('Ultrasonic power(W)');
ylabel('Ultrasonic time(min)');
zlabel('anti-glycated activity(%)');
grid on
axis tight
%% draw surf3
clc,clear,close all
%下载输入输出数据
load data.mat; %原始数据以列向量的方式存放在workplace文件中
n=size(data);
datax1=data(:,1);%作为 Ultrasonic power(W) 输入
datax2=data(:,2);%作为 Ultrasonic temperature(oC) 输入
datax3=data(:,3);%作为 Ultrasonic time(min) 输入
datay=data(:,4);%作为 anti-glycated activity(%) 目标向量

datax22=20:2:80;%作为 Ultrasonic temperature(oC) 输入
datax33=5:2:35;%作为 Ultrasonic time(min)  输入
[datax222,datax333]=meshgrid(datax22,datax33);
datay3=griddata(datax3,datax2,datay,datax333,datax222,'v4');% 'v4'MATLAB 4 格点样条函数内插
surf(datax22,datax33,datay3);
xlabel('Ultrasonic time(min)');
ylabel('Ultrasonic temperature(oC)');
zlabel('anti-glycated activity(%)');
grid on
axis tight
