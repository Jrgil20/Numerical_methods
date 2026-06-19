% ---------------------------------------------------------------
% SCRIPT OCTAVE: Implementación del Método de Gauss-Seidel
% ---------------------------------------------------------------

clc;        % Limpiar la ventana de comandos
clear all;  % Limpiar todas las variables

% 1. Definición del Sistema Ax = b

% Matriz de coeficientes A (Debe ser Diag. Dominante o simétrica y positiva def. para asegurar convergencia)
A = [10, -1, 2, 0;
    -1, 11, -1, 3;
     2, -1, 10, -1;
     0, 3, -1, 8];

% Vector de términos independientes b
b = [6; 25; -11; 15];

% 2. Parámetros de Iteración

n = length(b);        % Dimensión del sistema
x = zeros(n, 1);      % Vector inicial x0 (inicia en cero)
tolerancia = 1e-4;    % Tolerancia para el criterio de parada (epsilon)
max_iteraciones = 20; % Número máximo de iteraciones
k = 0;                % Contador de iteraciones
error = inf;          % Inicializar el error a infinito

fprintf('--- Método de Gauss-Seidel ---\n');
fprintf('Tolerancia: %g, Máx. Iteraciones: %d\n', tolerancia, max_iteraciones);

% 3. Bucle Principal de Iteración

while (k < max_iteraciones) && (error >= tolerancia * max(abs(x)))
    k = k + 1;
    x_prev = x; % Guardar la aproximación anterior (x^(k-1))

    % Recorrido por cada ecuación (fila i)
    for i = 1:n
        % 4. Cálculo de la Nueva Componente x_i (k)

        % Inicializar la suma de los términos no diagonales
        suma = 0;

        % Recorrido por las columnas (j) para calcular la suma
        for j = 1:n
            if i != j
                % Si j < i, x(j) ya está actualizado (se usa x^(k))
                % Si j > i, x(j) no está actualizado (se usa x^(k-1))

                if j < i
                    suma = suma + A(i, j) * x(j);       % Usa x_j actualizados (k)
                else % j > i
                    suma = suma + A(i, j) * x_prev(j);  % Usa x_j de la iteración anterior (k-1)
                endif
            endif
        end

        % Ecuación de Gauss-Seidel: x_i(k) = (b_i - suma) / A_ii
        % Una forma más limpia: x(i) = (b(i) - (A(i, 1:i-1) * x(1:i-1) + A(i, i+1:n) * x_prev(i+1:n))) / A(i, i)
        x(i) = (b(i) - suma) / A(i, i);
    end

    % 5. Cálculo del Criterio de Parada
    % Error relativo: ||x(k) - x(k-1)||_inf
    error = max(abs(x - x_prev));

    fprintf('Iteración %d: Error = %g\n', k, error);
    % disp(x'); % Descomentar para ver el vector en cada iteración
end

% 6. Mostrar Resultados Finales

fprintf('\n-----------------------------------------\n');
if error < tolerancia * max(abs(x))
    fprintf('CONVERGENCIA alcanzada en %d iteraciones.\n', k);
else
    fprintf('ADVERTENCIA: Máximo de iteraciones alcanzado (%d) sin convergencia.\n', max_iteraciones);
end

fprintf('\nVector solución aproximada (x):\n');
disp(x);
fprintf('Error final: %g\n', error);
