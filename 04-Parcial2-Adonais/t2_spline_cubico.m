% =========================================================================
%  TEMA 2 - TRAZADORES CÚBICOS (SPLINE NATURAL)  -  paso a paso
% =========================================================================
%  En cada tramo:  S_i(x) = a_i + b_i(x-x_i) + c_i(x-x_i)^2 + d_i(x-x_i)^3
%  Continuidad de S, S' y S''  ->  sistema tridiagonal en las c_i (2da deriv)
%  Spline NATURAL:  S''(x0) = S''(xn) = 0
% =========================================================================
clear; clc;

PASO_A_PASO = false;   % <-- pon true para pausar entre pasos

% --- DATOS (editar para el examen) ---------------------------------------
x  = [1; 2; 3; 4];
y  = [1; 4; 1; 5];
xq = 2.5;               % punto a estimar
% -------------------------------------------------------------------------

x = x(:); y = y(:);
n = numel(x);           % nº de nodos
m = n - 1;              % nº de tramos

fprintf('\n');
fprintf('╔═══════════════════════════════════════════════════════════════════╗\n');
fprintf('║            TRAZADOR CÚBICO NATURAL  -  PASO A PASO              ║\n');
fprintf('╚═══════════════════════════════════════════════════════════════════╝\n\n');

fprintf('Nodos (%d puntos, %d tramos):\n', n, m);
for i = 1:n
    fprintf('   x%d = %7.3f   y%d = %7.3f\n', i, x(i), i, y(i));
end
fprintf('\n');

% --- PASO 1: anchos h_i --------------------------------------------------
fprintf('═══ PASO 1: Anchos de cada tramo h_i = x_{i+1}-x_i ═══\n\n');
h = diff(x);
for i = 1:m
    fprintf('   h%d = %.4f - %.4f = %.4f\n', i, x(i+1), x(i), h(i));
end
fprintf('\n');
pausa(PASO_A_PASO);

% --- PASO 2: sistema tridiagonal A c = r ---------------------------------
fprintf('═══ PASO 2: Sistema tridiagonal para las segundas derivadas (c) ═══\n\n');
A = zeros(n, n);
r = zeros(n, 1);
A(1,1)   = 1;           % condición natural S''(x0)=0
A(n,n)   = 1;           % condición natural S''(xn)=0
for i = 2:n-1
    A(i,i-1) = h(i-1);
    A(i,i)   = 2*(h(i-1) + h(i));
    A(i,i+1) = h(i);
    r(i)     = 3*((y(i+1)-y(i))/h(i) - (y(i)-y(i-1))/h(i-1));
    fprintf('   fila %d:  %.3f·c%d + %.3f·c%d + %.3f·c%d = %.4f\n', ...
            i, h(i-1), i-1, 2*(h(i-1)+h(i)), i, h(i), i+1, r(i));
end
fprintf('\n   (filas 1 y %d: c1 = 0 y c%d = 0  -> spline natural)\n\n', n, n);
disp('   Matriz A ='); disp(A);
disp('   Vector r ='); disp(r');
pausa(PASO_A_PASO);

% --- PASO 3: resolver con backslash --------------------------------------
fprintf('═══ PASO 3: Resolver  A c = r  (c = A\\r) ═══\n\n');
c = A \ r;
for i = 1:n
    fprintf('   c%d = %.6f\n', i, c(i));
end
fprintf('\n');
pausa(PASO_A_PASO);

% --- PASO 4: coeficientes a,b,d de cada tramo ----------------------------
fprintf('═══ PASO 4: Coeficientes de cada tramo S_i ═══\n\n');
a = y(1:m);
b = zeros(m,1); d = zeros(m,1);
for i = 1:m
    b(i) = (y(i+1)-y(i))/h(i) - h(i)*(2*c(i)+c(i+1))/3;
    d(i) = (c(i+1)-c(i))/(3*h(i));
end
fprintf('   tramo | a_i      b_i       c_i       d_i      (válido en [x_i,x_{i+1}])\n');
for i = 1:m
    fprintf('   %4d  | %8.4f %8.4f %8.4f %8.4f   [%.2f, %.2f]\n', ...
            i, a(i), b(i), c(i), d(i), x(i), x(i+1));
end
fprintf('\n');
pausa(PASO_A_PASO);

% --- PASO 5: evaluar S(xq) -----------------------------------------------
fprintf('═══ PASO 5: Evaluación de S(%.4f) ═══\n\n', xq);
k = find(xq >= x(1:m) & xq <= x(2:n), 1);
if isempty(k), k = m; end
dx  = xq - x(k);
Sq  = a(k) + b(k)*dx + c(k)*dx^2 + d(k)*dx^3;
fprintf('   xq está en el tramo %d  [%.2f, %.2f],  dx = xq-x%d = %.4f\n', ...
        k, x(k), x(k+1), k, dx);
fprintf('   S(xq) = %.4f + %.4f·%.4f + %.4f·%.4f² + %.4f·%.4f³\n', ...
        a(k), b(k), dx, c(k), dx, d(k), dx);
fprintf('   >> S(%.4f) = %.6f\n\n', xq, Sq);
pausa(PASO_A_PASO);

% --- VERIFICACIÓN --------------------------------------------------------
fprintf('═══ VERIFICACIÓN (Octave nativo: spline) ═══\n\n');
Sq_native = spline(x, y, xq);
fprintf('   spline(x,y,xq) = %.6f\n', Sq_native);
fprintf('   (Nota: spline() usa condición "not-a-knot", no natural,\n');
fprintf('    por eso puede diferir ligeramente del spline natural manual)\n\n');

% --- GRÁFICA -------------------------------------------------------------
xx = linspace(x(1), x(n), 400);
yy = zeros(size(xx));
for t = 1:numel(xx)
    kk = find(xx(t) >= x(1:m) & xx(t) <= x(2:n), 1);
    if isempty(kk), kk = m; end
    dxx = xx(t) - x(kk);
    yy(t) = a(kk) + b(kk)*dxx + c(kk)*dxx^2 + d(kk)*dxx^3;
end
figure;
plot(xx, yy, 'b-', 'LineWidth', 2); hold on;
plot(xx, spline(x, y, xx), 'r--', 'LineWidth', 1.2);
plot(x, y, 'ko', 'MarkerSize', 9, 'MarkerFaceColor', 'k');
plot(xq, Sq, 'gs', 'MarkerSize', 11, 'MarkerFaceColor', 'g');
grid on; xlabel('x'); ylabel('S(x)');
title('Trazador cúbico natural (manual) vs spline() nativo');
legend('Spline natural (manual)', 'spline() nativo', 'nodos', ...
       sprintf('S(%.2f)', xq), 'Location', 'NorthWest');

fprintf('Gráfica generada. Fin del Tema 2 (Spline cúbico).\n\n');
