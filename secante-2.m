function resultado=secante(f,a,b,n)
  %f es la función a evaluar, a es el extremo inferior del intervalo,
  %b es el extremo superior, n es el numero de iteraciones que se desean hacer
  printf("n\t\t x_n\t\t x_(n-1)\t\t f(x_n)\t\t f(x_(n-1))\t\t x_(n+1)\n");
  i = 1;
  while i<n+1
    c=b-((f(b)*(b-a))/(f(b)-f(a)));
    printf("%d\t\t %.9f\t\t %.9f\t\t %.9f\t\t %.9f\t\t %.9f\n", i,a, b, f(a), f(b), c);
    a=b;
    b=c;
    i+=1;
  endwhile

  resultado=b;
endfunction
