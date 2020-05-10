function result=fitness2(x)
s=50;
qb=1;
jj=5;
fx=0;
fa0=acos(((qb+x(1))^2-x(2)^2+jj^2)/(2*(qb+x(1))*jj));     % Çú±ú³õÊ¼½Ç
pu0=acos(((qb+x(1))^2-x(2)^2-jj^2)/(2*x(2)*jj));          % Ò¡¸Ë³õÊ¼½Ç
for i=1:s
    fai=fa0+0.5*pi*i/s;        % Çú±úÊµ¼ÊÎ»ÖÃ½Ç                           
    pui=pu0+2*(fai-fa0)^2/(3*pi);  %Ò¡¸ËÆÚÍûÊä³ö½Ç
    ri=sqrt(qb^2+jj^2-2*qb*jj*cos(fai)); %¸¨ÖúÏßBD³¤¶È
    alfi=acos((ri^2+x(2)^2-x(1)^2)/(2*ri*x(2))); %L3ÓëriµÄ¼Ğ½Ç¦Ái
    bati=acos((ri^2+jj^2-qb^2)/(2*ri*jj));%riºÍL4µÄ¼Ğ½Ç¦Âi
    if fai>0 & fai<=pi
        ps=pi-alfi-bati;            
    elseif  fai>pi & fai<=2*pi
        ps=pi-alfi+bati;                %Ò¡¸ËÊµ¼ÊÊä³ö½Ç
    end
      fx=fx+(pui-ps)^2;             % Êä³ö½ÇÆ½·½Îó²îÖ®ºÍ
end
   f=fx;
result=f;