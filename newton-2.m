function resultado=newton(f,df,a,tol)
  %f es la funcion a evaluar, df es la derivada de f, a es el punto de partida
  %tol es la tolerancia

  b = a - (f(a)/df(a));
  c = abs(b-a);
  i = 0;
  printf("Iteración\t\t a\t\t f(a)\t\t df(a)\t\t b=a-(f(a)/df(a))\t\t |b-a|\n");
  do
    %Para ver una cantidad específica de decimales, se cambia el nmero al lado de la f
    printf("%d\t\t %.8f\t\t %.9f\t\t %.9f\t\t %.9f\t\t %.9f\n", i, a, f(a), df(a), b, c);
    a = b;
    b = a - (f(a)/df(a));
    c = abs(b-a);
    i+=1;
  until c <= tol;
  printf("%d\t\t %.17f\t\t %.17f\t\t %.17f\t\t %.17f\t\t %.17f\n", i, a, f(a), df(a), b, c);

  resultado=c;
endfunction
