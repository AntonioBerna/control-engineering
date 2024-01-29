% Esempio Utilizzo Reti Correttrici
clc;
clearvars;
close all;

s = tf("s");
P = 100 / ((1 + 0.1 * s) * (1 + 0.01 * s));

% figure;
% margin(P);
% grid on;
% 
% figure;
% rlocus(P);
% 
% figure;
% nyquist(P);

C1 = 1 / 10;
L1 = C1 * P;

C2 = (1 + 0.1 * s) / (1 + 1 * s); % ritardatrice
L2 = C2 * P;

C3 = (1 + 0.01 * s) / (1 + 0.001 * s); % anticipatrice
L3 = C3 * P;

figure;
bode(P, L1, L2, L3);
grid on;

Wyr = minreal(P / (1 + P));
Wyr1 = minreal(L1 / (1 + L1));
Wyr2 = minreal(L2 / (1 + L2));
Wyr3 = minreal(L3 / (1 + L3));

figure;
step(Wyr, Wyr1, Wyr2, Wyr3);
grid on;









