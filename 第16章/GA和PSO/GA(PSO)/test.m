function flag=test(lenchrom,bound,code)
% lenchrom   input : Ⱦɫ�峤��
% bound      input : ������ȡֵ��Χ
% code       output: Ⱦɫ��ı���ֵ

flag=1;
[n,m]=size(code);

for i=1:n
    if code(i)<bound(i,1) || code(i)>bound(i,2)
        flag=0;
    end
end