% �Ľ��Ŀ�������Ⱥ�Ż��㷨 (APSO):
function apso

Lb=[0.1 0.1  0.1  0.1]; %�±߽�
Ub=[2.0 10.0 10.0 2.0]; %�ϱ߽�
% Ĭ�ϲ���
para=[25 150 0.95]; %[������������������gama����]

% APSO �Ż���⺯��
[gbest,fmin]=pso_mincon(@cost,@constraint,Lb,Ub,para);

% ������
Bestsolution=gbest % ȫ�����Ÿ���
fmin

%% Ŀ�꺯��
function f=cost(x)
f=1.10471*x(1)^2*x(2)+0.04811*x(3)*x(4)*(14.0+x(2));

% ������Լ��
function [g,geq]=constraint(x)
% ����ʽ��������
Q=6000*(14+x(2)/2);
D=sqrt(x(2)^2/4+(x(1)+x(3))^2/4);
J=2*(x(1)*x(2)*sqrt(2)*(x(2)^2/12+(x(1)+x(3))^2/4));
alpha=6000/(sqrt(2)*x(1)*x(2));
beta=Q*D/J;
tau=sqrt(alpha^2+2*alpha*beta*x(2)/(2*D)+beta^2);
sigma=504000/(x(4)*x(3)^2);
delta=65856000/(30*10^6*x(4)*x(3)^3);
F=4.013*(30*10^6)/196*sqrt(x(3)^2*x(4)^6/36)*(1-x(3)*sqrt(30/48)/28);

g(1)=tau-13600;
g(2)=sigma-30000;
g(3)=x(1)-x(4);
g(4)=0.10471*x(1)^2+0.04811*x(3)*x(4)*(14+x(2))-5.0;
g(5)=0.125-x(1);
g(6)=delta-0.25;
g(7)=6000-F;
% ���û�е�ʽԼ��������geq=[]��
geq=[];

%%  APSO Solver
function [gbest,fbest]=pso_mincon(fhandle,fnonlin,Lb,Ub,para)
if nargin<=4,
    para=[20 150 0.95];
end
n=para(1);% ������Ⱥ��С
time=para(2); %ʱ�䲽������������
gamma=para(3); %gama����
 scale=abs(Ub-Lb); %ȡֵ����
% ��֤Լ�������Ƿ�Ϻ�����
if abs(length(Lb)-length(Ub))>0,
    disp('Constraints must have equal size');
    return
end

  alpha=0.2; % alpha=[0,1]�������˥������
  beta=0.5;  % �����ٶ�(0->1)=(slow->fast);

% ��ʼ������Ⱥ
best=init_pso(n,Lb,Ub);

fbest=1.0e+100;
% ������ʼ
for t=1:time,     
   
%Ѱ��ȫ�����Ÿ���
  for i=1:n,   
    fval=Fun(fhandle,fnonlin,best(i,:)); 
    % �������и���
    if fval<=fbest, 
        gbest=best(i,:);
        fbest=fval;
    end
        
  end

% �����˥������
 alpha=newPara(alpha,gamma);

% ��������λ�� 
  best=pso_move(best,gbest,alpha,beta,Lb,Ub);  
 
% �����ʾ
	str=strcat('Best estimates: gbest=',num2str(gbest));
	str=strcat(str,'  iteration='); str=strcat(str,num2str(t));
	disp(str);

    fitness1(t)=fbest;
    plot(fitness1,'r','Linewidth',2)
    grid on
    hold on
    title('��Ӧ��')
end

% ��ʼ�����Ӻ���
function [guess]=init_pso(n,Lb,Ub)
ndim=length(Lb);
for i=1:n,
    guess(i,1:ndim)=Lb+rand(1,ndim).*(Ub-Lb); 
end

%�������е����� toward (xo,yo)
function ns=pso_move(best,gbest,alpha,beta,Lb,Ub)
% �������������±߽������ڵ������
n=size(best,1); ndim=size(best,2);
scale=(Ub-Lb);
for i=1:n,
    ns(i,:)=best(i,:)+beta*(gbest-best(i,:))+alpha.*randn(1,ndim).*scale;
end
ns=findrange(ns,Lb,Ub);

% �߽纯��
function ns=findrange(ns,Lb,Ub)
n=length(ns);
for i=1:n,
  % �±߽�Լ��
  ns_tmp=ns(i,:);
  I=ns_tmp<Lb;
  ns_tmp(I)=Lb(I);
  
  % �ϱ߽�Լ�� 
  J=ns_tmp>Ub;
  ns_tmp(J)=Ub(J);
  
  %��������
  ns(i,:)=ns_tmp; 
end

% �����˥������
function alpha=newPara(alpha,gamma);
alpha=alpha*gamma;

% ��Լ����dάĿ�꺯�������
function z=Fun(fhandle,fnonlin,u)
% Ŀ��
z=fhandle(u);

z=z+getconstraints(fnonlin,u); % ������Լ��

function Z=getconstraints(fnonlin,u)
% ������ >> 1
PEN=10^15;
lam=PEN; lameq=PEN;

Z=0;
% ������Լ��
[g,geq]=fnonlin(u);

%ͨ������ʽԼ������������
for k=1:length(g),
    Z=Z+ lam*g(k)^2*getH(g(k));
end
% ��ʽ����Լ��
for k=1:length(geq),
   Z=Z+lameq*geq(k)^2*geteqH(geq(k));
end

% Test if inequalities 
function H=getH(g)
if g<=0, 
    H=0; 
else
    H=1; 
end

% Test if equalities hold
function H=geteqH(g)
if g==0,
    H=0;
else
    H=1; 
end
