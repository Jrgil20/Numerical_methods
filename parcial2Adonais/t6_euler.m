% =========================================================================
%  TEMA 6 - ECUACIONES DIFERENCIALES (EDO): MÉTODO DE EULER
% =========================================================================
%  PVI:  y' = f(t, y),   y(t0) = y0
%  Euler:  y_{i+1} = y_i + h · f(t_i, y_i)
% =========================================================================
clear; clc;

PASO_A_PASO = false;   % <-- pon true para pausar entre pasos

% --- DATOS (editar para el examen) ---------------------------------------
f      = @(t, y) y - t.^2 + 1;          % y' = f(t,y)
t0     = 0;                             % tiempo inicial
y0     = 0.5;                           % condición inicial
tf     = 2;                             % tiempo final
h      = 0.2;                           % paso
y_exac = @(t) (t+1).^2 - 0.5*exp(t);    % solución exacta (opcional)
% -------------------------------------------------------------------------

fprintf('\n');
fprintf('╔═══════════════════════════════════════════════════════════════════╗\n');
fprintf('║                MÉTODO DE EULER (EDO)  -  PASO A PASO           ║\n');
fprintf('╚═══════════════════════════════════════════════════════════════════╝\n\n');

fprintf("PVI:  y' = y - t^2 + 1,   y(%.1f) = %.3f\n", t0, y0);
fprintf('Intervalo [%.1f, %.1f] con paso h = %.3f\n\n', t0, tf, h);

% --- PASO 1: malla de tiempos --------------------------------------------
fprintf('═══ PASO 1: Malla de tiempos ═══\n\n');
t = t0:h:tf;
N = numel(t);
fprintf('   N = %d puntos:  t = [', N);
fprintf(' %.2f', t); fprintf(' ]\n\n');
pausa(PASO_A_PASO);

% --- PASO 2: iteración de Euler ------------------------------------------
fprintf('═══ PASO 2: Iteración  y_{i+1} = y_i + h·f(t_i, y_i) ═══\n\n');
y = zeros(1, N);
y(1) = y0;
fprintf('   %3s  %8s  %12s  %12s  %14s\n', 'i', 't_i', 'y_i', 'f(t_i,y_i)', 'y_{i+1}');
for i = 1:N-1
    fi = f(t(i), y(i));
    y(i+1) = y(i) + h*fi;
    fprintf('   %3d  %8.3f  %12.6f  %12.6f  %14.6f\n', i-1, t(i), y(i), fi, y(i+1));
end
fprintf('\n');
pausa(PASO_A_PASO);

% --- PASO 3: tabla con error ---------------------------------------------
fprintf('═══ PASO 3: Comparación con la solución exacta ═══\n\n');
fprintf('   %3s  %8s  %14s  %14s  %12s\n', 'i', 't_i', 'y Euler', 'y exacta', '|error|');
for i = 1:N
    ye = y_exac(t(i));
    fprintf('   %3d  %8.3f  %14.6f  %14.6f  %12.2e\n', ...
            i-1, t(i), y(i), ye, abs(y(i)-ye));
end
fprintf('\n   Error final |y_N - y_exacta| = %.4e\n\n', abs(y(end)-y_exac(tf)));
pausa(PASO_A_PASO);

% --- VERIFICACIÓN --------------------------------------------------------
fprintf('═══ VERIFICACIÓN (Octave nativo: lsode) ═══\n\n');
fode = @(y, t) f(t, y);            % lsode espera f(y,t)
y_lsode = lsode(fode, y0, t);
fprintf('   y(tf) lsode = %.6f   (dif con Euler = %.4e)\n\n', ...
        y_lsode(end), abs(y(end)-y_lsode(end)));

% --- GRÁFICA -------------------------------------------------------------
tt = linspace(t0, tf, 300);
figure;
plot(tt, y_exac(tt), 'k-',  'LineWidth', 2); hold on;
plot(t,  y,          'bo-', 'LineWidth', 1.5, 'MarkerFaceColor', 'b');
plot(t,  y_lsode,    'r.--');
grid on; xlabel('t'); ylabel('y');
title(sprintf('Euler (h=%.2f) vs solución exacta', h));
legend('exacta', 'Euler', 'lsode', 'Location', 'NorthWest');

fprintf('Gráfica generada. Fin del Tema 6 (Euler).\n\n');
