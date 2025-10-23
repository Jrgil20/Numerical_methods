function x = gauss_jordan(A, b)
  %A es la matriz nxn, b es el vector columna 1xn (A=b)

  [n, m] = size(A);
  Ab = [A, b]; % Concatenar la matriz A y el vector b

  % Eliminación de Gauss-Jordan
  for i = 1:n
    % Buscar el máximo en la columna i
    [~, maxIndex] = max(abs(Ab(i:n, i)));
    maxIndex = maxIndex + i - 1;
    % Intercambiar filas si es necesario
    if (i ~= maxIndex)
      Ab([i, maxIndex], :) = Ab([maxIndex, i], :);
    endif
    % Hacer el elemento diagonal 1
    Ab(i,:) = Ab(i,:) / Ab(i,i);
    for j = 1:n
      if i != j
        % Hacer los otros elementos de la columna 0
        Ab(j,:) = Ab(j,:) - Ab(i,:) * Ab(j,i);
      endif
    endfor
  endfor

  x = Ab(:,end);
endfunction
