% =========================================================================
%  TEMA 4 - DIFERENCIACIÓN NUMÉRICA  -  paso a paso
% =========================================================================
%  Adelante:   f'(x) ≈ [f(x+h) - f(x)] / h
%  Atrás:      f'(x) ≈ [f(x) - f(x-h)] / h
%  Centrada f': f'(x) ≈ [f(x+h) - f(x-h)] / (2h)
%  Centrada f'':f''(x)≈ [f(x-h) - 2f(x) + f(x+h)] / h^2
% =========================================================================
clear; clc;

PASO_A_PASO = false;   % <-- pon true para pausar entre pasos

% --- DATOS (editar para el examen) ---------------------------------------
f   = @(x) sin(x);          % función a derivar
df  = @(x) cos(x);          % derivada exacta (para comparar el error)
d2f = @(x) -sin(x);         % segunda derivada exacta
x0  = 1.0;                  % punto donde derivar
h   = 0.1;                  % paso
% -------------------------------------------------------------------------

fprintf('\n');
fprintf('╔═══════════════════════════════════════════════════════════════════╗\n');
fprintf('║              DIFERENCIACIÓN NUMÉRICA  -  PASO A PASO            ║\n');
fprintf('╚═══════════════════════════════════════════════════════════════════╝\n\n');

fprintf('Función: f(x) = sin(x)   en x0 = %.4f   con h = %.4f\n\n', x0, h);

% Valores de f necesarios
fm = f(x0 - h);  fc = f(x0);  fp = f(x0 + h);
fprintf('Valores de la función:\n');
fprintf('   f(x0-h) = f(%.4f) = %.6f\n', x0-h, fm);
fprintf('   f(x0)   = f(%.4f) = %.6f\n', x0,   fc);
fprintf('   f(x0+h) = f(%.4f) = %.6f\n\n', x0+h, fp);
pausa(PASO_A_PASO);

% --- PASO 1: Diferencia hacia adelante -----------------------------------
fprintf('═══ PASO 1: Primera derivada - hacia ADELANTE  O(h) ═══\n\n');
d_fwd = (fp - fc) / h;
fprintf('   f''(x0) ≈ [f(x0+h)-f(x0)]/h = (%.6f - %.6f)/%.4f = %.6f\n\n', ...
        fp, fc, h, d_fwd);
pausa(PASO_A_PASO);

% --- PASO 2: Diferencia hacia atrás --------------------------------------
fprintf('═══ PASO 2: Primera derivada - hacia ATRÁS  O(h) ═══\n\n');
d_bwd = (fc - fm) / h;
fprintf('   f''(x0) ≈ [f(x0)-f(x0-h)]/h = (%.6f - %.6f)/%.4f = %.6f\n\n', ...
        fc, fm, h, d_bwd);
pausa(PASO_A_PASO);

% --- PASO 3: Diferencia centrada (f') ------------------------------------
fprintf('═══ PASO 3: Primera derivada - CENTRADA  O(h^2) ═══\n\n');
d_cen = (fp - fm) / (2*h);
fprintf('   f''(x0) ≈ [f(x0+h)-f(x0-h)]/(2h) = (%.6f - %.6f)/%.4f = %.6f\n\n', ...
        fp, fm, 2*h, d_cen);
pausa(PASO_A_PASO);

% --- PASO 4: Segunda derivada centrada -----------------------------------
fprintf('═══ PASO 4: Segunda derivada - CENTRADA  O(h^2) ═══\n\n');
d2_cen = (fm - 2*fc + fp) / h^2;
fprintf('   f''''(x0) ≈ [f(x0-h)-2f(x0)+f(x0+h)]/h^2\n');
fprintf('           = (%.6f - 2·%.6f + %.6f)/%.4f² = %.6f\n\n', ...
        fm, fc, fp, h, d2_cen);
pausa(PASO_A_PASO);

% --- PASO 5: Comparación de errores --------------------------------------
fprintf('═══ PASO 5: Comparación con la derivada exacta ═══\n\n');
exact1 = df(x0);
exact2 = d2f(x0);
fprintf('   f''(x0) exacta  = %.6f\n', exact1);
fprintf('   f''''(x0) exacta = %.6f\n\n', exact2);
fprintf('   %-22s %12s %12s\n', 'Método', 'valor', '|error|');
fprintf('   %-22s %12.6f %12.2e\n', 'Adelante  (f'')',  d_fwd,  abs(d_fwd-exact1));
fprintf('   %-22s %12.6f %12.2e\n', 'Atrás     (f'')',  d_bwd,  abs(d_bwd-exact1));
fprintf('   %-22s %12.6f %12.2e\n', 'Centrada  (f'')',  d_cen,  abs(d_cen-exact1));
fprintf('   %-22s %12.6f %12.2e\n', 'Centrada  (f'''')', d2_cen, abs(d2_cen-exact2));
fprintf('\n   (la centrada O(h^2) debe tener MENOR error que adelante/atrás)\n\n');
pausa(PASO_A_PASO);

% --- VERIFICACIÓN con comandos nativos -----------------------------------
fprintf('═══ VERIFICACIÓN (Octave nativo: diff y gradient) ═══\n\n');
xs = (x0 - 5*h):h:(x0 + 5*h);
ys = f(xs);
dydx_diff = diff(ys) ./ diff(xs);           % adelante en cada nodo
g_grad    = gradient(ys, h);                % centrada interna
[~, idx]  = min(abs(xs - x0));
fprintf('   diff(y)./diff(x)  en x0 ≈ %.6f\n', dydx_diff(idx));
fprintf('   gradient(y,h)     en x0 ≈ %.6f\n\n', g_grad(idx));

% --- GRÁFICA -------------------------------------------------------------
xx = linspace(x0-3, x0+3, 300);
figure;
plot(xx, f(xx),  'b-',  'LineWidth', 2); hold on;
plot(xx, df(xx), 'r--', 'LineWidth', 1.5);
plot(x0, d_cen, 'gs', 'MarkerSize', 11, 'MarkerFaceColor', 'g');
grid on; xlabel('x'); ylabel('y');
title('f(x), su derivada exacta y la estimación centrada');
legend('f(x)', "f'(x) exacta", "f'(x0) centrada", 'Location', 'NorthWest');

fprintf('Gráfica generada. Fin del Tema 4 (Diferenciación).\n\n');
