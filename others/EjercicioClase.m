clc 
clearvars;
close all

s = tf([1,0],1);

P = 10*(s-1)/(s^2+4*s+8);

C1 = -0.0145*(s^2+4*s+8)*(4*s+1)/(s^2*(0.1*s+1)); %error nulo rampa

n = 3;
omega_b = 2*pi*10; % omega_d2 = 2*pi*50
omega_d2 = 2*pi*50;
[b, a] = butter(n, omega_b, 's');

Fb = tf(b, a);
H = Fb; % atenuar disturbo2

L1 = minreal(C1*H*P);

figure(3)
rlocus(L1)
grid on

figure(4)
margin(L1)
grid on

Wyr1 = minreal(C1*P/(1+C1*P*H));

figure(3)
step(Wyr1)
grid on
 
alpha = 0.35;
omega_max = 0.6;
tau = 1/(omega_max*sqrt(alpha));
 
Ra = (1+tau*s)/(1+tau*alpha*s);
C2 = 10^(-7/20)*C1*Ra;
 
L2 = C2*H*P;
 
figure(4)
margin(L2)
grid on

Wyr2 = minreal(C2*P/(1+C2*P*H));
  
figure(5)
step(Wyr2)
grid on
 
tau_fr = 0.13;
Fr = 1/(tau_fr*s+1);

Wyr3 = minreal(Fr*C2*P/(1+C2*P*H));
 
figure(6)
step(Wyr2,Wyr3)
grid on
legend('Wyr2','Wyr3')
 
Wer = minreal((1+P*C2*(H-Fr))/(1+P*C2*H))

Wyd2 = minreal(-(P*C2*H)/(1+P*C2*H));

figure(7)
bode(Wyd2)
grid on

t = 0:0.01:100;
Wyd2 = minreal(-P*C2*H/(1+P*C2*H));

d2 = 10*sin(50*2*pi*t);


figure(9)
lsim(Wyd2,d2,t)
grid on
