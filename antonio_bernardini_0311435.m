% Esame Controlli Automatici

% Email: carnevaledaniele@gmail.com

% - Errore nullo per riferimento a gradino
% - Errore < 30% per riferimento a rampa
% - Settling time <= 10s
% Enunciare, dimostrare e fornire un esempio del teorema di Nyquist
% P(s) = (s + 3) / (s + 4) calcolare C(z) con zoh

clc;
clearvars;
close all;

s = tf("s");
P = (3 - s) / (s^2 + 20 * s + 100);

Ts = 0.1;
t = 0:Ts:100;

% Errore nullo per riferimento a rampa
h = 2;
C = 26.347 * (s+0.01) / s^h;
L = C * P;
Wyr = minreal(L / (1 + L));

% Settling time circa 2.6 secondi
figure;
step(Wyr);
legend("Wyr rampa");
grid on;

% Simulazione riferimento a rampa
figure;
lsim(Wyr, t, t);
grid on;

% Simulazione riferimento a gradino
figure;
lsim(Wyr, heaviside(t), t);
grid on;

%% Enunciare, dimostrare e fornire un esempio (facile) del teorema di Nyquist

% Possiamo fornire diversi enunciati per il teorema di Nyquist, in
% particolare:

% Il Criterio di Nyquist per sistemi stabili ad anello aperto, nell'ipotesi che la funzione
% guadagno di anello L(s) abbia tutti i poli a parte reale negativa, eccezion fatta per un eventuale
% polo nullo semplice o doppio, condizione necessaria e suﬃciente perchè il sistema in retroazione
% sia asintoticamente stabile è che il diagramma polare completo della funzione L(jw) non circondi
% né tocchi il punto critico -1 + j0.
% 
% Il precedente enunciato del Criterio di Nyquist è quello che copre la maggior parte dei casi di
% interesse. Si può dare tuttavia il seguente enunciato più generale, che si applica anche al caso in
% cui il sistema in esame sia instabile ad anello aperto:
% 
% Il Criterio di Nyquist per sistemi instabili ad anello aperto, nell'ipotesi che la funzione
% guadagno di anello L(s) non presenti poli immaginari, eccezion fatta per un eventuale polo nullo
% semplice o doppio, condizione necessaria e suﬃciente perchè il sistema in retroazione sia asintot-
% icamente stabile è che il diagramma polare completo della funzione L(jw) circondi il punto critico
% -1 + j0 tante volte in senso antiorario quanti sono i poli della L(s) con parte reale positiva.
% 
% Inoltre possiamo "riassumere" il teorema utilizzando la seguente relazione:
% Z = N + P
% 
% dove Z è il numero di zeri instabili della funzione 1 + G(s) * H(s) nel semipiano destro di Gauss, N
% è il numero di giri in senso orario intorno al punto critico -1 + j0 e P è il numero di poli instabili
% della funzione L(s) = G(s) * H(s) nel semipiano destro di Gauss. In particolare per un sistema di
% controllo stabile se P != 0 allora Z = 0, cioè N = -P , il che signiﬁca che abbiamo un numero di
% giri N = P in senso anti-orario intorno al punto critico -1 + j0. Tuttavia se L(s) = G(s) * H(s) non
% presenta poli instabili, nel semipiano destro di Gauss, cioè P = 0 allora Z = N. Pertanto, per la
% stabilità, non ci devono essere giri in senso orario intorno al punto critico -1 + j0, cioè N = 0.
% 
% Per esempio G(s) = 144 / ((s + 1) * (s + 2) * (s + 3)), considerando
% H(s) = 1, L(s) = 144 / ((s + 1) * (s + 2) * (s + 3))

clc;
clearvars;
close all;

s = tf("s");
L = 144 / ((s + 1) * (s + 2) * (s + 3));
pole(L) % -3, -2, -1 => P = 0 non ci sono poli instabili
% quindi P = 0 => N = Z = 2 come si evince dalla simulazione

% figure;
% nyquist(L);
% grid on;

% infatti calcolando 1 + L(s)
den = 1 + minreal(L / (1 + L))
pole(1 / (s^3 + 6 * s^2 + 11 * s + 294))
% -8.6543, 1.3272 + 5.6754i, 1.3272 - 5.6754i
% ossia Z = 2 zeri instabili

%% Controllore Discreto
clc;
clearvars;
close all;

s = tf("s");
Ps = (s + 3) / (s + 4);

% Ts <= (2 * pi / w_b) / 10
% per w_b = 5 rad/s (banda passante)
Ts = 0.1; % tempo di campionamento

Pz = c2d(Ps, Ts, "zoh");
Pw = d2c(Pz, "Tustin"); % non ha poli nell'origine

% Errore a regime nullo per riferimento a rampa.
% Inserisco un doppio polo nell'origine nella P(w), in questo modo
% otteniamo e_ss = 0
h = 2;
C1 = 1 / s^h;

% Dopo un'analisi a tentativi il controllore che rispetta meglio
% le specifiche richieste è il seguente:
Cw = (s + 1) * C1;
Lw = Cw * Pw;

Wwyr = minreal(Lw / (1 + Lw));

% figure;
% step(Wwyr);
% grid on;

% Simulazione nel piano di Tustin
t = 0:Ts:100;
ramp = t;

figure;
lsim(Wwyr, ramp, t);
grid on;

% Analisi delle performance del sistema a tempo discreto
Cz = c2d(Cw, Ts, "Tustin");
Lz = Cz * Pz;
Wzyr = minreal(Lz / (1 + Lz));

figure;
nyquist(Lz); % il sistema a ciclo chiuso è stabile
grid on;

figure;
step(Wwyr, Wzyr);
grid on;

% Simulazione del sistema digitale
figure;
lsim(Wzyr, ramp, t);
grid on;

% In questo caso non possiamo usare un filtro Fr
% perchè il segnale di riferimento è una rampa.




