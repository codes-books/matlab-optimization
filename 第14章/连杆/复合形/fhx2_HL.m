% 判断复合形中的坏点和好点
function [H,L]=fhx2_HL(f1,f2,f3)
f=[f1,f2,f3];
fmax=max(f);
switch fmax
    case f1;H=1;
    case f2;H=2;
    case f3;H=3;
end
fmin=min(f);
switch fmin
    case f1;L=1;
    case f2;L=2;
    case f3;L=3;
end
disp '   坏点  好点'
[H L]