% =========================================================================
%  TEMA 5 - INTEGRACIÓN NUMÉRICA: SIMPSON 1/3 COMPUESTA
% =========================================================================
%  I ≈ (h/3) [ f(x0) + f(xn) + 4·Σ(impares) + 2·Σ(pares) ]
%  Requiere n PAR (nº de subintervalos par).
% =========================================================================
clear; clc;

PASO_A_PASO = false;   % <-- pon true para pausar entre pasos

% --- DATOS (editar para el examen) ---------------------------------------
f = @(x) exp(x);
a = 0;
b = 1;
n = 6;                  % nº de subintervalos (DEBE ser par)
I_exacta = exp(1) - 1;
% -------------------------------------------------------------------------

fprintf('\n');
fprintf('╔═══════════════════════════════════════════════════════════════════╗\n');
fprintf('║             SIMPSON 1/3 COMPUESTA  -  PASO A PASO              ║\n');
fprintf('╚═══════════════════════════════════════════════════════════════════╝\n\n');

if mod(n,2) ~= 0
    error('Simpson 1/3 requiere n PAR. Tienes n = %d.', n);
end
fprintf('Integrar f(x)=exp(x) en [%.3f, %.3f] con n = %d (par)\n\n', a, b, n);

% --- PASO 1: h y nodos ---------------------------------------------------
fprintf('═══ PASO 1: Paso h y nodos ═══\n\n');
h = (b - a) / n;
x = a:h:b;
y = f(x);
fprintf('   h = (b-a)/n = %.6f\n\n', h);
fprintf('   %3s  %12s  %12s  %s\n', 'i', 'x_i', 'f(x_i)', 'peso');
for i = 1:numel(x)
    if i == 1 || i == numel(x), w = 1;
    elseif mod(i-1, 2) == 1,    w = 4;     % índice impar -> peso 4
    else,                       w = 2;     % índice par   -> peso 2
    end
    fprintf('   %3d  %12.6f  %12.6f   %d\n', i-1, x(i), y(i), w);
end
fprintf('\n');
pausa(PASO_A_PASO);

% --- PASO 2: sumas por paridad -------------------------------------------
fprintf('═══ PASO 2: Sumas de impares (×4) y pares (×2) ═══\n\n');
S_imp = 0; S_par = 0;
for i = 2:numel(x)-1
    if mod(i-1, 2) == 1
        S_imp = S_imp + y(i);
        fprintf('   impar  + f(x%d) = %.6f  (Σimp = %.6f)\n', i-1, y(i), S_imp);
    else
        S_par = S_par + y(i);
        fprintf('   par    + f(x%d) = %.6f  (Σpar = %.6f)\n', i-1, y(i), S_par);
    end
end
fprintf('\n   4·Σimp = %.6f      2·Σpar = %.6f\n\n', 4*S_imp, 2*S_par);
pausa(PASO_A_PASO);

% --- PASO 3: fórmula -----------------------------------------------------
fprintf('═══ PASO 3: Aplicar la fórmula ═══\n\n');
I = (h/3) * (y(1) + y(end) + 4*S_imp + 2*S_par);
fprintf('   I ≈ (h/3)[ f(x0)+f(xn) + 4Σimp + 2Σpar ]\n');
fprintf('     = (%.6f/3)[ %.6f + %.6f + %.6f + %.6f ]\n', ...
        h, y(1), y(end), 4*S_imp, 2*S_par);
fprintf('     = %.8f\n\n', I);
pausa(PASO_A_PASO);

% --- PASO 4: error -------------------------------------------------------
fprintf('═══ PASO 4: Error ═══\n\n');
fprintf('   I exacta     = %.8f\n', I_exacta);
fprintf('   I Simpson1/3 = %.8f\n', I);
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
area(xx, f(xx), 'FaceColor', [0.8 0.9 0.8], 'EdgeColor', 'none'); hold on;
plot(xx, f(xx), 'b-', 'LineWidth', 2);
plot(x, y, 'ro', 'MarkerFaceColor', 'r');
grid on; xlabel('x'); ylabel('f(x)');
title(sprintf('Simpson 1/3 (n=%d),  I ≈ %.6f', n, I));
legend('área', 'f(x)', 'nodos', 'Location', 'NorthWest');

fprintf('Gráfica generada. Fin del Tema 5 (Simpson 1/3).\n\n');
