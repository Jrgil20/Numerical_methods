function x = gauss_jordan(A, b, verbose)
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

  % Eliminación de Gauss-Jordan
  for i = 1:n
    % Buscar el máximo en la columna i (pivote parcial)
    [~, maxIndexRel] = max(abs(Ab(i:n, i)));
    maxIndex = maxIndexRel + i - 1;

    % Intercambiar filas si es necesario
    if (i ~= maxIndex)
      if verbose
        fprintf('Intercambiando fila %d con fila %d (pivote máximo)\n', i, maxIndex);
      endif
      Ab([i, maxIndex], :) = Ab([maxIndex, i], :);
      if verbose
        disp(Ab);
      endif
    endif

    % Comprobar pivote no nulo
    pivot = Ab(i, i);
    if pivot == 0
      error('Pivote nulo en fila %d. Sistema singular o necesita reordenamiento.', i);
    endif

    % Hacer el elemento diagonal 1 (normalizar fila pivote)
    Ab(i, :) = Ab(i, :) / pivot;
    if verbose
      fprintf('Dividiendo fila %d por %g para obtener pivote 1\n', i, pivot);
      disp(Ab);
    endif

    % Eliminar en las demás filas
    for j = 1:n
      if i ~= j
        factor = Ab(j, i);
        if factor ~= 0
          Ab(j, :) = Ab(j, :) - Ab(i, :) * factor;
          if verbose
            fprintf('Eliminando elemento en fila %d, columna %d (factor = %g)\n', j, i, factor);
            disp(Ab);
          endif
        else
          if verbose
            fprintf('Fila %d ya tiene 0 en columna %d, no se hace nada\n', j, i);
          endif
        endif
      endif
    endfor
  endfor

  x = Ab(:, end);

  if verbose
    fprintf('Solución (vector x):\n');
    disp(x);
  endif
endfunction