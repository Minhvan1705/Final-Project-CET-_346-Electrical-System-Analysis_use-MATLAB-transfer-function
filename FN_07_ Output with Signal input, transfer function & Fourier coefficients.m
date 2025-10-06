clear all
close all
clc
format short eng
format compact

%% plot signal with heavisides
T0=0.012;     
w0=((2*pi)/T0);    % angular frequency

t=0:T0/1000:T0;
u=@(t) heaviside(t)

Vi=@(t) 6*abs(cos(w0*(t-0.002))).*(u(t-0.002)-u(t-0.008))

%% break signal into phasors Using Fourier series 

n=200;
t0=0;t1=0.012;
T0=t1-t0;
w0=(2*pi)/T0;
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

figure(6)
title('THE OUTPUT OF CIRCUIT','Color','b','FontSize',30)
hold on;grid on
plot(t,x(t),'ro-','LineWidth',10)
plot(t,x_hat,'b','LineWidth',8)
xlabel('Time (s)')
xlim([0,0.01])
ylabel('Voltage (V)')
legend('x(t)','x\_hat(t)')
set(findall(gcf,'-property','FontSize'),'FontSize',14) 

%% Finding a transfer function

syms R C s Vi Va Vb Vc Vo

ZC=inv(s*C);

eqn(1)=Vb==Vc; % KVL Op Amp
eqn(2)=-((Vi-Va)/(R))+((Va-Vo)/(R))+((Va-Vb)/(ZC))+((Va)/(ZC))==0; % KCL Node A
eqn(3)=((Va-Vb)/(ZC))-((Vb)/(2*R))==0; % KCL Node B
eqn(4)=-((Vo-Vc)/(24*R))+((Vc)/(R))==0; % KCL Node C
sol=solve(eqn,Va,Vb,Vc,Vo);

H=sol.Vo/Vi;% Gain is output over input

H=simplify(subs(H,[R C],[1e3 10e-9]));
H=matlabFunction(H)

%% DC component output
vo_hat=(a(0+1)/2)*(H(j*0)); %DC input times DC gain

for k=1:n
    Vi=a(k+1)-j*b(k+1);
    Vo=Vi*H(j*k*w0);
    vo_hat=vo_hat+abs(Vo).*cos(k.*w0.*t+angle(Vo));
end

plot(t,vo_hat,'g','LineWidth',3)
