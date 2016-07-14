% clear;
% 
% data=importdata('C:\Users\Pedro\Documents\Sensor_Hall\Sensor-0xe\sensor_hall_min_ruido.log');
% l=length(data(:,1));
% 
% for i=1:l-1
%     if data(i,1)==data(i+1,1)
%         data=[data(1:i,:); data(i+2:end,:)];
%     end
% end
% 
% newdatax=interp1(data(:,1),data(:,2),1:1:data(end,1));
% newdatay=interp1(data(:,1),data(:,3),1:1:data(end,1));
% newdataz=interp1(data(:,1),data(:,4),1:1:data(end,1));
% 
% ampx=fft(newdatax(2:end));
% ampy=fft(newdatay(2:end));
% ampz=fft(newdataz(2:end));
% 
% df=(0.001)^(-1)*(length(newdatax)-1)^(-1);
% 1:10:data(end,1)*df,newdatay,1:10:data(end,1)*df,newdataz
[ampx,freqx]=plomb(data(:,2),data(:,1)/1000);
[ampy,freqy]=plomb(data(:,3),data(:,1)/1000);
[ampz,freqz]=plomb(data(:,4),data(:,1)/1000);
fz=ampz*0.294*0.01*(9.98)^(-1);
plot(freqz,ampz);
axis([0 2 0 inf]);

