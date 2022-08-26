% Plot  the temperature evolution calculated by the fortran program.
%All units are in SI.
%Writed by Wu Ming Yang.
% Date:2017/12/1

clear;clc;close all;

nt=2000;nx=100;
t=20;
td=20;

x=load('diff.dat');
x=x';
t0=0;x0=0;xd=1;
dx=(xd-x0)/nx;
dt=(td-t0)/nt;

xw(nx)=0;
for j=1:nx
    xw(j)=dx*j;
end
ts_char=num2str(t);
ttt='t=';
ts=strcat(ttt,ts_char);

i=floor(t/dt);
temp(nx)=0;
for j=1:nx
    temp(j)=x(i,j);
end
%%
i_switch_print=1;%1-sve the figure; 0-not save
resolution='-r450';
ls=25;lw=3;

ps = get(0, 'ScreenSize');
ps1(1) = floor(ps(3)*0.02);
ps1(2) = floor(ps(4)*0.5);
ps1(3) = floor(ps(3)*0.3);
ps1(4) = floor(ps(4)*0.4);

figure
plot(xw,x(1,:),'k','LineWidth',lw)
hold on
plot(xw,x(500,:),'g','LineWidth',lw)
hold on
plot(xw,x(1000,:),'b','LineWidth',lw)
hold on
plot(xw,x(1500,:),'m','LineWidth',lw)
hold on
plot(xw,x(2000,:),'r','LineWidth',lw)

xlabel('$$x\,\rm(m)$$', 'interpreter', 'latex');
ylabel('$$T\,\rm(K)$$', 'interpreter', 'latex');
le=legend('t=0 s','t=5 s','t=10 s','t=15 s','t=20 s');
posi = get(le,'Position');
set( le,'Position',[posi(1)-0.3,posi(2)-0.45,posi(3),posi(4)]);
set(gca, 'FontName', 'Times New Roman'); 
set(gca, 'fontsize', ls);
set(gcf,'position',ps1)
fname='T_t';
if i_switch_print>0.1
    print([fname,'.png'],'-dpng',resolution);
end
