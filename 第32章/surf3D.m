%% draw surf1
clc,clear,close all
%���������������
load data.mat; %ԭʼ�������������ķ�ʽ�����workplace�ļ���
n=size(data);
datax1=data(:,1);%��Ϊ Ultrasonic power(W) ����
datax2=data(:,2);%��Ϊ Ultrasonic temperature(oC) ����
datax3=data(:,3);%��Ϊ Ultrasonic time(min) ����
datay=data(:,4);%��Ϊ anti-glycated activity(%) Ŀ������

datax11=150:2:400;%��Ϊ Ultrasonic power(W) ����
datax22=20:2:80;%��Ϊ Ultrasonic temperature(oC) ����
[datax111,datax222]=meshgrid(datax11,datax22);
datay1=griddata(datax1,datax2,datay,datax111,datax222,'v4');% 'v4'MATLAB 4 ������������ڲ�
surf(datax11,datax22,datay1);
xlabel('Ultrasonic power(W)');
ylabel('Ultrasonic temperature(oC)');
zlabel('anti-glycated activity(%)');
grid on
axis tight
%% draw surf2
clc,clear,close all
%���������������
load data.mat; %ԭʼ�������������ķ�ʽ�����workplace�ļ���
n=size(data);
datax1=data(:,1);%��Ϊ Ultrasonic power(W) ����
datax2=data(:,2);%��Ϊ Ultrasonic temperature(oC) ����
datax3=data(:,3);%��Ϊ Ultrasonic time(min) ����
datay=data(:,4);%��Ϊ anti-glycated activity(%) Ŀ������

datax11=150:2:400;%��Ϊ Ultrasonic power(W) ����
datax33=5:2:35;%��Ϊ Ultrasonic time(min) ����
[datax111,datax333]=meshgrid(datax11,datax33);
datay2=griddata(datax1,datax3,datay,datax111,datax333,'v4');% 'v4'MATLAB 4 ������������ڲ�
surf(datax11,datax33,datay2);
xlabel('Ultrasonic power(W)');
ylabel('Ultrasonic time(min)');
zlabel('anti-glycated activity(%)');
grid on
axis tight
%% draw surf3
clc,clear,close all
%���������������
load data.mat; %ԭʼ�������������ķ�ʽ�����workplace�ļ���
n=size(data);
datax1=data(:,1);%��Ϊ Ultrasonic power(W) ����
datax2=data(:,2);%��Ϊ Ultrasonic temperature(oC) ����
datax3=data(:,3);%��Ϊ Ultrasonic time(min) ����
datay=data(:,4);%��Ϊ anti-glycated activity(%) Ŀ������

datax22=20:2:80;%��Ϊ Ultrasonic temperature(oC) ����
datax33=5:2:35;%��Ϊ Ultrasonic time(min)  ����
[datax222,datax333]=meshgrid(datax22,datax33);
datay3=griddata(datax3,datax2,datay,datax333,datax222,'v4');% 'v4'MATLAB 4 ������������ڲ�
surf(datax22,datax33,datay3);
xlabel('Ultrasonic time(min)');
ylabel('Ultrasonic temperature(oC)');
zlabel('anti-glycated activity(%)');
grid on
axis tight
