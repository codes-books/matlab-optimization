% ���亯��
clc % ����
clear all; % ɾ��workplace����
close all; % �ص���ʾͼ�δ���
x1=-0.5:0.01:0.5; 
x2=-0.5:0.01:0.5;
for i=1:101
    for j=1:101
        % object function
        z(i,j)=-20*exp(-0.2*sqrt((x1(i)^2+x2(j)^2)/2))-exp((cos(2*pi*x1(i))+cos(2*pi*x2(j)))/2)+20+2.71289;
    end
end
[x,y]=meshgrid(x1,x2);%����
mesh(x,y,z) %��ͼ
% surf(x,y,z)