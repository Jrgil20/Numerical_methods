% ==========================================
% SOLUCIONADOR DE EJERCICIOS PROPUESTOS (Pág 4)
% Selecciona el ejercicio descomentando las líneas
% ==========================================

% --- EJERCICIO 1 [cite: 403] ---
% f = @(x, y) x + y^2;
% x0 = 0; y0 = 0; h = 0.1; x_final = 0.5;

% --- EJERCICIO 2 [cite: 404] ---
% f = @(x, y) x^2 + y^2;
% x0 = 0; y0 = 1; h = 0.1; x_final = 0.5;

% --- EJERCICIO 3 [cite: 405] ---
% f = @(x, y) x*y + sqrt(y);
% x0 = 0; y0 = 1; h = 0.1; x_final = 0.5;

% --- EJERCICIO 4  ---
% ¡OJO! Este empieza en x=1, no en 0.
f = @(x, y) x*y^2 - (y/x);
x0 = 1; y0 = 1; h = 0.1; x_final = 1.5;

% ==========================================
% MOTOR DE CÁLCULO (NO TOCAR)
% Calcula ambos métodos a la vez para comparar
% ==========================================
x = x0:h:x_final;
n = length(x);

y_euler = zeros(1, n); y_euler(1) = y0;
y_mejor = zeros(1, n); y_mejor(1) = y0;

fprintf('Resultados para h=%.2f:\n', h);
fprintf('%-6s | %-12s | %-12s\n', 'X', 'Euler', 'Euler Mejorado');
fprintf('%.2f   | %.6f     | %.6f\n', x(1), y_euler(1), y_mejor(1));

for k = 1:n-1
    % 1. Euler Simple
    m1 = f(x(k), y_euler(k));
    y_euler(k+1) = y_euler(k) + h * m1;
    
    % 2. Euler Mejorado
    m_actual = f(x(k), y_mejor(k));
    y_pred = y_mejor(k) + h * m_actual;       % Predictor
    m_futura = f(x(k+1), y_pred);             % Pendiente en predicción
    y_mejor(k+1) = y_mejor(k) + (h/2) * (m_actual + m_futura); % Corrector
    
    fprintf('%.2f   | %.6f     | %.6f\n', x(k+1), y_euler(k+1), y_mejor(k+1));
end