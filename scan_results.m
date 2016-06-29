clear;
A=dlmread('mlx30393_zcal.log');
fld_a=0;
fld=[];
k=0;
p=25;
offset=6;
a=350;
for i=1:34
    fld=[fld mean(A(a:a+p,4))];
    a=a+p+offset;
    if i==26
        a=a+5;
    end
end
B=[-40:5:40 40:-5:-40];
B=-B;
fld=fld*0.294*0.01;
tip=fittype('a*x+b');
[f1,f2,f3]=fit(B',fld',tip);
plot(f1,B,fld, 'bo');