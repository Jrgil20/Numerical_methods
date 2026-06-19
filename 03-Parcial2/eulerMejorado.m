% ==========================================
% MÉTODO DE EULER MEJORADO (HEUN)
% Referencia: Ejemplo 2, Pag 3
% ==========================================

% 1. Configuración
f = @(x, y) y + x^2;
x0 = 0;
y0 = 1;
h = 0.1;
x_final = 0.3;

% 2. Preparación
x = x0:h:x_final;
n = length(x);
y = zeros(1, n);
y(1) = y0;

% 3. Bucle Predictor-Corrector
fprintf('\n--- Iteraciones Euler Mejorado ---\n');
fprintf('k=0: x=%.2f, y=%.6f\n', x(1), y(1));

for k = 1:n-1
    % A. PREDICTOR (Euler normal)
    pendiente_actual = f(x(k), y(k));
    y_predicha = y(k) + h * pendiente_actual; 
    
    % B. CORRECTOR (Promedio de pendientes)
    % Calculamos la pendiente en el futuro predicho
    pendiente_futura = f(x(k+1), y_predicha);
    
    % Promediamos: (m1 + m2) / 2
    pendiente_promedio = (pendiente_actual + pendiente_futura) / 2;
    
    % Actualizamos y
    y(k+1) = y(k) + h * pendiente_promedio;
    
    fprintf('k=%d: x=%.2f, y=%.6f (Pred: %.4f)\n', ...
            k, x(k+1), y(k+1), y_predicha);
end

% Comparación con valor exacto del PDF [cite: 392]
% Debería dar y(0.3) = 1.35936