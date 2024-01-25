<TeXmacs|2.1>

<style|generic>

<\body>
  <doc-data|<doc-title|Esame 22/02/2022 di Controlli
  Automatici>|<doc-author|<author-data|<author-name|Antonio Bernardini>>>>

  <section|Testo>

  Un sistema fisico descritto dalla funzione di trasferimento
  <math|P<around*|(|s|)>=<frac|-<around*|(|s+5|)>|s*<around*|(|s<rsup|2>+4*s+2|)>>>
  può essere schematizzato come mostrato in figura <eqref|auto-1>.

  <big-figure|<image|block-diagram.png|0.75par|||>|Sistema di controllo>

  Si vuole progettare un controllore <math|C<around*|(|s|)>> che soddisfi le
  seguenti specifiche:

  <\enumerate>
    <item>Errore nullo per riferimento a rampa
    <math|r<around*|(|t|)>=R<rsub|0>*t>, dove <math|R<rsub|0>> è la pendenza

    <item>Overshoot più piccolo possibile

    <item>Tempo di assestamento <math|t<rsub|s>> più piccolo possibile
  </enumerate>

  Scrivere il ragionamento e spiegare le tecniche utilizzate per la
  progettazione del controllore <math|C<around*|(|s|)>>. Inoltre fornire
  l'implementazione del codice Matlab con i relativi grafici.

  <section|Soluzioni>

  Per prima cosa possiamo abbozzare il seguente codice Matlab:

  <\octave-code>
    clc;

    clearvars;

    close all;

    \;

    s = tf("s");

    P = -(s + 5) / (s * (s^2 + 4 * s + 2));

    \;

    figure;

    margin(P);

    grid on;

    \;

    figure;

    rlocus(P);

    \;

    figure;

    nyquist(P);
  </octave-code>

  in modo da ottenere i seguenti grafici:

  <big-figure|<tabular|<tformat|<cwith|1|1|1|-1|cell-halign|c>|<cwith|1|1|1|-1|cell-valign|c>|<table|<row|<cell|<image|images/bode.png|0.3par|||>>|<cell|<image|images/root-locus.png|0.3par|||>>|<cell|<image|images/nyquist.png|0.3par|||>>>>>>|Diagrammi
  di Bode, Luogo delle radici, Diagramma di Nyquist>

  A questo punto possiamo optare per la progettazione del controllore
  <math|C<around*|(|s|)>> tramite reti correttrici oppure tramite PID.
  Entrambe le soluzioni sono riportate di seguito.

  <subsection|Progettazione del controllore <math|C<around*|(|s|)>> tramite
  reti correttrici>

  Il primo passo per la progettazione di un controllore
  <math|C<around*|(|s|)>>, tramite l'ausilio delle reti correttrici, è
  ottenere errore <math|e<rsub|ss>=0> per un riferimento a rampa
  <math|r<around*|(|t|)>=R<rsub|0>*t>. Per tale scopo supponiamo inizialmente
  di trascurare l'aggiunta del controllore <math|C<around*|(|s|)>> imponendo
  la condizione <math|C<around*|(|s|)>=1>. Per prima cosa ricordando che:

  <\eqnarray>
    <tformat|<table|<row|<cell|f<around*|(|t|)>=t<rsup|n>>|<cell|<long-arrow|\<rubber-Rightarrow\>|<with|font|cal|L>>>|<cell|F<around*|(|s|)>=<frac|n!|s<rsup|<around*|(|n+1|)>>>>>>>
  </eqnarray>

  otteniamo un riferimento a rampa <math|R<around*|(|s|)>=<frac|R<rsub|0>|s<rsup|2>>>.
  Proviamo quindi a calcolare l'errore <math|e<rsub|ss>>. Con riferimento al
  sistema di controllo di figura <eqref|auto-1>, possiamo determinare la
  funzione di sensitività <math|W<rsub|e<rsub|true> r><around*|(|s|)>> come
  segue:

  <\eqnarray>
    <tformat|<table|<row|<cell|W<rsub|e<rsub|true>
    r><around*|(|s|)>=<frac|E<around*|(|s|)>|R<around*|(|s|)>>=<frac|R<around*|(|s|)>-Y<around*|(|s|)>|R<around*|(|s|)>>=1-<frac|Y<around*|(|s|)>|R<around*|(|s|)>>=1-<around*|\<nobracket\>|<frac|C<around*|(|s|)>*P<around*|(|s|)>|1+C<around*|(|s|)>*P<around*|(|s|)>>|\|><rsub|C<around*|(|s|)>=1>>|<cell|=>|<cell|<frac|1|1+P<around*|(|s|)>>>>>>
  </eqnarray>

  per cui l'errore <math|E<around*|(|s|)>> è dato da:

  <\eqnarray>
    <tformat|<table|<row|<cell|E<around*|(|s|)>=<frac|1|1+P<around*|(|s|)>>*R<around*|(|s|)>>|<cell|=>|<cell|<frac|1|1+<frac|-<around*|(|s+5|)>|s*<around*|(|s<rsup|2>+4*s+2|)>>>\<cdot\><frac|R<rsub|0>|s<rsup|2>>>>>>
  </eqnarray>

  pertanto, utilizzando il teorema del valore finale, possiamo ricavare
  l'errore a regime <math|e<rsub|ss>> come segue:

  <\eqnarray>
    <tformat|<table|<row|<cell|e<rsub|ss>=lim<rsub|s\<rightarrow\>0>s*E<around*|(|s|)>=lim<rsub|s\<rightarrow\>0><neg|s>*<frac|1|1+<frac|-<around*|(|s+5|)>|s*<around*|(|s<rsup|2>+4*s+2|)>>>\<cdot\><frac|R<rsub|0>|s<rsup|<neg|2>>>=lim<rsub|s\<rightarrow\>0><frac|R<rsub|0>|s+<frac|-<around*|(|s+5|)>|s<rsup|2>+4*s+2>>=<frac|R<rsub|0>|K<rsub|v>>>|<cell|,>|<cell|K<rsub|v>=-<frac|5|2>>>>>
  </eqnarray>

  infatti, come si evince dalla seguente tabella <eqref|auto-6>:

  <big-table|<math|<tabular|<tformat|<cwith|1|-1|1|-1|cell-halign|c>|<cwith|1|-1|1|-1|cell-tborder|1ln>|<cwith|1|-1|1|-1|cell-bborder|1ln>|<cwith|1|-1|1|-1|cell-lborder|1ln>|<cwith|1|-1|1|-1|cell-rborder|1ln>|<table|<row|<cell|Tipo>|<cell|Gradino>|<cell|Rampa>|<cell|Parabola>>|<row|<cell|0>|<cell|<frac|R<rsub|0>|1+K<rsub|p>>>|<cell|\<infty\>>|<cell|\<infty\>>>|<row|<cell|1>|<cell|0>|<cell|<frac|R<rsub|0>|K<rsub|v>>>|<cell|\<infty\>>>|<row|<cell|2>|<cell|0>|<cell|0>|<cell|<frac|R<rsub|0>|K<rsub|a>>>>>>>>|Tabella
  riassuntiva degli errori a regime>

  la funzione di trasferimento <math|P<around*|(|s|)>=<frac|-<around*|(|s+5|)>|s*<around*|(|s<rsup|2>+4*s+2|)>>>,
  essendo un sistema di tipo 1, per un riferimento a rampa
  <math|R<around*|(|s|)>=<frac|R<rsub|0>|s<rsup|2>>> presenta un errore a
  regime <math|e<rsub|ss>=<frac|R<rsub|0>|K<rsub|v>>>. Tuttavia una delle
  specifiche da soddisfare è quella di avere un errore a regime
  <math|e<rsub|ss>=0>. Pertanto, il primo parametro che si determina in fase
  di progetto, è il numero <math|h> di integratori da inserire nel
  controllore, in modo da avere <math|C<around*|(|s|)>=<frac|1|s<rsup|h>>>.
  In questo caso è sufficiente aggiungere <math|h=1> integratore per
  trasformare la funzione di trasferimento <math|P<around*|(|s|)>> in un
  sistema di tipo 2, che per un riferimento a rampa <math|R<around*|(|s|)>>,
  come si evince dalla tabella <eqref|auto-6>, ci permette di ottenere un
  errore a regime <math|e<rsub|ss>=0>. Pertanto:

  <\eqnarray>
    <tformat|<table|<row|<cell|C<around*|(|s|)>>|<cell|=>|<cell|<frac|1|s>>>>>
  </eqnarray>

  Il secondo parametro di progetto che si determina all'interno del
  controllore <math|C<around*|(|s|)>> è la costante di guadagno <math|K>, in
  modo da avere <math|C<around*|(|s|)>=<frac|K|s<rsup|h>>>. Tipicamente si
  utilizza il luogo delle radici applicato alla funzione
  <math|L<around*|(|s|)>=C<around*|(|s|)>*P<around*|(|s|)>> per fare una
  scelta ottimale del parametro <math|K> in modo da garantire la stabilità
  del sistema retroazionato. In particolare dobbiamo applicare il Criterio di
  Routh all'equazione caratteristica <math|1+C<around*|(|s|)>*P<around*|(|s|)>=0>
  come segue:

  <\eqnarray>
    <tformat|<table|<row|<cell|1+<frac|-K*<around*|(|s+5|)>|s<rsup|2>*<around*|(|s<rsup|2>+4*s+2|)>>=0>|<cell|\<Longrightarrow\>>|<cell|s<rsup|4>+4*s<rsup|3>+2*s<rsup|2>-K*s-5*K=0>>>>
  </eqnarray>

  tuttavia in questo caso è immediato osservare, senza applicare il Criterio
  di Routh, che è sufficiente una costante di guadagno <math|K=-1> per fare
  in modo che il sistema retroazionato sia asintoticamente stabile. Pertanto:

  <\eqnarray>
    <tformat|<table|<row|<cell|C<around*|(|s|)>>|<cell|=>|<cell|-<frac|1|s>>>>>
  </eqnarray>

  Si noti come con un'opportuna scelta dei parametri <math|h> e <math|K>
  tipicamente si riescono a soddisfare tutte le specifiche di precisione (nel
  nostro caso l'errore a regime nullo). Quindi la prima azione di controllo è
  un'azione di tipo PI (Proporzionale-Integrale) dove:

  <\eqnarray>
    <tformat|<table|<row|<cell|h=1,K=-1>|<cell|\<Longrightarrow\>>|<cell|C<rsub|1><around*|(|s|)>=<frac|K|s<rsup|h>>=-<frac|1|s>>>>>
  </eqnarray>

  pertanto possiamo aggiungere le seguenti righe al codice Matlab:

  <\octave-code>
    h = 1;

    K = -1;

    C1 = K / s^h;
  </octave-code>

  A questo punto osserviamo che il luogo delle radici, del controllore
  <math|C<around*|(|s|)>> che stiamo realizzando, presenta un polo
  all'infinito. Pertanto conviene aggiungere uno zero per attirare tale polo
  nel semipiano sinistro. Tuttavia, con quest'ultima aggiunta, il controllore
  <math|C<around*|(|s|)>> è descritto da una funzione propria (il numero dei
  poli <math|n> è uguale al numero degli zeri <math|m>), quindi possiamo
  aggiungere anche un polo veloce (quindi grande) per rendere il controllore
  strettamente proprio <math|<around*|(|n\<gtr\>m|)>>. Quest'ultimo passaggio
  è di fondamentale importanza per rendere il controllore realizzabile nella
  realtà. Inoltre dato che nel luogo delle radici gli zeri attirano i poli,
  più la parte reale dei poli è piccola, più sono lenti e viceversa più la
  parte reale dei poli è grande, più sono veloci. Pertanto possiamo scegliere
  per esempio lo zero <math|z=-0.5> con la corrispondente costante di tempo
  <math|\<tau\><rsub|z>=<frac|1|<around*|\||z|\|>>=2> , per attirare il polo
  nell'origine, e il polo veloce <math|p=-100> con la corrispondente costante
  di tempo <math|\<tau\><rsub|p>=<frac|1|<around*|\||p|\|>>=<frac|1|100>>.
  Quindi la seconda azione di controllo è la seguente:

  <\eqnarray>
    <tformat|<table|<row|<cell|C<rsub|2><around*|(|s|)>>|<cell|=>|<cell|<frac|<around*|(|1+\<tau\><rsub|z>*s|)>|<around*|(|1+\<tau\><rsub|p>*s|)>>>>>>
  </eqnarray>

  In particolare se aggiungiamo le seguenti righe al codice Matlab:

  <\r-code>
    z = -0.5;

    tau_z = 1 / abs(z);

    \;

    p = -100;

    tau_p = 1 / abs(p);

    C2 = (1 + tau_z * s) / (1 + tau_p * s);

    \;

    figure;

    rlocus(-1 * C1 * C2);
  </r-code>

  otteniamo il seguente luogo delle radici:

  <big-figure|<tabular|<tformat|<cwith|1|-1|1|-1|cell-halign|c>|<cwith|1|-1|1|-1|cell-valign|c>|<table|<row|<cell|<image|images/root-locus-c2.png|0.4par|||>>|<cell|<image|images/root-locus-c2-zoom.png|0.4par|||>>>>>>|>

  e se utilizziamo la lente d'ingrandimento, direttamente da Matlab, notiamo
  anche la presenza del piccolo zero <math|z=-0.5>. Inoltre osservando la
  riga di codice utilizzata per disegnare il luogo delle radici, possiamo
  notare la presenza di un <cpp|-1> che moltiplica le azioni di controllo
  <math|C<rsub|1><around*|(|s|)>> e <math|C<rsub|2><around*|(|s|)>>. Questo è
  fondamentale<\footnote>
    Evitando tale passeggio si disegna un luogo delle radici errato per il
    nostro contesto!
  </footnote> perchè il disegno del luogo delle radici cambia in base al
  valore della costante di guadagno <math|K> e poichè nell'azione di
  controllo <math|C<rsub|1><around*|(|s|)>> la costante di guadagno
  <math|K=-1\<less\>0> per visualizzare il grafico corretto dobbiamo
  semplicemente invertire tale valore moltiplicandolo per <cpp|-1>.

  Arrivati a questo punto accade spesso che il sistema retroazionato,
  descritto dalla funzione di sensitività complementare <math|W<rsub|y
  r><around*|(|s|)>>, sia instabile oppure sia stabile ma con bassi margini
  di stabilità e quindi transitori iniziali insoddisfacenti. In questo caso
  usando le seguenti righe di codice:

  <\octave-code>
    C = C1 * C2;

    \;

    figure;

    nyquist(C * P);

    pole(C * P)

    \;

    figure;

    margin(C * P);

    grid on;
  </octave-code>

  otteniamo i seguenti diagrammi:

  <big-figure|<tabular|<tformat|<cwith|1|1|1|-1|cell-halign|c>|<cwith|1|1|1|-1|cell-valign|c>|<table|<row|<cell|<image|images/nyquist-c.png|0.4par|||>>|<cell|<image|images/bode-c.png|0.4par|||>>>>>>|Diagramma
  di Nyquist per un sistema di tipo <math|h=2>>

  che è la prova dell'instabilità nel sistema retroazionato. Per esempio,
  applicando il Criterio di Nyquist, ed in particolare facendo riferimento
  alla relazione <math|Z=N+P>, abbiamo che la funzione ad anello aperto
  <math|L<around*|(|s|)>=C<around*|(|s|)>*P<around*|(|s|)>> non presenta poli
  instabili pertanto <math|P=0><\footnote>
    Si può verificare facilmente utilizzando la funzione <java|pole(C * P)>.
  </footnote> e <math|Z=N>. Per la stabilità non ci devono essere giri in
  senso orario intorno al punto critico <math|-1+j 0>, tuttavia in questo
  caso <math|N=2>. Pertanto il sistema retroazionato è instabile. Per
  soddisfare i requisiti di stabilità bisogna aggiungere una rete correttrice
  <math|R<rsub|k><around*|(|s|)>> nel design del controllore, in modo da
  avere <math|C<around*|(|s|)>=<frac|K*R<rsub|k><around*|(|s|)>|s<rsup|h>>>,
  dove <math|R<rsub|k><around*|(|s|)>> ha tipicamente una struttura dinamica
  del primo o del secondo ordine:

  <\eqnarray>
    <tformat|<table|<row|<cell|R<rsub|k><around*|(|s|)>=<frac|1+\<tau\><rsub|1>*s|1+\<tau\><rsub|2>*s>>|<cell|,>|<cell|R<rsub|k><around*|(|s|)>=<frac|<around*|(|1+\<tau\><rsub|1>*s|)>*<around*|(|1+\<tau\><rsub|2>*s|)>|<around*|(|1+<frac|\<tau\><rsub|2>|\<alpha\>>*s|)>*<around*|(|1+\<alpha\>*\<tau\><rsub|1>*s|)>>,<space|1em>0\<less\>\<alpha\>\<less\>1>>>>
  </eqnarray>

  Si utilizzano tipicamente reti correttrici <math|R<rsub|k><around*|(|s|)>>
  con guadagno statico unitario tale che <math|R<rsub|k><around*|(|0|)>=1>,
  per non influire sulle specifiche di precisione precedentemente soddisfatte
  dalla scelta dei parametri <math|h> e <math|K>. Pertanto nel nostro caso
  possiamo utilizzare una rete correttrice per aumentare il margine di fase
  <math|\<mu\><rsub|\<phi\>>> (ricordando che per il Criterio di Bode la
  funzione <math|L<around*|(|s|)>> è asintoticamente stabile se
  <math|\<mu\><rsub|\<phi\>>\<gtr\>0> e <math|\<mu\><rsub|g>\<gtr\>1>), ed in
  particolare la rete correttrice che ci permette di fare ciò è la rete
  anticipatrice <math|R<rsub|a><around*|(|s|)>>, che talvolta diminuisce
  l'overshoot e il tempo di assestamento <math|t<rsub|s>>. La funzione di
  trasferimento di una rete anticipatrice è la seguente:

  <\eqnarray>
    <tformat|<table|<row|<cell|R<rsub|a><around*|(|s|)>=<frac|1+\<tau\><rsub|1>*s|1+\<tau\><rsub|2>*s>>|<cell|=>|<frac|1+\<tau\>*s|1+\<alpha\>*\<tau\>*s>>>>
  </eqnarray>

  dove <math|0\<less\>\<alpha\>\<less\>1> e
  <math|\<tau\>=\<tau\><rsub|1>\<gtr\>\<tau\><rsub|2>=\<alpha\>*\<tau\>>.
  Continua<text-dots>

  <subsection|Progettazione del controllore <math|C<around*|(|s|)>> tramite
  PID>

  \;
</body>

<\initial>
  <\collection>
    <associate|page-medium|paper>
    <associate|prog-scripts|maxima>
  </collection>
</initial>

<\references>
  <\collection>
    <associate|auto-1|<tuple|1|1|../../../../.TeXmacs/texts/scratch/no_name_8.tm>>
    <associate|auto-2|<tuple|1|1|../../../../.TeXmacs/texts/scratch/no_name_8.tm>>
    <associate|auto-3|<tuple|2|1|../../../../.TeXmacs/texts/scratch/no_name_8.tm>>
    <associate|auto-4|<tuple|2|2|../../../../.TeXmacs/texts/scratch/no_name_8.tm>>
    <associate|auto-5|<tuple|2.1|2|../../../../.TeXmacs/texts/scratch/no_name_8.tm>>
    <associate|auto-6|<tuple|1|2|../../../../.TeXmacs/texts/scratch/no_name_8.tm>>
    <associate|auto-7|<tuple|3|4|../../../../.TeXmacs/texts/scratch/no_name_8.tm>>
    <associate|auto-8|<tuple|4|4|../../../../.TeXmacs/texts/scratch/no_name_8.tm>>
    <associate|auto-9|<tuple|2.2|?|../../../../.TeXmacs/texts/scratch/no_name_8.tm>>
    <associate|footnote-1|<tuple|1|?|../../../../.TeXmacs/texts/scratch/no_name_8.tm>>
    <associate|footnote-2|<tuple|2|?|../../../../.TeXmacs/texts/scratch/no_name_8.tm>>
    <associate|footnr-1|<tuple|1|?|../../../../.TeXmacs/texts/scratch/no_name_8.tm>>
    <associate|footnr-2|<tuple|2|?|../../../../.TeXmacs/texts/scratch/no_name_8.tm>>
  </collection>
</references>

<\auxiliary>
  <\collection>
    <\associate|figure>
      <tuple|normal|<surround|<hidden-binding|<tuple>|1>||Sistema di
      controllo>|<pageref|auto-2>>

      <tuple|normal|<surround|<hidden-binding|<tuple>|2>||Diagrammi di Bode,
      Luogo delle radici, Diagramma di Nyquist>|<pageref|auto-4>>

      <tuple|normal|<surround|<hidden-binding|<tuple>|3>||>|<pageref|auto-7>>
    </associate>
    <\associate|table>
      <tuple|normal|<surround|<hidden-binding|<tuple>|1>||Tabella riassuntiva
      degli errori a regime>|<pageref|auto-6>>
    </associate>
    <\associate|toc>
      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|1<space|2spc>Testo>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-1><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|2<space|2spc>Soluzioni>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-3><vspace|0.5fn>

      <with|par-left|<quote|1tab>|2.1<space|2spc>Progettazione del
      controllore <with|mode|<quote|math>|C<around*|(|s|)>> tramite reti
      correttrici <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-5>>

      <with|par-left|<quote|1tab>|2.2<space|2spc>Progettazione del
      controllore <with|mode|<quote|math>|C<around*|(|s|)>> tramite PID
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-8>>
    </associate>
  </collection>
</auxiliary>