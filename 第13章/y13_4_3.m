function DrawSchaffer()
    x=[-5:0.05:5];
    y=x;
    [X,Y]=meshgrid(x,y);
    [row,col]=size(X);
    for l=1:col
    for h=1:row
    z(h,l)=Schaffer([X(h,l),Y(h,l)]);
    end
    end
    mesh(X,Y,z);
    shading interp
end


function result=Schaffer(x1)
    %Schaffer?����??
    %����x,������Ӧ��yֵ,��x=(0,0,��,0)?����ȫ�ּ����1.????
    [row,col]=size(x1);
    if row>1
        error('����Ĳ�������');
    end
    x=x1(1,1);
    y=x1(1,2);
    temp=x^2+y^2;
    result=0.5-(sin(sqrt(temp))^2-0.5)/(1+0.001*temp)^2;
end
