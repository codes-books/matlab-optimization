function F=fitness(x)
F=0;
for i=1:2
    F=F+x(i)^2-cos(18*x(i));
end

