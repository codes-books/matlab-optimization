function [result]=GetDistance(patttern1,pattern2,type)

result=0;
% global Nwidth;%ÔÚ±¾³ÌĞòÖĞÈ¡7,7*7¾ØÕó£»
Nwidth=7;

switch(type)
    case 1%Å·ÊÏ¾àÀë
        result=sum((patttern1.feature(:)-pattern2.feature(:)).^2);
        result=sqrt(result);
    case 2%¼Ğ½ÇÓàÏÒ
        a=0;
        b1=0;
        b2=0;
        for i=1:Nwidth
            for j=1:Nwidth
                a=a+patttern1.feature(i,j)*pattern2.feanture(i,j);
                b1=b1+patttern1.feature(i,j)*pattern1.feature(i,j);
                b2=b2+pattern2.feature(i,j)*pattern2.feature(i,j);
            end
        end
        if(b1*b2==0)
            result=1-a/sqrt(b1*b2);
        else
            result=-1;
        end
end
