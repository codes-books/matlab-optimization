function ret=Select(individuals,fitness,sizepop)
% 本函数对每一代种群中的染色体进行选择，以进行后面的交叉和变异
% individuals input  : 种群信息
% fitness input  : 适应度
% sizepop     input  : 种群规模
% opts        input  : 选择方法的选择
% ret         output : 经过选择后的种群

fitness= 1./(fitness);
sumfitness=sum(fitness);
sumf=fitness./sumfitness;
index=[];
for i=1:sizepop   %转sizepop次轮盘
    pick=rand;
    while pick==0
        pick=rand;
    end
    for j=1:sizepop
        pick=pick-sumf(j);
        if pick<0
            index=[index j];
            break;  %寻找落入的区间，此次转轮盘选中了染色体i，注意：在转sizepop次轮盘的过程中，有可能会重复选择某些染色体
        end
    end
end
individuals=individuals(index,:);
fitness=fitness(index);
ret=individuals;