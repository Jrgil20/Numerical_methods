% =========================================================================
%  TEMA 6 - EDO: EULER MEJORADO (HEUN) y RUNGE-KUTTA 4  -  paso a paso
% =========================================================================
%  Euler mejorado (Heun, predictor-corrector):
%     predictor:  y* = y_i + h·f(t_i, y_i)
%     corrector:  y_{i+1} = y_i + (h/2)[ f(t_i,y_i) + f(t_{i+1}, y*) ]
%  Runge-Kutta 4:
%     k1=f(t,y); k2=f(t+h/2,y+h/2·k1); k3=f(t+h/2,y+h/2·k2); k4=f(t+h,y+h·k3)
%     y_{i+1} = y_i + (h/6)(k1 + 2k2 + 2k3 + k4)
% =========================================================================
clear; clc;

PASO_A_PASO = false;   % <-- pon true para pausar entre pasos

% --- DATOS (editar para el examen) ---------------------------------------
f      = @(t, y) y - t.^2 + 1;
t0     = 0;  y0 = 0.5;  tf = 2;  h = 0.2;
y_exac = @(t) (t+1).^2 - 0.5*exp(t);
% -------------------------------------------------------------------------

fprintf('\n');
fprintf('╔═══════════════════════════════════════════════════════════════════╗\n');
fprintf('║        EULER MEJORADO (HEUN) y RUNGE-KUTTA 4  -  PASO A PASO    ║\n');
fprintf('╚═══════════════════════════════════════════════════════════════════╝\n\n');

fprintf("PVI:  y' = y - t^2 + 1,   y(%.1f) = %.3f,  h = %.3f\n\n", t0, y0, h);

t = t0:h:tf;
N = numel(t);

% --- PASO 1: Euler mejorado (Heun) ---------------------------------------
fprintf('═══ PASO 1: Euler mejorado (Heun) - predictor/corrector ═══\n\n');
yH = zeros(1, N); yH(1) = y0;
fprintf('   %3s  %8s  %12s  %12s  %12s  %12s\n', ...
        'i', 't_i', 'y_i', 'predictor', 'f_corr', 'y_{i+1}');
for i = 1:N-1
    f1   = f(t(i), yH(i));
    ypre = yH(i) + h*f1;                       % predictor (Euler)
    f2   = f(t(i+1), ypre);
    yH(i+1) = yH(i) + (h/2)*(f1 + f2);         % corrector
    fprintf('   %3d  %8.3f  %12.6f  %12.6f  %12.6f  %12.6f\n', ...
            i-1, t(i), yH(i), ypre, f2, yH(i+1));
end
fprintf('\n');
pausa(PASO_A_PASO);

% --- PASO 2: Runge-Kutta 4 -----------------------------------------------
fprintf('═══ PASO 2: Runge-Kutta de 4º orden (k1..k4) ═══\n\n');
yR = zeros(1, N); yR(1) = y0;
fprintf('   %3s  %8s  %10s  %10s  %10s  %10s  %12s\n', ...
        'i', 't_i', 'k1', 'k2', 'k3', 'k4', 'y_{i+1}');
for i = 1:N-1
    k1 = f(t(i),       yR(i));
    k2 = f(t(i)+h/2,   yR(i)+h/2*k1);
    k3 = f(t(i)+h/2,   yR(i)+h/2*k2);
    k4 = f(t(i)+h,     yR(i)+h*k3);
    yR(i+1) = yR(i) + (h/6)*(k1 + 2*k2 + 2*k3 + k4);
    fprintf('   %3d  %8.3f  %10.5f  %10.5f  %10.5f  %10.5f  %12.6f\n', ...
            i-1, t(i), k1, k2, k3, k4, yR(i+1));
end
fprintf('\n');
pausa(PASO_A_PASO);

% --- PASO 3: Euler simple (para comparar) --------------------------------
yE = zeros(1, N); yE(1) = y0;
for i = 1:N-1
    yE(i+1) = yE(i) + h*f(t(i), yE(i));
end

% --- PASO 4: tabla comparativa de errores --------------------------------
fprintf('═══ PASO 3: Comparación de errores en t = %.2f ═══\n\n', tf);
ye = y_exac(t);
fprintf('   %3s  %8s  %12s  %12s  %12s  %12s\n', ...
        'i', 't_i', 'Euler', 'Heun', 'RK4', 'exacta');
for i = 1:N
    fprintf('   %3d  %8.3f  %12.6f  %12.6f  %12.6f  %12.6f\n', ...
            i-1, t(i), yE(i), yH(i), yR(i), ye(i));
end
fprintf('\n   |error| final:\n');
fprintf('     Euler        = %.4e\n', abs(yE(end)-ye(end)));
fprintf('     Heun         = %.4e\n', abs(yH(end)-ye(end)));
fprintf('     Runge-Kutta4 = %.4e   <- el más preciso\n\n', abs(yR(end)-ye(end)));
pausa(PASO_A_PASO);

% --- VERIFICACIÓN --------------------------------------------------------
fprintf('═══ VERIFICACIÓN (Octave nativo: lsode) ═══\n\n');
y_lsode = lsode(@(y,t) f(t,y), y0, t);
fprintf('   y(tf) lsode = %.6f   (dif con RK4 = %.4e)\n\n', ...
        y_lsode(end), abs(yR(end)-y_lsode(end)));

% --- GRÁFICA -------------------------------------------------------------
tt = linspace(t0, tf, 300);
figure;
plot(tt, y_exac(tt), 'k-',  'LineWidth', 2); hold on;
plot(t, yE, 'ms:',  'LineWidth', 1.2, 'MarkerFaceColor', 'm');
plot(t, yH, 'bo--', 'LineWidth', 1.2, 'MarkerFaceColor', 'b');
plot(t, yR, 'g^-',  'LineWidth', 1.2, 'MarkerFaceColor', 'g');
grid on; xlabel('t'); ylabel('y');
title(sprintf('Euler vs Heun vs RK4 (h=%.2f)', h));
legend('exacta', 'Euler', 'Heun', 'RK4', 'Location', 'NorthWest');

fprintf('Gráfica generada. Fin del Tema 6 (Heun y RK4).\n\n');
