%���˻���ʵ�ֺ����Ż��ķ����Բ���ʽԼ������(cdj_g)
function [g,ceq]=cdj_g1(x);
syms x1 x2
qb=1;
jj=5;
gamn=45*pi/180;
g1=x1^2+x2^2-(jj-qb)^2-2*x1*x2*cos(gamn);   % ��С������Լ������
g2=-x1^2-x2^2+(jj+qb)^2-2*x1*x2*cos(gamn);  % ��󴫶���Լ������
ceq=[];%�����Ե�ʽԼ��Ϊ��