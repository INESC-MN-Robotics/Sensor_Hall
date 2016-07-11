filename='sensor_hall_min2.log';
filename2='sensor_opto_min2.log';

Hall=dlmread(filename,' ');
Opto=dlmread(filename2,' ');
[rows,colums]=size(Hall);
[rows2,colums2]=size(Opto);


t=dlmread(filename,' ',[0 0 rows-1 0]);
x=dlmread(filename,' ',[0 1 rows-1 1]);
y=dlmread(filename,' ',[0 2 rows-1 2]);
z=dlmread(filename,' ',[0 3 rows-1 3]);

t2=dlmread(filename2,' ',[0 0 rows2-1 0]);
x2=dlmread(filename2,' ',[0 1 rows2-1 1]);
y2=dlmread(filename2,' ',[0 2 rows2-1 2]);
z2=dlmread(filename2,' ',[0 3 rows2-1 3]);


x=x*0.161*0.01;
y=y*0.161*0.01;
z=z*0.294*0.01;



% subplot(3,1,1);
% title('Hall sensor - Field vs counts')
% plot(t,x,'b');
% xlim([0 7.5E4])
% legend('x','Location','southwest')
% subplot(3,1,2);
% plot(t,y,'g');
% xlim([0 7.5E4])
% legend('y','Location','southwest')
% subplot(3,1,3);
% plot(t,z,'r');
% xlim([0 7.5E4])
% legend('z','Location','southwest')

%  figure
% subplot(3,1,1);
% plot(t2,x2,'b');
% xlim([0 7.5E4])
% legend('x','Location','northwest')
% title('Optical sensor - Force vs counts')
% subplot(3,1,2);
% plot(t2,y2,'g');
% xlim([0 7.5E4])
% legend('y','Location','northwest')
% subplot(3,1,3);
% plot(t2,z2,'r');
% xlim([0 7.5E4])
% legend('z','Location','northwest')
% ylabel('Force [N]')
% xlabel('counts')

% plot(t,x,'b');
% hold on;
% plot(t,y,'g');
% hold on
% plot(t,z,'r');
% legend('x','y','z','Location','west')
% ylabel('Field [Oe]')
% xlabel('Counts')
% xlim([0 3E4])
% title('Hall sensor')
% figure
% plot(t2,x2,'b');
% hold on;
% plot(t2,y2,'g');
% hold on
% plot(t2,z2,'r');
% legend('x','y','z','Location','west')
% ylabel('Force [N]')
% xlabel('Counts')
% xlim([0 3E4])
% title('Optical sensor')

% xx=0:rows2/rows:rows2-1;
% 
% z_opto=spline(t2,z2,xx);

%plot(t,z_opto)
cima=0;
thresh=0.25;
ii=0;
ff=0;
% while(ii<315)
% if(z_opto(ii)>z_opto(ii-1)+0.03)
%     cima=1;
%     zz=[zz z_opto(ii)];
%   
% end
% if(z_opto(ii)<z_opto(ii-1)+0.03 && cima==1)
%    ff=[ff mean(zz)];
%    zz=0;
%    j=j+1;
%    cima=0;
% end
% ii=ii+1;    
% end
% while(ii<18)
% in=2593;
% zz=z2(in+ii*2027*2+500:in+ii*2027*2+2027-500);
% ff=[ff mean(zz)];
% ii=ii+1;
% end


% z_optofilt = sgolayfilt(z_opto,3,11); %usar outro filtro
% subplot(2,1,1)
% plot(t,z_opto)
% subplot(2,1,2)
% plot(t,z_optofilt)
% hold on
% plot(2593-2593/2:73500/19:73500-2593/2,ff,'*')


% [pks,t_pks]=findpeaks(z_opto,t,'MinPeakProminence',0.1);
% plot(t_pks,pks,'*')
% hold on
% plot(t2,z2,'r');

 subplot(2,1,1);
 plot(t,z,'b');
 %xlim([220000 250000])
 subplot(2,1,2);
 plot(t2,z2,'r');
 %xlim([220000 250000])