clc,clear,close all
a=[1,1,1,4,1,1/2
   1,1,2,4,1,1/2
   1,1/2,1,5,3,1/2
   1/4,1/4,1/5,1,1/3,1/3
   1,1,1/3,3,1,1
   2,2,2,3,3,1];
[x,y]=eig(a);%求特征值
eigenvalue=diag(y);%提取y矩阵的对角值
lamda=eigenvalue(1);
ci1=(lamda-6)/5;
cr1=ci1/1.24;
w1=x(:,1)/sum(x(:,1)) %准则层权值
%% 准则层1
b1=[1,1/4,1/2;4,1,3;2,1/3,1];
[x,y]=eig(b1);
eigenvalue=diag(y);
lamda=eigenvalue(1);
ci21=(lamda-3)/2;
cr21=ci21/0.58;
w21=x(:,1)/sum(x(:,1))%研究课题
%% 准则层2
b2=[1  1/4   1/5;4   1   1/2;5   2    1];
[x,y]=eig(b2);
eigenvalue=diag(y);
lamda=eigenvalue(1);
ci22=(lamda-3)/2;
cr22=ci22/0.58;
w22=x(:,1)/sum(x(:,1))%发展前途
%% 准则层3
b3=[1    3  1/3;1/3   1    1/7;3   7    1];
[x,y]=eig(b3);
eigenvalue=diag(y);
lamda=eigenvalue(1);
ci23=(lamda-3)/2;
cr23=ci23/0.58;
w23=x(:,1)/sum(x(:,1))%待遇
%% 准则层4
b4=[1   1/3   5;3   1    7;1/5  1/7   1];
[x,y]=eig(b4);
eigenvalue=diag(y);
lamda=eigenvalue(1);
ci24=(lamda-3)/2;
cr24=ci24/0.58;
w24=x(:,1)/sum(x(:,1))%同事情况
%% 准则层5
b5=[1   1    7;1   1    7;1/7  1/7   1];
[x,y]=eig(b5);
eigenvalue=diag(y);
lamda=eigenvalue(2);
ci25=(lamda-3)/2;
cr25=ci25/0.58;
w25=x(:,2)/sum(x(:,2))%地理位置
%% 准则层6
b6=[1   7   9;1/7  1   1 ;1/9   1   1];
[x,y]=eig(b6);
eigenvalue=diag(y);
lamda=eigenvalue(1);
ci26=(lamda-3)/2;
cr26=ci26/0.58;
w26=x(:,1)/sum(x(:,1))%单位名气
%%
w_sum=[w21,w22,w23,w24,w25,w26]*w1
ci=[ci21,ci22,ci23,ci24,ci25,ci26];
cr=ci*w1/sum(0.58*w1) %总排序权值
