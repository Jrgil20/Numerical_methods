% =================================================
% MÉTODO DE RUNGE-KUTTA DE 4TO ORDEN (RK4)
% Referencia: Guía EDO_RK4.pdf, Pags 1-4
% =================================================

% 1. CONFIGURACIÓN DEL PVI (Ejemplo 1, Pag 1) [cite: 540-542]
f = @(x,y) x - 3*y;    % La EDO: y' = f(x,y)
x0 = 0;                % Valor inicial x
y0 = 1;                % Valor inicial y(x0)
x_final = 0.9;         % Hasta dónde calcular
h = 0.3;               % Paso (h)

% 2. INICIALIZACIÓN
n = round((x_final - x0) / h); % Número de pasos
x = x0;
y = y0;

fprintf('--- Iteraciones RK4 ---\n');
fprintf('k=0: x=%.2f, y=%.5f\n', x, y);

% 3. BUCLE ITERATIVO [cite: 574-591]
for i = 1:n
    % Cálculo de las 4 pendientes (k)
    k1 = f(x, y);                         % [cite: 576]
    k2 = f(x + h/2, y + (h/2)*k1);        % [cite: 578]
    k3 = f(x + h/2, y + (h/2)*k2);        % [cite: 580]
    k4 = f(x + h,   y + h*k3);            % [cite: 582]
    
    % Promedio ponderado para avanzar Y
    y_next = y + (h/6)*(k1 + 2*k2 + 2*k3 + k4); % [cite: 584]
    
    % Avanzar X
    x_next = x + h;                       % [cite: 586]
    
    % Mostrar resultados intermedios para validar con Pag 2 [cite: 550]
    fprintf('\nPASO %d:\n', i);
    fprintf('   k1=%.5f, k2=%.5f, k3=%.5f, k4=%.5f\n', k1, k2, k3, k4);
    fprintf('   Resultado: x=%.2f, y=%.5f\n', x_next, y_next);
    
    % Actualizar variables para siguiente vuelta
    x = x_next;
    y = y_next;
end