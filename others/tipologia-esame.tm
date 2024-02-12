<TeXmacs|2.1>

<style|generic>

<\body>
  <section|Tipologia Esame>

  <\eqnarray>
    <tformat|<table|<row|<cell|P<around*|(|s|)>>|<cell|=>|<cell|<frac|10*<around*|(|s-1|)>|s<rsup|2>+4*s+8>>>>>
  </eqnarray>

  <\enumerate>
    <item>Errore a regime <math|e<rsub|ss>\<leqslant\>10%> per riferimento a
    rampa.

    Abbiamo <math|R<around*|(|s|)>=<frac|R<rsub|0>|s<rsup|2>>> e
    <math|E<around*|(|s|)>=<frac|1|1+P<around*|(|s|)>>R<around*|(|s|)>=<frac|<around*|(|s<rsup|2>+4*s+8|)>*R<rsub|0>|s<rsup|4>+14*s<rsup|3>-2*s<rsup|2>>>
    da cui segue:

    <\eqnarray>
      <tformat|<table|<row|<cell|e<rsub|ss>=lim<rsub|s\<rightarrow\>0>s*E<around*|(|s|)>=lim<rsub|s\<rightarrow\>0>*<frac|s*<around*|(|s<rsup|2>+4*s+8|)>*R<rsub|0>|s<rsup|4>+14*s<rsup|3>-2*s<rsup|2>>>|<cell|=>|<cell|\<infty\>>>>>
    </eqnarray>

    poichè infatti <math|P<around*|(|s|)>> è un sistema di tipo 0.
    Aggiungendo un polo nell'origine otteniamo <math|W<rsub|e<rsub|true>
    r><around*|(|s|)>=<frac|1|1+P<around*|(|s|)>>*R<around*|(|s|)>=<frac|1|1+<frac|10*<around*|(|s-1|)>|s*<around*|(|s<rsup|2>+4*s+8|)>>>*<frac|R<rsub|0>|s<rsup|2>>=<frac|R<rsub|0>*<around*|(|s<rsup|2>+4*s+8|)>|s*<around*|(|s<rsup|3>+4*s<rsup|2>+18*s-10|)>>>
    da cui segue:

    <\eqnarray>
      <tformat|<table|<row|<cell|e<rsub|ss>=lim<rsub|s\<rightarrow\>0>s*W<rsub|e<rsub|true>
      r><around*|(|s|)>*<frac|R<rsub|0>|s<rsup|q>>>|<cell|\<approx\>>|<cell|lim<rsub|s\<rightarrow\>0>*<frac|R<rsub|0>|s<rsup|q-1>+K<rsub|P>*K<rsub|C>>=<frac|R<rsub|0>|K<rsub|P>*K<rsub|C>>>>>>
    </eqnarray>

    valida solo se <math|\<rho\><rsub|P>+\<rho\><rsub|C>-q+1=0>, dove
    <math|\<rho\><rsub|P>> è il numero di poli in zero di
    <math|P<around*|(|s|)>>, <math|\<rho\><rsub|C>> è il numero di poli in
    zero di <math|C<around*|(|s|)>>. In questo caso <math|\<rho\><rsub|P>=1>
    perchè la <math|P<around*|(|s|)>> è di tipo 1, <math|\<rho\><rsub|C>=0> e
    <math|q=2> pertanto <math|\<rho\><rsub|P>+\<rho\><rsub|C>-q+1=0>.
    Ottenere un errore a regime <math|e<rsub|ss>\<leqslant\>10%> si traduce
    nella seguente relazione:

    <\eqnarray>
      <tformat|<table|<row|<cell|<around*|\||e<rsub|ss>|\|>\<leqslant\><around*|\||0.1*R<rsub|0>|\|>\<Longrightarrow\><frac|<neg|<around*|\||R<rsub|0>|\|>>|*<around*|\||K<rsub|P>*K<rsub|C>|\|>>\<leqslant\>0.1*<neg|<around*|\||R<rsub|0>|\|>>>|<cell|\<Longrightarrow\>>|<cell|<around*|\||K<rsub|C>|\|>\<geqslant\><frac|1|0.1*<around*|\||K<rsub|P>|\|>>>>>>
    </eqnarray>

    dove <math|K<rsub|P>> è il guadagno della <math|P<around*|(|s|)>> in
    forma standard, ottenibile tramite il comando <cpp|dcgain(P)>. Nel nostro
    caso il guadagno <math|K<rsub|P>=-1.25> pertanto
    <math|<around*|\||K<rsub|C>|\|>\<geqslant\>8>. Tuttavia in questo caso il
    vincolo sull'errore a regime richiede un guadagno ad anello
    <math|L<around*|(|s|)>=C<around*|(|s|)>*P<around*|(|s|)>=<frac|80*<around*|(|s-1|)>|s<rsup|2>+4*s+8>>
    che rende difficile la stabilizzazione del sistema, per via dell'elevato
    valore di guadagno <math|K<rsub|L>=80>. Pertanto possiamo ottenere un
    errore <math|e<rsub|ss>=0> aggiungendo un doppio polo nell'origine (cioè
    <math|h=2> integratori). Quindi:

    <\eqnarray>
      <tformat|<table|<row|<cell|C<around*|(|s|)>>|<cell|=>|<cell|<frac|1|s<rsup|2>>>>>>
    </eqnarray>

    <item>Overshoot minore del <math|20%>

    <item>Controllore digitale <math|C<around*|(|z|)>> (discretizzazione)

    <item>Delineare il design di un controllore per controllare
    asintoticamente un disturbo <math|d<rsub|2>=10*sin<around*|(|50\<cdot\>2\<pi\>|)>>

    <item>Dimostrazione del Criterio di Nyquist (oppure altra roba di teoria)

    <item>Design del controllore <math|C<around*|(|s|)>> con la presenza di
    un ritardo <math|e<rsup|-0.05*s>>
  </enumerate>
</body>

<\initial>
  <\collection>
    <associate|page-medium|paper>
    <associate|prog-scripts|maxima>
  </collection>
</initial>

<\references>
  <\collection>
    <associate|auto-1|<tuple|1|1>>
    <associate|auto-2|<tuple|2|1>>
  </collection>
</references>

<\auxiliary>
  <\collection>
    <\associate|toc>
      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|1<space|2spc>Tipologia
      Esame> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-1><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|2<space|2spc>Test>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-2><vspace|0.5fn>
    </associate>
  </collection>
</auxiliary>