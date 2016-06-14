clear all;
if strcmp(computer('arch'),'win32'),     addpath '.\mex_files\32bit'; end      % If the MATLAB is 32bit
if strcmp(computer('arch'),'win64'),     addpath '.\mex_files\64bit'; end      % If the MATLAB is 64bit
               
ports = OptoPorts(3);                   % For 3 axis sensors - Get an instance of the OptoPorts class (3 - only 3D sensors; 6 - only 6D sensors ) 
%ports = OptoPorts(6);                  % For 6 axis sensors - Get an instance of the OptoPorts class (3 - only 3D sensors; 6 - only 6D sensors ) 

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
        %output = daq.read6D();         % For 6 axis sensors - Reads all the available samples (output.size) to empty the buffer
        
        t0 = tic; elapsed_time = 0; received_samples = 0; n = 0; Fz = output.Fz(end);   % Initialize the variables
        while (elapsed_time<10 && output.size>=0 ),        % Loop for 10sec (quit if any error)
            n = n+1;
            output = daq.read3D(channel);   % For 3 axis sensors - Reads all the available samples (output.size)
            %output = daq.read6D();         % For 6 axis sensors - Reads all the available samples (output.size)

            if (output.size==-2), disp('The DAQ has been disconnected... '); end;
            if (output.size==-3), disp('The selected DAQ channel does not exist... ');  end;

            % For 3 axis sensors - Display the most current Fx,Fy,Fz sensor values (all are in Counts, refer to the sensitivity report to convert it to N.)  
            %[ output.Fx(end) output.Fy(end) output.Fz(end) ]
            
            % For 6 axis sensors - Display the most current Fx,Fy,Fz,Tx,Ty,Tz sensor values (all are in Counts, refer to the sensitivity report to convert it to N/Nm.)  
            %[ output.Fx(end) output.Fy(end) output.Fz(end) output.Tx(end) output.Ty(end) output.Tz(end) ]
            
            
            %Sensor_peq -  415.58 Counts/N (Fz) (aprox same for xy)
            %Sensor_med -  399.18 Counts/N (Fz) - aprox 500 for xy
            %Sensor_gra -  160.91 Counts/N (Fz)

            %Sz = 415.58;
            %Sxy = 
            %output.Fz = output.Fz/Sz;
            Fz = [Fz output.Fz];            % Fz stores all the received samples of output.Fz
           
            %plot(Fz);  ylim([min(Fz)-10 max(Fz)+10]);    title(' Fz (in counts) vs samples plot'); drawnow; % Plot the Fz
                               
            
            loop_time =(toc(t0)-elapsed_time) * 1000;               % The current time required the loop to be iterated (should be 1000/sample_rate + 1-2 ms) without pause
            elapsed_time = toc(t0);                                 % Elapsed time since the beginning of the code
            received_samples = received_samples + output.size;      % All samples received since the beginning of the code
            sample_rate = received_samples / elapsed_time;          % Average sample rate since the beginning of the code (current received sample rate may by slower or faster due to the OS)
            fprintf('Elapsed time = %3.5f sec        Received samples =%7.0f        Sample rate (avarage) = %4.0f Hz       Current loop time  = %3.3f ms\n',elapsed_time,received_samples,sample_rate, loop_time);
            
        end

        daq.close();                    % Close the already opened DAQ 
        
    else
        disp('The DAQ could not be opened');   
    end
    
end

clear daq;                              % Destroy the OptoDAQ class
clear ports;                            % Destroy the OptoPorts class


