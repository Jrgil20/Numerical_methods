% =========================================================================
%  TEMA 1 - INTERPOLACIÓN POLINOMIAL: MÉTODO DE NEWTON
%  (Diferencias divididas - paso a paso)
% =========================================================================
%  P_n(x) = f[x0] + f[x0,x1](x-x0) + f[x0,x1,x2](x-x0)(x-x1) + ...
% =========================================================================
clear; clc;

PASO_A_PASO = false;   % <-- pon true para pausar entre pasos

% --- DATOS (editar para el examen) ---------------------------------------
x  = [1; 2; 4; 5];          % nodos (deben ser distintos)
y  = [0; 7; 63; 124];       % f(x) en cada nodo
xq = 3;                     % punto donde queremos estimar f(xq)
% -------------------------------------------------------------------------

x = x(:); y = y(:);
n = numel(x);

fprintf('\n');
fprintf('╔═══════════════════════════════════════════════════════════════════╗\n');
fprintf('║      INTERPOLACIÓN DE NEWTON  -  DIFERENCIAS DIVIDIDAS            ║\n');
fprintf('╚═══════════════════════════════════════════════════════════════════╝\n\n');

fprintf('Nodos dados (n = %d puntos):\n', n);
for i = 1:n
    fprintf('   x%d = %8.4f     f(x%d) = %10.4f\n', i-1, x(i), i-1, y(i));
end
fprintf('\nQueremos estimar f(%.4f)\n\n', xq);
pausa(PASO_A_PASO);

% --- PASO 1: Tabla de diferencias divididas ------------------------------
fprintf('═══ PASO 1: Tabla de diferencias divididas ═══\n\n');
D = zeros(n, n);
D(:,1) = y;                          % columna 0 = f[xi]
for j = 2:n
    for i = 1:(n-j+1)
        D(i,j) = (D(i+1,j-1) - D(i,j-1)) / (x(i+j-1) - x(i));
        fprintf('  f[x%d..x%d] = (%.4f - %.4f) / (%.4f - %.4f) = %.6f\n', ...
                i-1, i+j-2, D(i+1,j-1), D(i,j-1), x(i+j-1), x(i), D(i,j));
    end
    fprintf('\n');
end
pausa(PASO_A_PASO);

% Mostrar tabla triangular
fprintf('Tabla completa (cada columna = orden de diferencia):\n');
fprintf('   xi    |');
for j = 1:n, fprintf('   orden %d   ', j-1); end
fprintf('\n');
for i = 1:n
    fprintf(' %7.3f |', x(i));
    for j = 1:(n-i+1)
        fprintf(' %10.5f ', D(i,j));
    end
    fprintf('\n');
end
fprintf('\n');
pausa(PASO_A_PASO);

% --- PASO 2: Coeficientes (diagonal superior) ----------------------------
fprintf('═══ PASO 2: Coeficientes del polinomio (b_k = f[x0..xk]) ═══\n\n');
b = D(1, :);
for k = 1:n
    fprintf('   b%d = %12.6f\n', k-1, b(k));
end
fprintf('\n');
pausa(PASO_A_PASO);

% --- PASO 3: Construir y evaluar P_n(xq) ---------------------------------
fprintf('═══ PASO 3: Evaluación de P_n(%.4f) ═══\n\n', xq);
Pq   = b(1);
prod = 1;
fprintf('   término 0: b0 = %.6f\n', b(1));
for k = 2:n
    prod = prod * (xq - x(k-1));
    term = b(k) * prod;
    Pq   = Pq + term;
    fprintf('   término %d: b%d * Π(xq-xj) = %.6f * %.6f = %.6f\n', ...
            k-1, k-1, b(k), prod, term);
end
fprintf('\n   >> P_n(%.4f) = %.6f\n\n', xq, Pq);
pausa(PASO_A_PASO);

% --- VERIFICACIÓN con comandos nativos -----------------------------------
fprintf('═══ VERIFICACIÓN (Octave nativo) ═══\n\n');
p_fit = polyfit(x, y, n-1);            % polinomio que pasa por todos los nodos
Pq_fit = polyval(p_fit, xq);
fprintf('   polyfit/polyval  -> P(%.4f) = %.6f\n', xq, Pq_fit);
fprintf('   interp1 (spline) -> f(%.4f) = %.6f\n', xq, interp1(x, y, xq, 'spline'));
fprintf('   diferencia |manual - polyfit| = %.2e\n\n', abs(Pq - Pq_fit));

% --- GRÁFICA -------------------------------------------------------------
xx = linspace(min(x)-0.5, max(x)+0.5, 300);
% Evaluar el polinomio de Newton en toda la malla (forma de Horner anidada)
yy = b(n) * ones(size(xx));
for k = n-1:-1:1
    yy = yy .* (xx - x(k)) + b(k);
end
figure;
plot(xx, yy, 'b-', 'LineWidth', 2); hold on;
plot(x, y, 'ro', 'MarkerSize', 9, 'MarkerFaceColor', 'r');
plot(xq, Pq, 'ks', 'MarkerSize', 11, 'MarkerFaceColor', 'g');
grid on; xlabel('x'); ylabel('P_n(x)');
title('Interpolación de Newton');
legend('P_n(x)', 'nodos', sprintf('estimado en x=%.2f', xq), 'Location', 'NorthWest');

fprintf('Gráfica generada. Fin del Tema 1 (Newton).\n\n');
