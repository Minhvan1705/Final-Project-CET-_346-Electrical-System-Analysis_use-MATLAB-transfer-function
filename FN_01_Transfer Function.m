% Finding a transfer function with Nodal Analysis
clear all
close all
clc
format short eng
format compact

syms R C s Vi Va Vb Vc Vo

ZC=inv(s*C);

eqn(1)=Vb==Vc; % KVL Op Amp
eqn(2)=((Vi-Va)/(R))+((Vo-Va)/(R))-((Va-Vb)/(ZC))-((Va)/(ZC))==0; % KCL Node A
eqn(3)=((Va-Vb)/(ZC))-((Vb)/(2*R))==0; % KCL Node B
eqn(4)=((Vo-Vc)/(24*R))-((Vc)/(R))==0; % KCL Node C
sol=solve(eqn,Va,Vb,Vc,Vo);

H=sol.Vo/Vi;% Gain is output over input

H=subs(H,[R C],[1e3 10e-9]);
pretty(simplify(H)) % Print the transfer function in the Command Window