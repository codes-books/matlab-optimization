function result=fitness2(x)
s=50;
qb=1;
jj=5;
fx=0;
fa0=acos(((qb+x(1))^2-x(2)^2+jj^2)/(2*(qb+x(1))*jj));     % ������ʼ��
pu0=acos(((qb+x(1))^2-x(2)^2-jj^2)/(2*x(2)*jj));          % ҡ�˳�ʼ��
for i=1:s
    fai=fa0+0.5*pi*i/s;        % ����ʵ��λ�ý�                           
    pui=pu0+2*(fai-fa0)^2/(3*pi);  %ҡ�����������
    ri=sqrt(qb^2+jj^2-2*qb*jj*cos(fai)); %������BD����
    alfi=acos((ri^2+x(2)^2-x(1)^2)/(2*ri*x(2))); %L3��ri�ļнǦ�i
    bati=acos((ri^2+jj^2-qb^2)/(2*ri*jj));%ri��L4�ļнǦ�i
    if fai>0 & fai<=pi
        ps=pi-alfi-bati;            
    elseif  fai>pi & fai<=2*pi
        ps=pi-alfi+bati;                %ҡ��ʵ�������
    end
      fx=fx+(pui-ps)^2;             % �����ƽ�����֮��
end
   f=fx;
result=f;