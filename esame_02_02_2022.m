% Overshoot < 20%
% ts più piccolo possibile
% errore nullo per rif. rampa

clc;
clearvars;
close all;

s = tf("s");
P = -(s + 5) / (s * (s^2 + 4 * s + 2));

% Errore nullo per rif. a rampa
% P(s) è di tipo 1
h = 1;
C1 = 1 / s^h;

% controlSystemDesigner(P, C1);

% Il controllore deve essere realizzabile
% deg(den(C)) >= deg(num(C))
C = (-332.3 * (s + 0.5) * (s + 1)^2) / (s + 10)^2 * C1;
L = C * P;

Wyr = minreal(L / (1 + L));

% Overshoot circa 10% e tempo di assestamento ts = 3.1
figure;
step(Wyr);
grid on;

Ts = 0.1;
t = 0:Ts:100;
figure;
lsim(Wyr, t, t);
grid on;













