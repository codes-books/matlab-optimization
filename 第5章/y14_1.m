clc % ����
clear all; % ɾ��workplace����
close all; % �ص���ʾͼ�δ���
format short
pz=[191	36	50	5	162	60
189	37	52	2	110	60
193	38	58	12	101	101
162	35	62	12	105	37
189	35	46	13	155	58
182	36	56	4	101	42
211	38	56	8	101	38
167	34	60	6	125	40
176	31	74	15	200	40
154	33	56	17	251	250
169	34	50	17	120	38
166	33	52	13	210	115
154	34	64	14	215	105
247	46	50	1	50	50
193	36	46	6	70	31
202	37	62	12	210	120
176	37	54	4	60	25
157	32	52	11	230	80
156	33	54	15	225	73
138	33	68	2	110	43];

mu=mean(pz); %���ֵ
sig=std(pz); %���׼��
rr=corrcoef(pz); %�����ϵ������
data=zscore(pz); %���ݱ�׼��
n=3; % n ���Ա����ĸ���
m=3; % m ��������ĸ���
x0=pz(:,1:n);y0=pz(:,n+1:end);
e0=data(:,1:n);f0=data(:,n+1:end);
num=size(e0,1);%��������ĸ���
chg=eye(n); % w �� w* �任����ĳ�ʼ��
for i=1:n
    %���� w��w* ��t �ĵ÷�������
    matrix=e0'*f0*f0'*e0;
    [vec,val]=eig(matrix); %������ֵ����������
    val=diag(val); %����Խ���Ԫ��
    [val,ind]=sort(val,'descend');%��������
    w(:,i)=vec(:,ind(1)); %����������ֵ��Ӧ����������
    w_star(:,i)=chg*w(:,i); %����w*��ȡֵ
    t(:,i)=e0*w(:,i); %����ɷ�ti �ĵ÷�
    alpha=e0'*t(:,i)/(t(:,i)'*t(:,i)); %����alpha_i
    chg=chg*(eye(n)-w(:,i)*alpha'); %����w ��w*�ı任����
    e=e0-t(:,i)*alpha'; %����в����
    e0=e;
    %����ss(i)��ֵ
    beta=[t(:,1:i),ones(num,1)]\f0; %��ع鷽�̵�ϵ��
    beta(end,:)=[]; %ɾ���ع�����ĳ�����
    cancha=f0-t(:,1:i)*beta; %��в����
    ss(i)=sum(sum(cancha.^2)); %�����ƽ����
    %����p(i)
    for j=1:num
        t1=t(:,1:i);f1=f0;
        she_t=t1(j,:);she_f=f1(j,:); %����ȥ�ĵ�j �������㱣������
        t1(j,:)=[];f1(j,:)=[]; %ɾ����j ���۲�ֵ
        beta1=[t1,ones(num-1,1)]\f1; %��ع������ϵ��
        beta1(end,:)=[]; %ɾ���ع�����ĳ�����
        cancha=she_f-she_t*beta1; %��в�����
        p_i(j)=sum(cancha.^2);
    end
    p(i)=sum(p_i);
    if i>1
        Q_h2(i)=1-p(i)/ss(i-1);
    else
        Q_h2(1)=1;
    end
    if Q_h2(i)<0.0975
        fprintf('����ĳɷָ���r=%d',i);
        r=i;
        break
    end
end
beta_z=[t(:,1:r),ones(num,1)]\f0; %��Y ����t �Ļع�ϵ��
beta_z(end,:)=[]; %ɾ��������
xishu=w_star(:,1:r)*beta_z; %��Y ����X �Ļع�ϵ����������Ա�׼���ݵĻع�ϵ����ÿһ����һ���ع鷽��
mu_x=mu(1:n);mu_y=mu(n+1:end);
sig_x=sig(1:n);sig_y=sig(n+1:end);
for i=1:m
    ch0(i)=mu_y(i)-mu_x./sig_x*sig_y(i)*xishu(:,i); %����ԭʼ���ݵĻع鷽�̵ĳ�����
end
for i=1:m
    xish(:,i)=xishu(:,i)./sig_x'*sig_y(i); %����ԭʼ���ݵĻع鷽�̵�ϵ����ÿһ����һ���ع鷽��
end
sol=[ch0;xish] %��ʾ�ع鷽�̵�ϵ����ÿһ����һ�����̣�ÿһ�еĵ�һ�����ǳ�����
save mydata x0 y0 num xishu ch0 xish
w1=w(:,1)
w2=w(:,2)
wx1=w_star(:,1)
wx2=w_star(:,2)
tx1=t(:,1)'
tx2=t(:,2)'
beta_z %�ع�ϵ��
















