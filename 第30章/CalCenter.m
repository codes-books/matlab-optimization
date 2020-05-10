% m_center_i 聚类中心结构
% 函数功能，计算聚类中心m_center_i的特征值（本类所有样品的均值）及样本的个数
function [m_center_i]=CalCenter(m_center_i,m_pattern,patternNum)
% global Nwidth
Nwidth=7;
temp=zeros(Nwidth,Nwidth);%临时存储中心的特征值
a=0;%记录该元素的个数
for i=1:patternNum
    if(m_pattern(i).category==m_center_i.index)%累加中心所有样品
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