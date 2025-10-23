function raiz = biseccion(f,a,b,tol)
  %f es la función a evaluar
  %a es el extremo inferior del intervalo, b es el extremo superior
  %tol es la tolerancia

  if f(a)*f(b) > 0
    error('f(a) y f(b) deben tener signos opuestos');
  endif

  printf("Iteración\t\t a\t b\t c\t f(a)\t f(b)\t error\n");
  i = 0; %iteraciones
  c = 0; %punto medio entre a y b
  e = (b-a)/2; %criterio de paro (error)
  while e > tol

    c = (a+b)/2;

    %Para ver una cantidad específica de decimales, se cambia el nmero al lado de la f
    printf("%d\t %.3f\t %.3f\t %.3f\t %.3f\t %.3f\t %.3f\n", i, a, b, c, f(a), f(b), e);

    if f(c) == 0
      break;
    elseif f(a)*f(c)<0
      b = c;
    else
      a = c;
    endif
    i+=1;
    e = (b-a)/2;
  endwhile

  raiz = round(c*10^3)/10^3; %colocar 10^(n decimales que se desean ver)
endfunction
