a=860.3;
b=3.69;
A_lin=-0.162;% E=620
B_lin=-0.21; % E=620

A_MR=-5.25874e-02;
B_MR=-4.27718e-01; 

%Suposto
%A=4.61800e-02;
%B=-6.38300e-01;
%C=0.98;

C=3.78;  %posição inicial
f=0:0.1:3.5;

d=double(100);


%Linear model
Campo_lin =a./(A_lin*f.^2+B_lin*f+C).^3+b;

%Hyperelastic Moonley Rivlin Model
Campo_MR =a./(A_MR*f.^2+B_MR*f+C).^3+b;



plot(f,Campo_lin)
xlabel('Force [N]');
ylabel('Field [Oe]');
hold on, 
plot(f,Campo_MR)
hold on
plot(force,field,'r')
legend('linear model','hyperelastic model','experimental','Location','northwest')
title('Sensor response')
axis([0 4 0 500])


