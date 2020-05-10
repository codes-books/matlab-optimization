% �ͷ�����--��㷨
% ��ѧģ��
syms x x1 x2
qb=1;
jj=5;
gamn=45*pi/180;
r0 = 0.25;c =2; km = 7;
k = 1:km;              % ��������
r=r0*c.^(k-1);         % �ͷ����ӵ�������
x1=4.2-2./(2.*r);
x2=2.4-2./(2.*r);
f=jfg_f1(x);
g1=x1.^2+x2.^2-(jj-qb)^2-2.*x1.*x2.*cos(gamn);   % ��С������Լ������
g2=-x1.^2-x2.^2+(jj+qb)^2-2.*x1.*x2.*cos(gamn);  % ��󴫶���Լ������     
p=f+r.*g1.^2+r.*g2.^2;           % �ͷ�����p
disp '                 ******    ������    ******'
disp '  �������� k'
[k]
disp '  �ͷ����� r'
[r]
disp '  ���ŵ����� x1*'
[x1]
disp '  ���ŵ����� x2*'
[x2]
disp   ' Ŀ�꺯�� f*'
[f]
disp   '  �ͷ����� p*'
[p]    
plot(r,f)
xlabel ('r')
ylabel ('f')
hold on
plot(r,p)
xlabel ('r')
ylabel ('p')