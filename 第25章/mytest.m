% function mytest()
clc % ����
clear all; % ɾ��workplace����
close all; % �ص���ʾͼ�δ���

images=[ ];  
M_train=3;%��ʾ����
N_train=5;%��ʾ���� 
sample=[];  
pixel_value=[];
sample_number=0;

for j=1:N_train
      for i=1:M_train
        %��ȡͼ�������ַ����γ�ͼ����ļ�����
        str=strcat('Images\',num2str(i),'_',num2str(j),'.bmp'); 
        img= imread(str);  
        [rows cols]= size(img);%���ͼ����к���ֵ��
        img_edge=edge(img,'Sobel');

        %�����ڷָ�ͼƬ�У��������۾�����λ�ñ仯�Ƚϴ󣬱�Ե���Ч����
        sub_rows=floor(rows/6);%��ӽ�����С����,�ֳ�6��
        sub_cols=floor(cols/8);%��ӽ�����С�������ֳ�8��
        sample_num=M_train*N_train;%ǰ5���ǵ�һ��������5���Ƕ�

        sample_number=sample_number+1;
        for subblock_i=1:8 %��Ϊ�⻹��i��j��ѭ���У����Բ�������i 
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

%������ֵת��ΪС��1��ֵ
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

% T ΪĿ��ʸ�� 
t=zeros(3,sample_number);
%��Ϊ�����࣬����������3������ʾ��5����2��2�η���2��3�η�֮��
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

% NEWFF��������һ���µ�ǰ�������� 
% TRAIN������ BP ���������ѵ�� 
% SIM������ BP ��������з��� 

%  ����ѵ������ 
% P Ϊ����ʸ�� 
P=pixel_value'
% T ΪĿ��ʸ�� 
T=t
size(P)
size(T)
% size(P)
% size(T)

%  ����һ���µ�ǰ��������  
net_1=newff(minmax(P),[10,3],{'tansig','purelin'},'traingdm')
%  ��ǰ�����Ȩֵ����ֵ 
inputWeights=net_1.IW{1,1} 
inputbias=net_1.b{1} 
%  ��ǰ�����Ȩֵ����ֵ 
layerWeights=net_1.LW{2,1} 
layerbias=net_1.b{2} 
%  ����ѵ������
net_1.trainParam.show = 50; 
net_1.trainParam.lr = 0.05; 
net_1.trainParam.mc = 0.9; 
net_1.trainParam.epochs = 10000; 
net_1.trainParam.goal = 1e-3; 
%  ���� TRAINGDM �㷨ѵ�� BP ����
[net_1,tr]=train(net_1,P,T); 
%  �� BP ������з���
A = sim(net_1,P); 
%  ����������  
E = T - A; 
MSE=mse(E) 

x=[0.14 0 1 1 0 1 1 1.2]';
sim(net_1,x)



