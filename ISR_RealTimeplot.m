%clc;
%clear all;
close all;
%a=arduino('com12','leonardo');
comport=serial('COM12', 'Baudrate', 115200); 
fopen(comport); 

t=0;
while(t<100)
    t=t+1;
    x(t)=fscanf(comport,'%d');
    %y(t)=fscanf(comport,'%d');
    %z(t)=fscanf(comport,'%d');
    drawnow;
    plot(x,'b--')
    %grid on;
    %hold on;
    %plot(y,'r--')
    %hold on;
    %plot(z,'g--')
    pause(0.1);
    
end
fclose(comport);