% transfer function with Bode Plot
clear all
close all
clc
format short eng

syms R R2 R3 C s Vi Va Vb Vc Vo

ZC=inv(s*C);

eqn(1)=Vb==Vc; % KVL Op Amp
eqn(2)=-((Vi-Va)/(R))+((Va-Vo)/(R))+((Va-Vb)/(ZC))+((Va)/(ZC))==0; % KCL Node A
eqn(3)=((Va-Vb)/(ZC))-((Vb)/(R2))==0; % KCL Node B
eqn(4)=-((Vo-Vc)/(R3))+((Vc)/(R))==0; % KCL Node C
sol=solve(eqn,Va,Vb,Vc,Vo);

H=sol.Vo/Vi;% Gain is output over input

H=subs(H,[R R2 R3 C],[1e3 2e3 24e3 10e-9]);
pretty(simplify(H)) %Print the transfer function in the Command Window

f=logspace(0,8,1000);
w=2*pi*f;
H=subs(H,s,j*w);

figure(1)
subplot(2,1,1)
semilogx(f,20*log10(abs(H)),'LineWidth',2,'color','b')
grid on
ylabel('Gain (dB)')

fig=gcf;
set(findall(fig,'-property','FontSize'),'FontSize',18)

subplot(2,1,2)
semilogx(f,angle(H)*(180/pi),'LineWidth',2,'color','b')
grid on

xlabel('Frequency (Hz)')
ylabel('Phase Shift (deg)')

fig=gcf;
set(findall(fig,'-property','FontSize'),'FontSize',18)