function x = gauss(A, b, verbose)
  % A es la matriz nxn, b es el vector columna nx1
  % verbose (opcional): 1 imprime pasos, 0 silencio. Por defecto 1.

  if nargin < 3
    verbose = 1;
  endif

  [n, m] = size(A);
  if n ~= m
    error('A debe ser cuadrada');
  endif

  Ab = [A, b]; % Matriz aumentada

  if verbose
    fprintf('Matriz aumentada inicial:\n');
    disp(Ab);
  endif

  % Eliminación hacia adelante con pivoteo parcial (opcional para evitar pivotes nulos)
  for i = 1:n-1
    % Pivoteo parcial: encontrar fila con mayor valor absoluto en columna i
    [~, maxRel] = max(abs(Ab(i:n, i)));
    maxIndex = maxRel + i - 1;
    if maxIndex ~= i
      if verbose
        fprintf('Intercambiando fila %d con fila %d por pivoteo parcial\n', i, maxIndex);
      endif
      Ab([i, maxIndex], :) = Ab([maxIndex, i], :);
      if verbose
        disp(Ab);
      endif
    endif

    pivot = Ab(i, i);
    if pivot == 0
      error('Pivote nulo en fila %d. Sistema singular o necesita reordenamiento.', i);
    endif

    for j = i+1:n
      factor = Ab(j,i) / pivot;
      if factor ~= 0
        Ab(j,:) = Ab(j,:) - Ab(i,:) * factor;
        if verbose
          fprintf('Eliminación: eliminando entrada en fila %d, columna %d (factor = %g)\n', j, i, factor);
          disp(Ab);
        endif
      else
        if verbose
          fprintf('No se necesita eliminación en fila %d, columna %d (ya es 0)\n', j, i);
        endif
      endif
    endfor
  endfor

  % Sustitución hacia atrás
  x = zeros(n, 1);
  for i = n:-1:1
    if Ab(i,i) == 0
      error('Pivote cero en la sustitución hacia atrás en fila %d.', i);
    endif
    x(i) = (Ab(i,end) - Ab(i,i+1:n) * x(i+1:n)) / Ab(i,i);
    if verbose
      fprintf('Calculando x(%d) = %g\n', i, x(i));
    endif
  endfor

  if verbose
    fprintf('Solución (vector x):\n');
    disp(x);
  endif
endfunction