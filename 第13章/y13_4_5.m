function DrawRosenbrock()  
    %����Rosenbrock����ͼ��,����������������  
    x=[-8:0.1:8];  
    y=x;  
    [X,Y]=meshgrid(x,y);  
    [row,col]=size(X);  
    for l=1:col  
        for h=1:row  
            z(h,l)=Rosenbrock([X(h,l),Y(h,l)]);  
        end  
    end  
    mesh(X,Y,z);  
    shading interp
end

function y=Rosenbrock(x)  
    %Rosenbrock ����  
    %����x,������Ӧ��yֵ,��x=(1,1,��,1) ����ȫ�ּ�С��0,Ϊ�õ����ֵ������ֵȡ�෴��  
    %�����ˣ�  
    %�������ڣ�  
    [row,col]=size(x);  
    if row>1  
        error('����Ĳ�������');  
    end  
    y=100*(x(1,2)-x(1,1)^2)^2+(x(1,1)-1)^2;
    y=-y;
end