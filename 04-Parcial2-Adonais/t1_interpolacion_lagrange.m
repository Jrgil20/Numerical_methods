% =========================================================================
%  TEMA 1 - INTERPOLACIÓN POLINOMIAL: MÉTODO DE LAGRANGE
%  (Bases L_i(x) paso a paso)
% =========================================================================
%  P_n(x) = Σ  y_i * L_i(x) ,   L_i(x) = Π_{j≠i} (x - x_j)/(x_i - x_j)
% =========================================================================
clear; clc;

PASO_A_PASO = false;   % <-- pon true para pausar entre pasos

% --- DATOS (editar para el examen) ---------------------------------------
x  = [1; 2; 4; 5];
y  = [0; 7; 63; 124];
xq = 3;                 % punto a estimar
% -------------------------------------------------------------------------

x = x(:); y = y(:);
n = numel(x);

fprintf('\n');
fprintf('╔═══════════════════════════════════════════════════════════════════╗\n');
fprintf('║          INTERPOLACIÓN DE LAGRANGE  -  BASES L_i(x)             ║\n');
fprintf('╚═══════════════════════════════════════════════════════════════════╝\n\n');

fprintf('Nodos dados (n = %d puntos):\n', n);
for i = 1:n
    fprintf('   x%d = %8.4f     f(x%d) = %10.4f\n', i, x(i), i, y(i));
end
fprintf('\nEstimar f(%.4f)\n\n', xq);
pausa(PASO_A_PASO);

% --- PASO 1: Calcular cada base L_i(xq) ----------------------------------
fprintf('═══ PASO 1: Evaluación de cada base de Lagrange en xq = %.4f ═══\n\n', xq);
L = zeros(n, 1);
for i = 1:n
    num = 1; den = 1;
    fprintf('   L%d(xq): ', i);
    for j = 1:n
        if j ~= i
            num = num * (xq - x(j));
            den = den * (x(i) - x(j));
            fprintf('(%.3f-%.3f)/(%.3f-%.3f) ', xq, x(j), x(i), x(j));
        end
    end
    L(i) = num / den;
    fprintf('\n          = %.6f / %.6f = %.6f\n\n', num, den, L(i));
end
pausa(PASO_A_PASO);

% Verificación de la propiedad: las bases suman 1
fprintf('   Comprobación  Σ L_i(xq) = %.6f  (debe ser 1.000000)\n\n', sum(L));
pausa(PASO_A_PASO);

% --- PASO 2: Combinar con los y_i ----------------------------------------
fprintf('═══ PASO 2: P_n(xq) = Σ y_i · L_i(xq) ═══\n\n');
Pq = 0;
for i = 1:n
    term = y(i) * L(i);
    Pq = Pq + term;
    fprintf('   y%d·L%d = %.4f · %.6f = %.6f\n', i, i, y(i), L(i), term);
end
fprintf('\n   >> P_n(%.4f) = %.6f\n\n', xq, Pq);
pausa(PASO_A_PASO);

% --- VERIFICACIÓN --------------------------------------------------------
fprintf('═══ VERIFICACIÓN (Octave nativo) ═══\n\n');
p_fit  = polyfit(x, y, n-1);
Pq_fit = polyval(p_fit, xq);
fprintf('   polyfit/polyval -> P(%.4f) = %.6f\n', xq, Pq_fit);
fprintf('   diferencia |manual - polyfit| = %.2e\n\n', abs(Pq - Pq_fit));

% --- GRÁFICA: polinomio + bases ------------------------------------------
xx = linspace(min(x)-0.5, max(x)+0.5, 300);
yy = polyval(p_fit, xx);

figure;
subplot(2,1,1);
plot(xx, yy, 'b-', 'LineWidth', 2); hold on;
plot(x, y, 'ro', 'MarkerSize', 9, 'MarkerFaceColor', 'r');
plot(xq, Pq, 'gs', 'MarkerSize', 11, 'MarkerFaceColor', 'g');
grid on; title('Interpolación de Lagrange'); ylabel('P_n(x)');
legend('P_n(x)', 'nodos', sprintf('x=%.2f', xq), 'Location', 'NorthWest');

subplot(2,1,2); hold on;
for i = 1:n
    Li = ones(size(xx));
    for j = 1:n
        if j ~= i, Li = Li .* (xx - x(j)) / (x(i) - x(j)); end
    end
    plot(xx, Li, 'LineWidth', 1.5);
end
grid on; title('Bases de Lagrange L_i(x)'); xlabel('x'); ylabel('L_i(x)');

fprintf('Gráfica generada. Fin del Tema 1 (Lagrange).\n\n');
