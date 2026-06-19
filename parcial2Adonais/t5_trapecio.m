% =========================================================================
%  TEMA 5 - INTEGRACIÓN NUMÉRICA: REGLA DEL TRAPECIO COMPUESTA
% =========================================================================
%  I ≈ (h/2) [ f(x0) + f(xn) + 2·Σ_{i=1}^{n-1} f(x_i) ]
% =========================================================================
clear; clc;

PASO_A_PASO = false;   % <-- pon true para pausar entre pasos

% --- DATOS (editar para el examen) ---------------------------------------
f = @(x) exp(x);            % integrando
a = 0;                      % límite inferior
b = 1;                      % límite superior
n = 6;                      % nº de subintervalos
I_exacta = exp(1) - 1;      % valor exacto (opcional, para el error)
% -------------------------------------------------------------------------

fprintf('\n');
fprintf('╔═══════════════════════════════════════════════════════════════════╗\n');
fprintf('║            REGLA DEL TRAPECIO COMPUESTA  -  PASO A PASO         ║\n');
fprintf('╚═══════════════════════════════════════════════════════════════════╝\n\n');

fprintf('Integrar f(x)=exp(x) en [%.3f, %.3f] con n = %d subintervalos\n\n', a, b, n);

% --- PASO 1: paso h y nodos ----------------------------------------------
fprintf('═══ PASO 1: Paso h y nodos x_i ═══\n\n');
h = (b - a) / n;
x = a:h:b;
y = f(x);
fprintf('   h = (b-a)/n = (%.3f-%.3f)/%d = %.6f\n\n', b, a, n, h);
fprintf('   %3s  %12s  %12s\n', 'i', 'x_i', 'f(x_i)');
for i = 1:numel(x)
    fprintf('   %3d  %12.6f  %12.6f\n', i-1, x(i), y(i));
end
fprintf('\n');
pausa(PASO_A_PASO);

% --- PASO 2: suma de los términos interiores -----------------------------
fprintf('═══ PASO 2: Suma de términos interiores (×2) ═══\n\n');
S_int = 0;
for i = 2:numel(x)-1
    S_int = S_int + y(i);
    fprintf('   + f(x%d) = %.6f   (acumulado interior = %.6f)\n', i-1, y(i), S_int);
end
fprintf('\n   Σ interiores = %.6f   ->  2·Σ = %.6f\n\n', S_int, 2*S_int);
pausa(PASO_A_PASO);

% --- PASO 3: fórmula -----------------------------------------------------
fprintf('═══ PASO 3: Aplicar la fórmula ═══\n\n');
I = (h/2) * (y(1) + y(end) + 2*S_int);
fprintf('   I ≈ (h/2)[ f(x0) + f(xn) + 2·Σ ]\n');
fprintf('     = (%.6f/2)[ %.6f + %.6f + %.6f ]\n', h, y(1), y(end), 2*S_int);
fprintf('     = %.8f\n\n', I);
pausa(PASO_A_PASO);

% --- PASO 4: error -------------------------------------------------------
fprintf('═══ PASO 4: Error ═══\n\n');
fprintf('   I exacta    = %.8f\n', I_exacta);
fprintf('   I trapecio  = %.8f\n', I);
fprintf('   |error|     = %.2e\n\n', abs(I - I_exacta));
pausa(PASO_A_PASO);

% --- VERIFICACIÓN --------------------------------------------------------
fprintf('═══ VERIFICACIÓN (Octave nativo: trapz) ═══\n\n');
I_trapz = trapz(x, y);
fprintf('   trapz(x,y) = %.8f   (dif con manual = %.2e)\n\n', ...
        I_trapz, abs(I - I_trapz));

% --- GRÁFICA -------------------------------------------------------------
xx = linspace(a, b, 300);
figure;
plot(xx, f(xx), 'b-', 'LineWidth', 2); hold on;
for i = 1:numel(x)-1
    patch([x(i) x(i+1) x(i+1) x(i)], [0 0 y(i+1) y(i)], ...
          [0.7 0.85 1], 'EdgeColor', [0.2 0.4 0.8]);
end
plot(xx, f(xx), 'b-', 'LineWidth', 2);
plot(x, y, 'ro', 'MarkerFaceColor', 'r');
grid on; xlabel('x'); ylabel('f(x)');
title(sprintf('Trapecio compuesta (n=%d),  I ≈ %.6f', n, I));
legend('f(x)', 'trapecios', 'Location', 'NorthWest');

fprintf('Gráfica generada. Fin del Tema 5 (Trapecio).\n\n');
