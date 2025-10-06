clear all
close all
clc
format short eng
format compact

% break signal into phasors Using Fourier series 

n=200;
t0=0;t1=0.012;
T0=t1-t0;
w0=(2*pi)/T0;
u=@(t) heaviside(t)
Vi=@(t) 6*abs(cos(w0*(t-0.002))).*(u(t-0.002)-u(t-0.008))
x=@(t) Vi(t);

for k=0:n;
    integrand=@(t) (x(t)).*cos(k.*w0.*t);
    a(k+1)=(2/T0)*integral(integrand,t0,t1);
    
    integrand=@(t) (x(t)).*sin(k.*w0.*t);
    b(k+1)=(2/T0)*integral(integrand,t0,t1);
end

t=t0:T0/1000:t1;
x_hat=(a(1)/2);
for k=1:n;
    x_hat=x_hat+ a(k+1).*cos(k.*w0.*t)+ b(k+1).*sin(k.*w0.*t);
end

figure(4)
hold on; grid on
plot(t,x(t),'ro-','LineWidth',10)
plot(t,x_hat,'b','LineWidth',5)
xlabel('Time (s)')
xlim([0,0.01])
legend('x(t)','x\_hat(t)')
set(findall(gcf,'-property','FontSize'),'FontSize',14) 
