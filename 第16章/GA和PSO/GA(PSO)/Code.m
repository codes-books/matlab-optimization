function ret=Code(lenchrom,bound)
%�����������������Ⱦɫ�壬���������ʼ��һ����Ⱥ
% lenchrom   input : Ⱦɫ�峤��
% bound      input : ������ȡֵ��Χ
% ret        output: Ⱦɫ��ı���ֵ

flag=0;
while flag==0
    pick=rand(1,lenchrom);
    ret=bound(:,1)'+(bound(:,2)-bound(:,1))'.*pick; %���Բ�ֵ
    flag=test(lenchrom,bound,ret);             %����Ⱦɫ��Ŀ�����
end