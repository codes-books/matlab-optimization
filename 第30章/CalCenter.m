% m_center_i �������Ľṹ
% �������ܣ������������m_center_i������ֵ������������Ʒ�ľ�ֵ���������ĸ���
function [m_center_i]=CalCenter(m_center_i,m_pattern,patternNum)
% global Nwidth
Nwidth=7;
temp=zeros(Nwidth,Nwidth);%��ʱ�洢���ĵ�����ֵ
a=0;%��¼��Ԫ�صĸ���
for i=1:patternNum
    if(m_pattern(i).category==m_center_i.index)%�ۼ�����������Ʒ
        a=a+1;
        temp=temp+m_pattern(i).feature;
    end
end

m_center_i.patternNum=a;

if(a~=0)
    m_center_i.feature=temp/a;
else
    m_center_i.feature=temp;
end