% ���˻���ʵ�ֺ����Ż���Ŀ�꺯��(jfg_f)
function f=jfg_f(x);
s=30;qb=1;jj=5;fx=0;
fa0=acos(((qb+x(1))^2-x(2)^2+jj^2)/(2*(qb+x(1))*jj));     % ������ʼ��
pu0=acos(((qb+x(1))^2-x(2)^2-jj^2)/(2*x(2)*jj));          % ҡ�˳�ʼ��
for i=1:s
    fai=fa0+0.5*pi*i/s;
    pui=pu0+2*(fai-fa0)^2/(3*pi);
    ri=sqrt(qb^2+jj^2-2*qb*jj*cos(fai));
    alfi=acos((ri^2+x(2)^2-x(1)^2)/(2*ri*x(2)));
    bati=acos((ri^2+jj^2-qb^2)/(2*ri*jj));
    if fai>0 & fai<=pi
        psi=pi-alfi-bati;
    elseif  fai>pi & fai<=2*pi
        psi=pi-alfi+bati;
    end
    fx=fx+(pui-psi)^2;                            % �����ƽ�����֮��
end
f=fx;