% ==========================================
%  TRAPECIO COMPUESTO UNIVERSAL
% ==========================================

% --- 1. CONFIGURACIÓN (EDITA AQUÍ) ---
% Ejemplo: Ejercicio 1.c de la Pag 4 [cite: 820]
% Integral de sqrt(ln(x)) desde 1 hasta 4 con n=12
f = @(x) sqrt(log(x));   % Recuerda: ln es log() en Octave
a = 1;                   % Límite inferior
b = 4;                   % Límite superior
n = 12;                  % Número de tramos

% --- 2. MOTOR DE CÁLCULO (NO TOCAR) ---
h = (b - a) / n;         % Calculamos el paso
x = a:h:b;               % Generamos vector X
y = f(x);                % Evaluamos vector Y (¡Gracias a los puntos!)

% Fórmula del Trapecio: h/2 * (Extremos + 2*Intermedios)
primero = y(1);
ultimo  = y(end);
intermedios = y(2:end-1);

Area = (h/2) * (primero + ultimo + 2 * sum(intermedios));

% --- 3. RESULTADOS ---
fprintf('---------------------------------\n');
fprintf('Integral de %g a %g con n=%d\n', a, b, n);
fprintf('Paso (h) calculado: %.6f\n', h);
fprintf('Resultado Aproximado: %.6f\n', Area);
fprintf('---------------------------------\n');