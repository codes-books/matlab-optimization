function result=violent1(x)
[g,ceq]=cdj_g(x);
part1=min(g(1));
part2=min(g(2));
result=part1+part2;