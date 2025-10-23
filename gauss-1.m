function x = gauss(A, b)
  %A es la matriz nxn, b es el vector columna 1xn (A=b)

  [n, m] = size(A);
  Ab = [A, b]; % Concatenar la matriz A y el vector b

  % Eliminación hacia adelante
  for i = 1:n-1
    for j = i+1:n
      Ab(j,:) = Ab(j,:) - Ab(i,:) * (Ab(j,i) / Ab(i,i));
    endfor
  endfor

  % Sustitución hacia atrás
  x = zeros(n, 1);
  for i = n:-1:1
    x(i) = (Ab(i,end) - Ab(i,i+1:n) * x(i+1:n)) / Ab(i,i);
  endfor
endfunction
