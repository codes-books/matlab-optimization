% ���ȼ��ʸ��������ά�������
xx1=linspace(0,10,40);
xx2=linspace(0,10,40);
[x1,x2]=meshgrid(xx1,xx2);
% ��ѧģ��
%Ŀ�꺯��

%Լ������
qb=1;jj=5;
gamn=45*pi/180;
g1=x1^2+x2^2-(jj-qb)^2-2*x1*x2*cos(gamn);   % ��С������Լ��
g2=-x1^2-x2^2+(jj+qb)^2-2*x1*x2*cos(gamn);  % ��󴫶���Լ��
% ���ƽ��
figure(1);
h=contour(x1,x2,g1);
clabel(h);
h=contour(x1,x2,g2);
clabel(h);
axis equal                     % ��������Ķ����������
title('\bf ���ƽ��');
xlabel('��Ʊ��� \bf X1');
ylabel('��Ʊ��� \bf X2');







