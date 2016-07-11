clear;
close all;
delete(instrfindall); %?

%fileID = fopen('dados.txt','w');

a=[];
comport=serial('COM10', 'Baudrate', 9600);
fopen(comport);
x=int16.empty(100000000,0);
y=int16.empty(100000000,0);
z=int16.empty(100000000,0);
Fz=double.empty(100000000,0);
Fy=double.empty(100000000,0);
Fx=double.empty(100000000,0);
tempo=int32.empty(100000000,0);
tempo(1)=0;
t=0;


if strcmp(computer('arch'),'win32'),     addpath '.\mex_files\32bit'; end      % If the MATLAB is 32bit
if strcmp(computer('arch'),'win64'),     addpath '.\mex_files\64bit'; end      % If the MATLAB is 64bit

ports = OptoPorts(3);                   % For 3 axis sensors - Get an instance of the OptoPorts class (3 - only 3D sensors; 6 - only 6D sensors )

version = ports.getAPIversion;          % Get the API version (Major,Minor,Revision,Build)
pause(1)                                % To be sure about OptoPorts enumerated the sensor(s)
available_ports = ports.listPorts;      % Get the list of the available ports
if (isempty(available_ports)), disp('No DAQ is connected...'); else disp(available_ports);end;

if (ports.getLastSize()>0),             % Is there at least 1 available port?
    
    port = available_ports(1,:);        % If at least 1 port is available then select the first one
    
    daq = OptoDAQ();                    % Get an instance of the OptoDAQ class (this class handles the actual sensor reading)
    isOpen = daq.open(port,0);          % Open the previously selected port (the second argument:  0 - high-speed mode; 1 - slower debug mode)
    
    if (isOpen==1),
        
        speed = 1000;                   % Set the required DAQ's internal sampling speed (valid options: 1000Hz,333Hz, 100Hz, 30Hz)
        filter = 15;                    % Set the required DAQ's internal filtering-cutoff frequency (valid options: 0(No filtering),150Hz,50Hz, 15Hz)
        daq.sendConfig(speed,filter);   % Sends the required configuration
        
        channel = 1;                    % Some DAQ support multi-channel, othwerwise it must be 1
        output = daq.read3D(channel);   % For 3 axis sensors - Reads all the available samples (output.size) to empty the buffer
        
        t0 = tic; elapsed_time = 0; received_samples = 0; n = 0; Fz = output.Fz(end); Fy = output.Fy(end); Fx = output.Fx(end); % Initialize the variables
        loop_time=0;
        
        for g=1:50
            if(strcmp(fscanf(comport,'%s'),'BEGIN')==1)
                break;
            end
        end
        if (g==50)
            disp('Starting string not found');
            return;
        end
        
        while (elapsed_time<600 && output.size>=0 ),        % Loop for 10sec (quit if any error)
            
            
            %-----------------------OPTO---------------------------------------
            n = n+1;
            output = daq.read3D(channel);   % For 3 axis sensors - Reads all the available samples (output.size)
            
            if (output.size==-2), disp('The DAQ has been disconnected... '); end;
            if (output.size==-3), disp('The selected DAQ channel does not exist... ');  end;
            
            % For 3 axis sensors - Display the most current Fx,Fy,Fz sensor values (all are in Counts, refer to the sensitivity report to convert it to N.)
            %[ output.Fx(end) output.Fy(end) output.Fz(end) ]
            
            
            %Sensor_peq -  415.58 Counts/N (Fz) (aprox same for xy)
            %Sensor_med -  399.18 Counts/N (Fz) - aprox 500 for xy
            %Sensor_gra -  160.91 Counts/N (Fz)
            
            Sz = 415.58;
            %Sxy =
            output.Fz = output.Fz/Sz;
            output.Fy = output.Fy/Sz;
            output.Fx = output.Fx/Sz;

            %             Fz = [Fz output.Fz];            % Fz stores all the received samples of output.Fz
            hz=length(Fz);
            hy=length(Fy);
            hx=length(Fx);
            Fz(hz:hz+length(output.Fz)-1)=output.Fz;
            Fy(hy:hy+length(output.Fy)-1)=output.Fy;
            Fx(hx:hx+length(output.Fx)-1)=output.Fx;

            %----------------------TEMPO---------------------------
            elapsed_time = toc(t0);                                 % Elapsed time since the beginning of the code
            loop_time =(toc(t0)-elapsed_time) * 1000;               % The current time required the loop to be iterated (should be 1000/sample_rate + 1-2 ms) without pause
            received_samples = received_samples + output.size;      % All samples received since the beginning of the code
            sample_rate = received_samples / elapsed_time;          % Average sample rate since the beginning of the code (current received sample rate may by slower or faster due to the OS)
            ze=received_samples;
            %fprintf('Elapsed time = %3.5f sec        Received samples =%7.0f        Sample rate (avarage) = %4.0f Hz       Current loop time  = %3.3f ms\n',elapsed_time,received_samples,sample_rate, loop_time);
            %fprintf(fileID,'Time = %3.5f sec Fz= %.2f N   zfield= %d counts \n',elapsed_time, output.Fz, z);
 
            %----------------------------ARDUINO------------------------------------
            t=t+1;
