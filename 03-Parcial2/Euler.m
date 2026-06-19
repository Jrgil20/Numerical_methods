% ==========================================
% MÉTODO DE EULER SIMPLE
% Referencia: Ejemplo 1, Pag 2
% ==========================================

% 1. Configuración del Sistema
f = @(x, y) y + x^2;   % La EDO: dy/dx = f(x,y)
x0 = 0;                % Valor inicial de x
y0 = 1;                % Valor inicial de y
h = 0.1;               % Paso (Step size)
x_final = 0.3;         % Hasta dónde queremos llegar

% 2. Generación del vector de tiempo/espacio
x = x0:h:x_final;
n = length(x);
y = zeros(1, n);

% 3. Condiciones Iniciales
y(1) = y0;

% 4. Bucle Iterativo (El Motor de Euler)
fprintf('--- Iteraciones Euler Simple ---\n');
fprintf('k=0: x=%.2f, y=%.6f\n', x(1), y(1));

for k = 1:n-1
    % Fórmula: y_next = y_current + h * pendiente
    pendiente = f(x(k), y(k));
    y(k+1) = y(k) + h * pendiente;
    
    % Mostrar paso a paso (como en la tabla de la guía)
    fprintf('k=%d: x=%.2f, y=%.6f (Pendiente: %.4f)\n', ...
             k, x(k+1), y(k+1), pendiente);
end

% Comparación con valor exacto del PDF [cite: 352]
% Debería dar y(0.3) = 1.3361