% =========================================================================
%  TEMA 3 - AJUSTE DE CURVAS POR MÍNIMOS CUADRADOS  -  paso a paso
% =========================================================================
%  Ecuaciones normales:  [Z]^T [Z] {A} = [Z]^T {Y}
%  Z = matriz de diseño (Vandermonde para ajuste polinomial de grado g)
% =========================================================================
clear; clc;

PASO_A_PASO = false;   % <-- pon true para pausar entre pasos

% --- DATOS (editar para el examen) ---------------------------------------
x = [1; 2; 3; 4; 5];
y = [2; 3; 5; 4; 6];
g = 1;                  % grado del polinomio de ajuste (1 = recta)
% -------------------------------------------------------------------------

x = x(:); y = y(:);
N = numel(x);

fprintf('\n');
fprintf('╔═══════════════════════════════════════════════════════════════════╗\n');
fprintf('║       AJUSTE POR MÍNIMOS CUADRADOS  -  ECUACIONES NORMALES      ║\n');
fprintf('╚═══════════════════════════════════════════════════════════════════╝\n\n');

fprintf('Datos (%d puntos), ajuste polinomial de grado %d:\n', N, g);
for i = 1:N
    fprintf('   x = %7.3f   y = %7.3f\n', x(i), y(i));
end
fprintf('\n');

% --- PASO 1: Matriz de diseño Z ------------------------------------------
fprintf('═══ PASO 1: Matriz de diseño Z (Vandermonde) ═══\n\n');
Z = zeros(N, g+1);
for p = 0:g
    Z(:, p+1) = x.^p;       % columnas: x^0, x^1, ..., x^g
end
fprintf('   Columnas = [1, x, x^2, ..., x^%d]\n', g);
disp(Z);
pausa(PASO_A_PASO);

% --- PASO 2: Sistema normal ----------------------------------------------
fprintf('═══ PASO 2: Construir el sistema normal  (Z''Z) A = Z''Y ═══\n\n');
M = Z' * Z;
B = Z' * y;
disp('   Z''Z =');  disp(M);
disp('   Z''Y =');  disp(B);
pausa(PASO_A_PASO);

% --- PASO 3: Resolver ----------------------------------------------------
fprintf('═══ PASO 3: Resolver el sistema (A = Z\\Y por backslash) ═══\n\n');
A = Z \ y;              % numéricamente más estable que (Z''Z)\(Z''Y)
for k = 0:g
    fprintf('   a%d (coef. de x^%d) = %.6f\n', k, k, A(k+1));
end
% polinomio en formato Octave (mayor a menor grado) para polyval/roots
p = flipud(A)';
fprintf('\n   Polinomio (formato Octave, mayor->menor grado):\n   p = [');
fprintf(' %.5f', p); fprintf(' ]\n\n');
pausa(PASO_A_PASO);

% --- PASO 4: Error y bondad de ajuste ------------------------------------
fprintf('═══ PASO 4: Residuos, error cuadrático y R^2 ═══\n\n');
y_pred = Z * A;
res    = y - y_pred;
Sr     = sum(res.^2);                 % suma de cuadrados de residuos
St     = sum((y - mean(y)).^2);       % suma total
R2     = 1 - Sr/St;
fprintf('   %3s  %10s  %10s  %10s\n', 'i', 'y', 'y_pred', 'residuo');
for i = 1:N
    fprintf('   %3d  %10.4f  %10.4f  %10.4f\n', i, y(i), y_pred(i), res(i));
end
fprintf('\n   Error cuadrático total  Sr = %.6f\n', Sr);
fprintf('   Coef. de determinación  R^2 = %.6f\n\n', R2);
pausa(PASO_A_PASO);

% --- VERIFICACIÓN --------------------------------------------------------
fprintf('═══ VERIFICACIÓN (Octave nativo: polyfit) ═══\n\n');
p_native = polyfit(x, y, g);
fprintf('   polyfit -> p = [');
fprintf(' %.5f', p_native); fprintf(' ]\n');
fprintf('   diferencia máx con el manual = %.2e\n\n', max(abs(p - p_native)));

% Si el ajuste cruza el eje X (raíces reales), reportarlas
rt = roots(p);
rt = rt(abs(imag(rt)) < 1e-9);
if ~isempty(rt)
    fprintf('   roots(p): el ajuste cruza el eje X en x =');
    fprintf(' %.4f', real(rt)); fprintf('\n\n');
end

% --- GRÁFICA -------------------------------------------------------------
xx = linspace(min(x)-0.5, max(x)+0.5, 200);
figure;
plot(x, y, 'ro', 'MarkerSize', 9, 'MarkerFaceColor', 'r'); hold on;
plot(xx, polyval(p, xx), 'b-', 'LineWidth', 2);
grid on; xlabel('x'); ylabel('y');
title(sprintf('Mínimos cuadrados (grado %d),  R^2 = %.4f', g, R2));
legend('datos', 'ajuste', 'Location', 'NorthWest');

fprintf('Gráfica generada. Fin del Tema 3 (Mínimos cuadrados).\n\n');