%             tempo(t)=received_samples;
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
            
            %-----------------------PLOT---------------------------------
            ze=ze-t;
            tempo(t)=ze;
            %Fy = [Fy output.Fy];            % Fy stores all the received samples of output.Fy
%             %             tempo(t)=elapsed_time;
%             drawnow;
%             %  clf;
%             %             plot(1:length(Fz),Fz,'b');  ylim([min(Fz)-10 max(Fz)+10]);    title(' Fz (in counts) vs samples plot');
%             subplot(2,1,1)       % add first plot in 2 x 1 grid
%             plot(tempo(1:t),z,'r'); title('z field (counts)');
%             
%             %hold on;
%             
%             subplot(2,1,2)
%             %Fz=0;% add second plot in 2 x 1 grid
%             plot(Fz(1:ze),'b');  ylim([-1 5]);    title(' Fz (Newton)');
%             
%             %             hold off;
%             %            plot(Fy,'g'); drawnow;
%             %             plot(1:length(Fz),1000*Fz,'b',tempo(1:t),z,'r');
%             
%             %             drawnow; % Plot now
%             hold off;
            %drawnow;
            %plot(tempo(1:t),y,1:ze,10000*Fy(1:ze),'r');
        end

        daq.close();                    % Close the already opened DAQ 
    %plot(Fz,'b');  ylim([-1 10]);    title(' Fz (in Newton) vs samples plot');     
    else
        disp('The DAQ could not be opened');   
    end
    
%fclose(fileID);
fclose(comport);    
end
subplot(3,1,1)
plot(tempo(1:t),z,1:ze,10000*Fz(1:ze));
legend('z (Ard)', 'z (Opto)');
hold on;

subplot(3,1,2)
plot(tempo(1:t),y,1:ze,10000*Fy(1:ze));
legend('y (Ard)', 'y (Opto)');
hold on;

subplot(3,1,3)
plot(tempo(1:t),x,1:ze,10000*Fx(1:ze));
legend('x (Ard)', 'x (Opto)');

out(:,1)=tempo;
out(:,2)=x;
out(:,3)=y;
out(:,4)=z;
dlmwrite('sensor_hall_min2.log',out, ' ');
out2(:,1)=cast(1:ze,'double');
out2(:,2)=Fx(1:ze);
out2(:,3)=Fy(1:ze);
out2(:,4)=Fz(1:ze);
dlmwrite('sensor_opto_min2.log',out2, ' ');
%plot(tempo(1:t),z,tempo(1:t),y,tempo(1:t),x,1:ze,1000*Fz(1:ze),1:ze,1000*Fy(1:ze),1:ze,1000*Fx(1:ze))

clear daq;                              % Destroy the OptoDAQ class
clear ports;                            % Destroy the OptoPorts class
