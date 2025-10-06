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


for k=0:n;
    integrand=@(t) (Vi(t)).*cos(k.*w0.*t);
    a(k+1)=(2/T0)*integral(integrand,t0,t1);
    
    integrand=@(t) (Vi(t)).*sin(k.*w0.*t);
    b(k+1)=(2/T0)*integral(integrand,t0,t1);
end


figure(3)
hold on;grid on
semilogy(0:length(a)-1,a,'bx','LineWidth',4,'MarkerSize',10)
semilogy(0:length(a)-1,b,'ro','LineWidth',4,'MarkerSize',10)

xlabel('Multiple of the fundamental frequency - k')
ylabel('Coefficient')
legend('a_k','b_k')


t=t0:T0/1000:t1;
x_hat=(a(1)/2);
for k=1:n;
    x_hat=x_hat+ a(k+1).*cos(k.*w0.*t)+ b(k+1).*sin(k.*w0.*t);
end
set(findall(gcf,'-property','FontSize'),'FontSize',14) 
