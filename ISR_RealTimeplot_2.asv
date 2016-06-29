%clc;
%clear all;
close all;
delete(instrfindall);
letra='A';

%a=arduino('com12','leonardo');
a=[];
comport=serial('COM8', 'Baudrate', 9600); 
fopen(comport); 
x=int16.empty(1000,4,0);
y=int16.empty(1000,4,0);
z=int16.empty(1000,4,0);
t=0;
for g=1:50
    if(strcmp(fscanf(comport,'%s'),'F')==1)
        fscanf(comport,'%d');
        fscanf(comport,'%d');
        fscanf(comport,'%d');
        fscanf(comport,'%d');
        break;
    end
end
if (g==50)
    disp('Starting string not found');
    return;
end
t=1;
d=0;
while(t<=100)
    t0=tic;
    letra=fscanf(comport,'%s');
    d=d+1;
   % while(strcmp(letra,'C')==1||strcmp(letra,'D')==1||strcmp(letra,'E')==1||strcmp(letra,'F')==1);        
        switch letra
            case 'C'
                status=fscanf(comport,'%d');
                %status=2;
                if(status==2)
                    z(t,1,1)=fscanf(comport,'%d');
                    y(t,1,1)=fscanf(comport,'%d');
                    x(t,1,1)=fscanf(comport,'%d');
                else
                    disp(['Error found!\n BYTE -> ' int2str(status)]);
                    break;
                end
            case 'D'
                status=fscanf(comport,'%d');
                %status=2;
                if(status==2)
                    z(t,2,1)=fscanf(comport,'%d');
                    y(t,2,1)=fscanf(comport,'%d');
                    x(t,2,1)=fscanf(comport,'%d');
                else
                    disp(['Error found!\n BYTE -> ' int2str(status)]);
                    break;
                end
            case 'E'
                status=fscanf(comport,'%d');
                %status=2;
                if(status==2)
                    z(t,3,1)=fscanf(comport,'%d');
                    y(t,3,1)=fscanf(comport,'%d');
                    x(t,3,1)=fscanf(comport,'%d');
                else
                    disp(['Error found!\n BYTE -> ' int2str(status)]);
                    break;
                end
            case 'F'
                status=fscanf(comport,'%d');
                %status=2;
                if(status==2)
                    z(t,4,1)=fscanf(comport,'%d');
                    y(t,4,1)=fscanf(comport,'%d');
                    x(t,4,1)=fscanf(comport,'%d');
                else
                    disp(['Error found!\n BYTE -> ' int2str(status)]);
                    break;
                end
        end
        

    t1=toc(t0);
    t2=tic;
    %end

    %plot(0.161*x,'b-')
    %hold on;
    %plot(y,'r--')
    %hold on;
    %plot(((0.161*cast(x,'double').^2+(0.322*cast(y,'double')).^2+(2.349*cast(z,'double')).^2)).^(0.5),'b-');
    %a=[a;t*0.05];
    %clf;
    switch d
        case 1
            if(t<=200)
                subplot(2,2,1);
                plot((cast(z(1:t-1,1,1),'double')*0.294*0.01),'b-');
                hold on;
                grid on;
                plot((cast(y(1:t-1,1,1),'double')*0.161*0.01),'r-');
                plot((cast(x(1:t-1,1,1),'double')*0.161*0.01),'g-');
                xlabel('iter');
                ylabel('Oe');
                axis([0 200 -inf inf]);
            else
                subplot(2,2,1);
                plot((cast(z(t-200:t,1,1),'double')*0.294*0.01),'b-');
                hold on;
                grid on;
                plot((cast(y(t-200:t,1,1),'double')*0.161*0.01),'r-');
                plot((cast(x(t-200:t,1,1),'double')*0.161*0.01),'g-');
                xlabel('iter');
                ylabel('Oe');
                axis([0 200 -inf inf]);
            end
            pause(0.001);
            hold off;
        case 2
            if(t<=200)
                subplot(2,2,2);
                plot((cast(z(1:t-1,2,1),'double')*0.294*0.01),'b-');
                hold on;
                grid on;
                plot((cast(y(1:t-1,2,1),'double')*0.161*0.01),'r-');
                plot((cast(x(1:t-1,2,1),'double')*0.161*0.01),'g-');
                xlabel('iter');
                ylabel('Oe');
                axis([0 200 -inf inf]);
            else
                subplot(2,2,2);
                plot((cast(z(t-200:t,2,1),'double')*0.294*0.01),'b-');
                hold on;
                grid on;
                plot((cast(y(t-200:t,2,1),'double')*0.161*0.01),'r-');
                plot((cast(x(t-200:t,2,1),'double')*0.161*0.01),'g-');
                xlabel('iter');
                ylabel('Oe');
                axis([0 200 -inf inf]);
            end
            pause(0.001);
            hold off;
        case 3
            if(t<=200)
                subplot(2,2,3);
                plot((cast(z(1:t-1,3,1),'double')*0.294*0.01),'b-');
                hold on;
                grid on;
                plot((cast(y(1:t-1,3,1),'double')*0.161*0.01),'r-');
                plot((cast(x(1:t-1,3,1),'double')*0.161*0.01),'g-');
                xlabel('iter');
                ylabel('Oe');
                axis([0 200 -inf inf]);
            else
                subplot(2,2,3);
                plot((cast(z(t-200:t,3,1),'double')*0.294*0.01),'b-');
                hold on;
                grid on;
                plot((cast(y(t-200:t,3,1),'double')*0.161*0.01),'r-');
                plot((cast(x(t-200:t,3,1),'double')*0.161*0.01),'g-');
                xlabel('iter');
                ylabel('Oe');
                axis([0 200 -inf inf]);
            end
            pause(0.001);
            hold off;
        case 4
            if(t<=200)
                subplot(2,2,4);
                plot((cast(z(1:t-1,4,1),'double')*0.294*0.01),'b-');
                hold on;
                grid on;
                plot((cast(y(1:t-1,4,1),'double')*0.161*0.01),'r-');
                plot((cast(x(1:t-1,4,1),'double')*0.161*0.01),'g-');
                xlabel('iter');
                ylabel('Oe');
                axis([0 200 -inf inf]);
            else
                subplot(2,2,4);
                plot((cast(z(t-200:t,4,1),'double')*0.294*0.01),'b-');
                hold on;
                grid on;
                plot((cast(y(t-200:t,4,1),'double')*0.161*0.01),'r-');
                plot((cast(x(t-200:t,4,1),'double')*0.161*0.01),'g-');
                xlabel('iter');
                ylabel('Oe');
                axis([0 200 -inf inf]);
            end
            pause(0.001);
            hold off;
    end
        if(d==4)
            t=t+1;
            d=0;
        end
    t3=toc(t2);
    %fprintf('aquis: %f   plot: %f\n', t1, t3);
end
out=[];
out(:,1)=cast(1:t-1,'double');
%X
out(:,2)=x(1:t-1,1);
out(:,5)=x(1:t-1,2);
out(:,8)=x(1:t-1,3);
out(:,11)=x(1:t-1,4);
%Y
out(:,3)=y(1:t-1,1);
out(:,6)=y(1:t-1,2);
out(:,9)=y(1:t-1,3);
out(:,12)=y(1:t-1,3);
%Z
out(:,4)=z(1:t-1,1);
out(:,7)=z(1:t-1,2);
out(:,10)=z(1:t-1,3);
out(:,13)=z(1:t-1,4);
%ESCRITA
dlmwrite('fileID.log',out, ' ');
%legend('z','y','x');
fclose(comport);