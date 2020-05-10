clc % 清屏
clear all; % 删除workplace变量
close all; % 关掉显示图形窗口
format short
% Initial
M=800;
N=4;
L1=80;
L2=20;
a=0.3;
c=0.7;
v=50;
b=0.02;
beta=0.08;
m=[];
j=1;
t=zeros(1000,1000);
for i=1:N
       m(i,1)=(M/N+t(i,j));
       m(i,2)=(M/N+ t(i,j))*c;
       m(i,3)=(M/N+t(i,j))*c*b*(L1/N)/v;
       m(i,4)=((M/N+t(i,j))*c-m(i,3))*b*(L1/N)/v+t(i,2);
       m(i,5)=((M/N+t(i,j))*c-m(i,3)-m(i,4))*b*(L1/N)/v+t(i,3);
       m(i,6)= ((M/N+t(i,j))*c-m(i,3)-m(i,4)-m(i,5))*beta*L2/v+t(i,4);
       m(i,7)=(M/N+t(i,j))*c-m(i,3)-m(i,4)-m(i,5)-m(i,6)+t(i,2) +t(i,3) +t(i,4)+t(i,5);
       t(i+1,2)=m(i,3);
       t(i+1,3)=m(i,4);
       t(i+1,4)=m(i,5);
       t(i+1,5)=m(i,6);
       j=j+1;
end
m