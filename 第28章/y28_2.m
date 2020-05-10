clc % 清屏
clear all; % 删除workplace变量
close all; % 关掉显示图形窗口
format long
% Initial
% parameters for the NN structure
h=4;
i=3;
j=3;
Alpha=0.1;
Beta=0.1;

Gamma=0.85;
Tor=0.0005;
Maxepoch=2000;
Accuracy=0;
Ntrain=115;
Ntest=35;
%assign random values in the range [-1, +1]
V=2*(rand(h,i)-0.5);
W=2*(rand(i,j)-0.5);
Pi=2*(rand(1,i)-0.5);
Tau=2*(rand(1,j)-0.5);
DeltaWOld(i,j)=0; %set the delat of Wij to 0
DeltaVOld(h,i)=0; %set the delat of Vij to 0
DeltaPiOld(i)=0; %set the delat of Pi to 0
DeltaTauOld(j)=0; %set the delat of Tau to 0
% the learning process
Epoch=1;
Error=10;
% load the training set data and test set data
load data.dat
Odesired=data(:,2); % get the desired of output of 150 data sets
% normalize the input data to rang [-1 +1]
datanew=data(:,3:6);
maxv=max(max(datanew));
minv=min(min(datanew));
datanorm=2*((datanew-minv)/(maxv-minv)-0.5);
while Error>Tor
    Err(Epoch)=0;
    for k=1:Ntrain % k = the index of tranning set
        a=datanorm(k,:); % get the input
        % set the desired output ck[j]
        if data(k,2)==0
            ck=[1 0 0];
        elseif data(k,2)==1
            ck=[0 1 0];
        else
            ck=[0 0 1];
        end;
        % calculate the hidden nodes activation
        for ki=1:i
            b(ki)=logsig(a*V(:,ki)+Pi(ki));
        end;
        % calculate the output nodes activation
        for kj=1:j
            c(kj)=logsig(b*W(:,kj)+Tau(kj));
        end;
        % calculate error in output Layer FC
        d=c.*(1-c).*(ck-c);
        % calculate error in hidden layer FB
        e=b.*(1-b).*(d*W');
        % adjust weights Wij between FB and FC
        for ki=1:i
            for kj=1:j
                DeltaW(ki,kj)=Alpha*b(ki)*d(kj)+Gamma*DeltaWOld(ki,kj);
            end
        end;
        W=W+DeltaW;
        DeltaWOld=DeltaW;
        % adjust weights Vij between FA and FB
        for kh=1:h
            for ki=1:i
                DeltaV(kh,ki)=Beta*a(kh)*e(ki);
            end
        end;
        V=V+DeltaV;
        DeltaVold=DeltaV;
        % adjust thresholds Pi and Tau
        DeltaPi=Beta*e+Gamma*DeltaPiOld;
        Pi=Pi+DeltaPi;
        DeltaPiold=DeltaPi;
        DeltaTau=Alpha*d+Gamma*DeltaTauOld;
        Tau=Tau+DeltaTau;
        DeltaTauold=DeltaTau;
        % the error is the max of d(1),d(2),d(3)
        Err(Epoch)=Err(Epoch)+0.5*(d(1)*d(1)+d(2)*d(2)+d(3)*d(3));
    end %for k=1:Ntrain
    Err(Epoch)=Err(Epoch)/Ntrain;
    Error=Err(Epoch);
    % the training stops when iterate is too much
    if Epoch > Maxepoch
        break;
    end
    Epoch = Epoch +1; % update the iterate number
end
% test data
for k=1:Ntest % k = the index of test set
    a=datanorm(Ntrain+k,:); % get the input of test sets
    % calculate the hidden nodes activation
    for ki=1:i
        b(ki)=logsig(a*V(:,ki)+Pi(ki));
    end;
    % calculate the output of test sets
    for kj=1:j
        c(kj)=logsig(b*W(:,kj)+Tau(kj));
    end;
    % transfer the output to one field format
    if (c(1)> 0.9)
        Otest(k)=0;
    elseif (c(2)> 0.9)
        Otest(k)=1;
    elseif (c(3)> 0.9)
        Otest(k)=2;
    else
        Otest(k)=3;
    end;
    % calculate the accuracy of test sets
    if Otest(k)==Odesired(Ntrain+k)
        Accuracy=Accuracy+1;
    end;
end; % k=1:Ntest
% plot the error
plot(Err);
% plot the NN output and desired output during test
N=1:Ntest;
figure; plot(N,Otest,'b-',N,Odesired(116:150),'r-');
% display the accuracy
Accuracy = 100*Accuracy/Ntest;
t=['正确率: ' num2str(Accuracy) '%' ];
disp(t);
