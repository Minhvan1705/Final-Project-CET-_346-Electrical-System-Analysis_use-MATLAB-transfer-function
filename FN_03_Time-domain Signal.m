clear all
close all
clc
format short eng
format compact

T0=0.012;     
w0=((2*pi)/T0);    % angular frequency

t=0:T0/1000:T0;
u=@(t) heaviside(t)

Vi=@(t) 6*abs(cos(w0*(t-0.002))).*(u(t-0.002)-u(t-0.008))

figure(2)
plot(t,Vi(t), 'LineWidth',7,'Color','blue')

hold on
grid on
ylim([0,6])
xlim([0,0.01])
xlabel('Time (s)')
ylabel('Votage (V)')
fig=gcf;
set(findall(fig,'-property','FontSize'),'FontSize',16)