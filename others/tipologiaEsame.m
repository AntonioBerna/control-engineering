% Esame di Controlli Automatici

% Specifiche del controllore C:
% - Errore a regime <= 10% per riferimento a rampa
% - Overshoot <= 20%
% - Design del Controllore Digitale C(z)
% - Design per controllare asintoticamente un
%   disturbo d_2 = 10 * sin(50 * 2 * pi)
% - presenza di un ritardo e^(-0.05 * s) nella P(s)

clc;
clearvars;
close all;

s = tf("s");
P = 10 * (s - 1) / (s^2 + 4 * s + 8);

% Errore a regime nullo con riferimento a rampa
h = 2; % poichè P(s) è di tipo 0
C1 = 1 / s^h;

% Overshoot <= 20% (Luogo delle Radici)
C2 = -0.26597 * (s + 0.05);

% Design del controllore C terminato
C = C1 * C2;
L = C * P;

% Diagramma di Bode
figure;
margin(L);
grid on;

% Luogo delle Radici
figure;
rlocus(L);

% Risposta al gradino unitario
Wyr = minreal(L / (1 + L));

figure;
step(Wyr);
grid on;

% Simulazione della funzione Wyr con riferimento a rampa
Ts = 0.1;
t = 0:Ts:100;
ramp = t;

figure;
lsim(Wyr, ramp, t);
grid on;

% Rifare il Design aggiungendo il disturbo di misura
% d_2 = 10 * sin(2 * pi * 50 * t)

Ts = 0.01;
t = 0:Ts:100;
A = 10;
f = 50;
w = 2 * pi * f;
d2 = A * sin(w * t);

% Simulazione della funzione Wyr con ingresso il disturbo d2
figure;
lsim(Wyr, d2, t);
grid on;

% Design del filtro H mettendo un polo una decade prima della w
p = w / 10;
tau = 1 / p;
H = 1 / (1 + tau * s);
Wyd2 = minreal((-L * H) / (1 + L * H));

% Simulazione della funzione Wyd2 che elimina il disturbo d2 d'ingresso
figure;
lsim(Wyd2, d2, t);
grid on;

% Rifare il Design aggiungendo il disturbo
% sull'impianto costante d_1 = 10

Ts = 0.01;
t = 0:Ts:100;

% ones(m, n) crea una matrice m x n, l'apice fa l'operazione di trasposta.
% In questo caso ottenimo una matrice con 1 riga e 100 colonne avente
% tutte le componenti pari a 10.
d1 = 10 * ones(length(t), 1)';

% Simulazione della funzione Wyr con ingresso il disturbo d1
figure;
lsim(Wyr, d1, t);
grid on;

% Design del filtro H. In questo caso poichè nel controllore C è già
% presente uno zero nell'origine possiamo imporre H = 1;
H = 1;
Wyd1 = P / (1 + P * C * H);

% Simulazione della funzione Wyd1 che elimina il disturbo d1 d'ingresso
figure;
lsim(Wyd1, d1, t);
grid on;

%% Design del controllore digitale C(z) con le seguenti specifiche:
% - errore nullo per riferimenti costanti
% - Overshoot <= 20%
% - banda passante superiore a 5 rad/s

% Per prima cosa scegliamo un tempo di campionamento:
% 
% w_b >= 5 rad/s
% ni_b >= w_b / (2 * pi)
% ni_s >= 10 * ni_b, dove ni_s = 1 / Ts per cui:
% 
% Ts <= (2 * pi / w_b) / 10

w_b = 5;

% Ts <= (2 * pi / 5) / 10 = 0.1257
Ts = 0.1;

Pz = c2d(P, Ts, "zoh");
Pw = d2c(Pz, "Tustin")

% Errore nullo per riferimenti costanti
h = 1; % P(w) è di tipo 0
C1 = 1 / s^h;

figure;
bode(P, Pz, Pw);
grid on;
legend("P", "Pz", "Pw");

% controlSystemDesigner(Pw, C1);
K = -0.33371;

% Design del controllore C(w) terminato
Cw = K * C1;
Lw = Cw * Pw;
Wwyr = minreal(Lw / (1 + Lw));

% Analisi delle performance del sistema a tempo discreto
Cz = c2d(Cw, Ts, "Tustin");

Lz = Cz * Pz;
Wzyr = minreal(Lz / (1 + Lz));

figure;
step(Wwyr, Wzyr);
grid on;

%% Rifare il Design aggiungendo un ritardo e^(-0.05 * s) alla P(s)

% con il ritardo il luogo delle radici non funziona

clc;
close all;

% predittore di smith!!!
Td = 0.05;
N = 1; % capire l'ordine

Pd = C * P * exp(-Td * s);
[num, den] = pade(Td, N);
Pa = C * P * tf(num, den);

figure;
bode(Pd, Pa);
legend("Pd","Pa");
grid on;

%% Design del controllore tramite PID
Kp = -0.21858; % 1
Ki = -0.47041; % 0
Kd = -0.02539; % 0
C = pid(Kp, Ki, Kd);

% pidTuner(P, C);

L = C * P;

figure;
nyquist(L);

figure;
margin(L);
grid on;

Wyr = minreal(L / (1 + L));

figure;
step(Wyr);
grid on;

t = 0:0.1:100;
ramp = t;

figure;
lsim(Wyr, ramp, t);
grid on;

































