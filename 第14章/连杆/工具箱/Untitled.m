% ���ȼ��ʸ��������ά�������
xx1=linspace(0,10,40);
xx2=linspace(0,10,40);
[x1,x2]=meshgrid(xx1,xx2);
% ��ѧģ��
%Ŀ�꺯��
f=0.02.*x1.*sqrt(x2);
% Ŀ�꺯��ֵ��������
fh=contour(x1,x2,f);                             % Ŀ�꺯���ȸ���
clabel(fh);                                      % ��עĿ�꺯��ֵ
title('\bf �Ż����ƽ��');
xlabel('x1 ');
ylabel('x2 ');
%Լ������
qb=1;jj=5;
gamn=45*pi/180;
g1=x1^2+x2^2-(jj-qb)^2-2*x1*x2*cos(gamn);   % ��С������Լ��
g2=-x1^2-x2^2+(jj+qb)^2-2*x1*x2*cos(gamn);  % ��󴫶���Լ��
% Լ��������������
hold on;
g1h=contour(x1,x2,g1);
g2h=contour(x1,x2,g2);
