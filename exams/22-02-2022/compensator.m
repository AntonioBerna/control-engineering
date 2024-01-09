% Controlli Automatici - Esame 22-02-2022

% Specifiche del controllore C:
% - Errore nullo per riferimento a rampa
% - Overshoot più piccolo possibile
% - Tempo di assestamento t_s più piccolo possibile

clc;
clearvars;
close all;

s = tf("s");
P = -(s + 5) / (s * (s^2 + 4*s + 2));

% Utilizzo i diagrammi di Bode, il luogo delle radici e il diagramma di
% Nyquist per avere informazioni sul plant P

% figure;
% margin(P);
% grid on;
% 
% figure;
% rlocus(P);
% 
% figure;
% nyquist(P);

% Soluzione 1: sintetizzare il controllore C partendo dal luogo delle
% radici. In particolare sapendo che P = -(s + 5) / (s * (s^2 + 4*s + 2))
% per ottenere un errore a regime nullo per il riferimento a rampa abbiamo
% che e_ss = lim_{s -> 0} s * -(s + 5) / (s * (s + 4*s + 2)) * R/s^2 =
% lim_{s -> 0} -(s + 5) / (s * (s^2 + 4*s + 2)) che essendo un sistema di
% tipo 1, per un riferimento a rampa, otteniamo e_ss = R / K, quindi
% aggiungo un polo nell'origine in modo tale che il sistema diventi di tipo
% 2, che per un riferimento a rampa ci permette di ottenere e_ss = 0.
% Inoltre inserisco un guadagno K = -1 per cambiare il segno al luogo
% delle radici poichè abbiamo sempre studiato per semplicità il caso K > 0.
% Pertanto la prima azione di controllo è un'azione di tipo PI.

K = -1;
C1 = K / s;

% A questo punto osserviamo che il luogo delle radici, del controllore che
% stiamo realizzando, presenta un polo all'infinito, pertanto conviene
% aggiungere uno zero per attirare tale polo nel semipiano sinistro. 
% Tuttavia con quest'ultima aggiunta il controllore C è descritto da una
% funzione propria (n = m), pertanto possiamo aggiungere anche un polo per
% rendere il controllore strettamente proprio (n > m).

tau_z = 1 / 0.5;
tau_p = 1 / 100;
C2 = (1 + tau_z * s) / (1 + tau_p * s);

% C = C1 * C2;
% figure;
% nyquist(C * P);
% pole(C * P)

% Utilizzando la funzione nyquist(C * P); è facile verificare che il
% sistema retroazionato è instabile. Pertanto possiamo utilizzare una rete
% correttrice per aumentare il margine di fase. In particolare la rete che
% ci permette di fare ciò è una rete anticipatrice, che talvolta diminuisce
% la sovraelongazione massima e il tempo di assestamento t_s.
% Tuttavia bisogna ricordare che alpha < 1, tau_ra > alpha * tau_ra e che
% w_m = 1 / (tau_ra * sqrt(alpha)).
% In particolare dall'ultima formula è possibile ricavare il valore di
% tau_ra e questo vuol dire che il valore di w_m risulterà arbitrario.

alpha = 0.1;
w_m = 5;
tau_ra = 1 / (w_m * sqrt(alpha));
Ra = (1 + tau_ra * s) / (1 + alpha * tau_ra * s);

% A questo punto costruiamo il blocco del controllore C, la funzione di
% guadagno ad anello aperto L(s) e anche la funzione del sistema in
% retroazione Wyr(s). Utilizzando il controllore C = C1 * C2 * Ra ed in
% particolare analizzando la risposta al gradino unitario ci accorgiamo che
% la sovraelongazione massima è del 41.4% mentre il tempo di assestamento è
% pari a t_s = 5.26s. Pertanto possiamo ottenere sicuramente risultati
% migliori. Ma in che modo? Se analizziamo il diagramma di Nyquist o i
% diagrammi di Bode vediamo che il margine di fase è Mf = 37.6deg ma
% normalmente per garantire la stabilità a lungo termine tale valore deve
% essere compreso tra 45deg e 60deg. Pertanto possiamo provare ad
% utilizzare nuovamente (in cascata) la rete correttrice Ra e ci aspettiamo
% che la sovraelongazione massima e il tempo di assestamento t_s
% diminuiscano ulteriormente.

% Utilizzando il controllore C = C1 * C2 * Ra^2 ed in particolare
% analizzando la risposta al gradino unitario ci accorgiamo che la
% sovraelongazione massima è 11.2% mentre il tempo di assestamento è
% pari a t_s = 3.62s. Pertanto poichè un overshoot accettabile è compreso
% tra 4% e 25% e poichè il tempo t_s si verifica per 0.6 < zeta < 0.7
% circa, possiamo affermare di aver rispettato ed implementato le
% specifiche di progettazione.

C = C1 * C2 * Ra^2;
L = C * P;
Wyr = minreal(L / (1 + L));

% Tuttavia possiamo migliorare ancora di più le specifiche inserendo un
% filtro passa basso Fr per rendere più smooth il segnale di riferimento,
% andando a filtrare le componenti ad alta frequenza del sistema e quindi
% riducendo ulteriormente la sovraelongazione massima. In particolare
% consideriamo Fr(s) = 1 / (1 + tau_fr * s) dove tau_fr = 1 in modo tale
% che il modulo della f.d.t. |F(jw)| = 1 / sqrt(1 + w^2 * tau_fr^2) e
% pertanto tracciando i diagrammi di Bode si evince che in corrispondenza
% della pulsazione di taglio w_c = 1 / tau_fr il guadagno calcolato in w_c
% è |Fr(jw_c)| = 1 / sqrt(2), che corrisponde ad un'attenuazione del
% segnale di -3dB. Inoltre ci costruiamo la funzione W(s) che
% naturalmente sarà data dalla cascata tra Fr(s) e Wyr(s).

tau_fr = 1;
Fr = 1 / (1 + tau_fr * s);

% figure;
% margin(Fr);
% grid on;

W = Fr * Wyr;

% Utilizzo i diagrammi di Bode, il luogo delle radici e il diagramma di
% Nyquist per avere informazioni sulla funzione del guadagno ad anello
% L(s), sul sistema in retroazione Wyr(s) e sul sistema filtrato W(s)
% (sempre in retroazione).

figure;
margin(L);
grid on;

figure;
rlocus(L);

figure;
nyquist(L);

figure;
step(Wyr, W);
grid on;

% Utilizzando il filtro Fr(s) ed in particolare analizzando la risposta al 
% gradino unitario ci accorgiamo che la sovraelongazione massima è 1.76%
% mentre il tempo di assestamento è pari a t_s = 2.58s. Pertanto possiamo
% affermare di aver migliorato ulteriormente le specifiche di progetto.

% A questo punto è il momento di analizzare se la soluzione proposta è
% accettabile, ed in particolare confrontiamo la risposta del sistema in
% retroazione con filtraggio a tempo continuo W(t) con l'imgresso a
% rampa.

t = 0:0.1:100;
ramp = t;

figure;
lsim(W, ramp, t);
grid on;











