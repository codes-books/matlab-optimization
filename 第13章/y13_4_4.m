function DrawAckley()
    %����Ackley����ͼ��??
    x=[-8:0.1:8];
    y=x;
    [X,Y]=meshgrid(x,y);
    [row,col]=size(X);
    for l=1:col
        for h=1:row
            z(h,l)=Ackley([X(h,l),Y(h,l)]);
        end
    end
    mesh(X,Y,z);
    shading interp
end

function y=Ackley(x)
%Ackley?����??
%����x,������Ӧ��yֵ,��x=(0,0,��,0)?����ȫ�ּ�С��0,Ϊ�õ����ֵ������ֵȡ�෴��??
[row,col]=size(x);
if row>1
    error('����Ĳ�������');
end
y=-20*exp(-0.2*sqrt((1/col)*(sum(x.^2))))-exp((1/col)*sum(cos(2*pi.*x)))+exp(1)+20;
end