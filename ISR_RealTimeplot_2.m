%clc;
%clear all;
close all;
delete(instrfindall);

%a=arduino('com12','leonardo');
a=[];
comport=serial('COM8', 'Baudrate', 9600); 
fopen(comport); 
x=int16.empty(1000,0);
y=int16.empty(100,0);
z=int16.empty(100,0);
t=0;
for g=1:50
    if(strcmp(fscanf(comport,'%s'),'BEGIN')==1)
        break;
    end
end
if (g==50)
    disp('Starting string not found');
    return;
end

while(1)
    t=t+1;
    if t~=1
        fscanf(comport,'%d');
    end
    status=fscanf(comport,'%d');
    %status=2;
    if(status==2)        
        z(t)=fscanf(comport,'%d');
        y(t)=fscanf(comport,'%d');
        x(t)=fscanf(comport,'%d');
    else 
        disp(['Error found!\n BYTE -> ' int2str(status)]);
        break;
    end
    drawnow;
    %plot(0.161*x,'b-')
    %hold on;
    %plot(y,'r--')
    %hold on;
    %plot(((0.161*cast(x,'double').^2+(0.322*cast(y,'double')).^2+(2.349*cast(z,'double')).^2)).^(0.5),'b-');
    %a=[a;t*0.05];
    clf;
    if(t<=200)
        plot((cast(z,'double')*0.294*0.01),'b-');
        hold on;
        grid on;
        plot((cast(y,'double')*0.161*0.01),'r-');
        plot((cast(x,'double')*0.161*0.01),'g-');
        xlabel('iter');
        ylabel('Oe');
        axis([0 200 -inf inf]);
    else
        plot((cast(z(t-200:t),'double')*0.294*0.01),'b-');
        hold on;
        grid on;
        plot((cast(y(t-200:t),'double')*0.161*0.01),'r-');
        plot((cast(x(t-200:t),'double')*0.161*0.01),'g-');
        xlabel('iter');
        ylabel('Oe');
        axis([0 200 -inf inf]);
    end
    pause(0.001);
    hold off;
end
legend('z','y','x');
fclose(comport);