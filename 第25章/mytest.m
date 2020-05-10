% function mytest()
clc % 清屏
clear all; % 删除workplace变量
close all; % 关掉显示图形窗口

images=[ ];  
M_train=3;%表示人脸
N_train=5;%表示方向 
sample=[];  
pixel_value=[];
sample_number=0;

for j=1:N_train
      for i=1:M_train
        %读取图像，连接字符串形成图像的文件名。
        str=strcat('Images\',num2str(i),'_',num2str(j),'.bmp'); 
        img= imread(str);  
        [rows cols]= size(img);%获得图像的行和列值。
        img_edge=edge(img,'Sobel');

        %由于在分割图片中，人脸的眼睛部分位置变化比较大，边缘检测效果好
        sub_rows=floor(rows/6);%最接近的最小整数,分成6行
        sub_cols=floor(cols/8);%最接近的最小整数，分成8列
        sample_num=M_train*N_train;%前5个是第一幅人脸的5个角度

        sample_number=sample_number+1;
        for subblock_i=1:8 %因为这还在i，j的循环中，所以不可以用i 
            block_num=subblock_i;
            pixel_value(sample_number,block_num)=0;  
            for ii=sub_rows:(2*sub_rows)
                for jj=(subblock_i-1)*sub_cols+1:subblock_i*sub_cols
                    pixel_value(sample_number,block_num)=pixel_value(sample_number,block_num)+img_edge(ii,jj);          
                end
            end     
        end  
    end
end

%将特征值转换为小于1的值
max_pixel_value=max(pixel_value);
max_pixel_value_1=max(max_pixel_value); 
for i=1:3
    mid_value=10^i;
    if(((max_pixel_value_1/mid_value)>1)&&((max_pixel_value_1/mid_value)<10))
        multiple_num=1/mid_value; 
        pixel_value=pixel_value*multiple_num; 
        break;
    end
end

% T 为目标矢量 
t=zeros(3,sample_number);
%因为有五类，所以至少用3个数表示，5介于2的2次方和2的3次方之间
for i=1:sample_number
    % if((mod(i,5)==1)||(mod(i,5)==4)||(mod(i,5)==0))
    if(i<=3)||((i>9)&&(i<=12))||((i>12)&&(i<=15))
        t(1,i)=1;
    end    
    %if((mod(i,5)==2)||(mod(i,5)==4)) 
    if((i>3)&&(i<=6))||((i>9)&&(i<=12))
        t(2,i)=1;
    end        
    %if((mod(i,5)==3)||(mod(i,5)==0)) 
    if((i>6)&&(i<=9))||((i>12)&&(i<=15))
        t(3,i)=1;
    end           
end  

% NEWFF——生成一个新的前向神经网络 
% TRAIN——对 BP 神经网络进行训练 
% SIM——对 BP 神经网络进行仿真 

%  定义训练样本 
% P 为输入矢量 
P=pixel_value'
% T 为目标矢量 
T=t
size(P)
size(T)
% size(P)
% size(T)

%  创建一个新的前向神经网络  
net_1=newff(minmax(P),[10,3],{'tansig','purelin'},'traingdm')
%  当前输入层权值和阈值 
inputWeights=net_1.IW{1,1} 
inputbias=net_1.b{1} 
%  当前网络层权值和阈值 
layerWeights=net_1.LW{2,1} 
layerbias=net_1.b{2} 
%  设置训练参数
net_1.trainParam.show = 50; 
net_1.trainParam.lr = 0.05; 
net_1.trainParam.mc = 0.9; 
net_1.trainParam.epochs = 10000; 
net_1.trainParam.goal = 1e-3; 
%  调用 TRAINGDM 算法训练 BP 网络
[net_1,tr]=train(net_1,P,T); 
%  对 BP 网络进行仿真
A = sim(net_1,P); 
%  计算仿真误差  
E = T - A; 
MSE=mse(E) 

x=[0.14 0 1 1 0 1 1 1.2]';
sim(net_1,x)



