% �����η���άԼ���Ż��������ѧģ��
function [f,g1,g2]=fhx1_fg(x1,x2)
s=50;
qb=1;
jj=5;
fx=0;
g1=-x1^2-x2^2+(jj-qb)^2+2*x1*x2*cos(45*pi/180);  
g2=x1^2+x2^2+(jj+qb)^2-2*x1*x2*cos(45*pi/180);
fa0=acos(((qb+x1)^2-x2^2+jj^2)/(2*(qb+x1)*jj));     % ������ʼ��
pu0=acos(((qb+x1)^2-x2^2-jj^2)/(2*x2*jj));          % ҡ�˳�ʼ��
for i=1:s
    fai=fa0+0.5*pi*i/s;        % ����ʵ��λ�ý�                           
    pui=pu0+2*(fai-fa0)^2/(3*pi);  %ҡ�����������
    ri=sqrt(qb^2+jj^2-2*qb*jj*cos(fai)); %������BD����
    alfi=acos((ri^2+x2^2-x1^2)/(2*ri*x2)); %L3��ri�ļнǦ�i
    bati=acos((ri^2+jj^2-qb^2)/(2*ri*jj));%ri��L4�ļнǦ�i
    ps=pi-alfi-bati; 
     fx=fx+(pui-ps)^2;                  % �����ƽ�����֮��
end
f=fx;

