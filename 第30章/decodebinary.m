%���� [2^n 2^(n-1) ... 1] ����������Ȼ����ͣ���������ת��Ϊʮ����
function pop3=decodebinary(pop)
global length N;
[px,py]=size(pop); %��pop�к�����
for i=1:py
    pop1(:,i)=2.^(py-1).*pop(:,i); %pop��ÿһ���������������Ʊ�ʾ����forѭ����佫ÿ����������������λ��
    py=py-1;                       % ����Ȩ��      
end                               
pop2=sum(pop1,2);              %��pop1��ÿ��֮�ͣ����õ�ÿ�ж����Ʊ�ʾ��Ϊʮ���Ʊ�ʾֵ��ʵ�ֶ����Ƶ�ʮ���Ƶ�ת��
pop3=max(pop2)/N/length;