% =========================================================================
%  TEMA 5 - INTEGRACIÓN NUMÉRICA: SIMPSON 3/8 COMPUESTA
% =========================================================================
%  I ≈ (3h/8) [ f(x0) + f(xn) + 3·Σ(no múltiplos de 3) + 2·Σ(múltiplos de 3) ]
%  Requiere n múltiplo de 3.
% =========================================================================
clear; clc;

PASO_A_PASO = false;   % <-- pon true para pausar entre pasos

% --- DATOS (editar para el examen) ---------------------------------------
f = @(x) exp(x);
a = 0;
b = 1;
n = 6;                  % nº de subintervalos (DEBE ser múltiplo de 3)
I_exacta = exp(1) - 1;
% -------------------------------------------------------------------------

fprintf('\n');
fprintf('╔═══════════════════════════════════════════════════════════════════╗\n');
fprintf('║             SIMPSON 3/8 COMPUESTA  -  PASO A PASO              ║\n');
fprintf('╚═══════════════════════════════════════════════════════════════════╝\n\n');

if mod(n,3) ~= 0
    error('Simpson 3/8 requiere n múltiplo de 3. Tienes n = %d.', n);
end
fprintf('Integrar f(x)=exp(x) en [%.3f, %.3f] con n = %d (múltiplo de 3)\n\n', a, b, n);

% --- PASO 1: h y nodos + pesos -------------------------------------------
fprintf('═══ PASO 1: Paso h, nodos y pesos ═══\n\n');
h = (b - a) / n;
x = a:h:b;
y = f(x);
fprintf('   h = (b-a)/n = %.6f\n\n', h);
fprintf('   %3s  %12s  %12s  %s\n', 'i', 'x_i', 'f(x_i)', 'peso');
for i = 1:numel(x)
    if i == 1 || i == numel(x),      w = 1;
    elseif mod(i-1, 3) == 0,         w = 2;   % índice múltiplo de 3 -> peso 2
    else,                            w = 3;   % resto -> peso 3
    end
    fprintf('   %3d  %12.6f  %12.6f   %d\n', i-1, x(i), y(i), w);
end
fprintf('\n');
pausa(PASO_A_PASO);

% --- PASO 2: sumas -------------------------------------------------------
fprintf('═══ PASO 2: Σ peso 3 (no múlt. de 3) y Σ peso 2 (múlt. de 3) ═══\n\n');
S3 = 0; S2 = 0;
for i = 2:numel(x)-1
    if mod(i-1, 3) == 0
        S2 = S2 + y(i);
        fprintf('   peso2  + f(x%d) = %.6f  (Σ2 = %.6f)\n', i-1, y(i), S2);
    else
        S3 = S3 + y(i);
        fprintf('   peso3  + f(x%d) = %.6f  (Σ3 = %.6f)\n', i-1, y(i), S3);
    end
end
fprintf('\n   3·Σ3 = %.6f      2·Σ2 = %.6f\n\n', 3*S3, 2*S2);
pausa(PASO_A_PASO);

% --- PASO 3: fórmula -----------------------------------------------------
fprintf('═══ PASO 3: Aplicar la fórmula ═══\n\n');
I = (3*h/8) * (y(1) + y(end) + 3*S3 + 2*S2);
fprintf('   I ≈ (3h/8)[ f(x0)+f(xn) + 3Σ3 + 2Σ2 ]\n');
fprintf('     = (3·%.6f/8)[ %.6f + %.6f + %.6f + %.6f ]\n', ...
        h, y(1), y(end), 3*S3, 2*S2);
fprintf('     = %.8f\n\n', I);
pausa(PASO_A_PASO);

% --- PASO 4: error -------------------------------------------------------
fprintf('═══ PASO 4: Error ═══\n\n');
fprintf('   I exacta     = %.8f\n', I_exacta);
fprintf('   I Simpson3/8 = %.8f\n', I);
fprintf('   |error|      = %.2e\n\n', abs(I - I_exacta));
pausa(PASO_A_PASO);

% --- VERIFICACIÓN --------------------------------------------------------
fprintf('═══ VERIFICACIÓN (Octave nativo: quad) ═══\n\n');
I_quad = quad(f, a, b);
fprintf('   quad(f,a,b) = %.8f   (dif con manual = %.2e)\n\n', ...
        I_quad, abs(I - I_quad));

% --- GRÁFICA -------------------------------------------------------------
xx = linspace(a, b, 300);
figure;
area(xx, f(xx), 'FaceColor', [0.95 0.85 0.7], 'EdgeColor', 'none'); hold on;
plot(xx, f(xx), 'b-', 'LineWidth', 2);
plot(x, y, 'ro', 'MarkerFaceColor', 'r');
grid on; xlabel('x'); ylabel('f(x)');
title(sprintf('Simpson 3/8 (n=%d),  I ≈ %.6f', n, I));
legend('área', 'f(x)', 'nodos', 'Location', 'NorthWest');

fprintf('Gráfica generada. Fin del Tema 5 (Simpson 3/8).\n\n');
