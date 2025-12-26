% ==========================================================
% INTEGRAL DOBLE - REGIÓN GENERAL (SIMPSON 1/3)
% Referencia: Ejemplo 2, Pag 2-3 del PDF
% ==========================================================

% 1. DEFINICIÓN DEL PROBLEMA
f = @(x,y) (x + y.^2).^2;

% Límites EXTERNOS (X) - Deben ser constantes
ax = 0; bx = 4;
nx = 4; % Tramos en X (Debe ser PAR para Simpson)

% Límites INTERNOS (Y) - Son funciones dinámicas de X
lim_y_inf = @(x) -sqrt(4*x - x.^2);
lim_y_sup = @(x) sqrt(4*x - x.^2);
ny = 4; % Tramos en Y (Debe ser PAR)

% 2. MOTOR DE INTEGRACIÓN 1D (SIMPSON 1/3)
function area = Simpson1D(vals, h)
    n = length(vals) - 1;
    impares = sum(vals(2:2:end-1));
    pares   = sum(vals(3:2:end-2));
    area = (h/3) * (vals(1) + 4*impares + 2*pares + vals(end));
end

% 3. ALGORITMO PRINCIPAL
hx = (bx - ax) / nx;
x_vec = ax:hx:bx;
G_vals = zeros(1, length(x_vec));

fprintf('--- Calculando Integral Interna G(x) con Límites Dinámicos ---\n');

for i = 1:length(x_vec)
    xi = x_vec(i);
    
    % A. Calcular los límites de Y para ESTE x específico
    c = lim_y_inf(xi);
    d = lim_y_sup(xi);
    
    % Caso especial: Si los límites son iguales (bordes del círculo), el área es 0
    if abs(d - c) < 1e-9
        G_vals(i) = 0;
        fprintf('Para x=%.2f -> Límites [%.2f, %.2f] -> G(x) = 0 (Borde)\n', xi, c, d);
        continue;
    end
    
    % B. Integrar en Y
    hy = (d - c) / ny;
    y_vec = c:hy:d;
    z_vals = f(xi, y_vec);
    
    G_vals(i) = Simpson1D(z_vals, hy);
    
    fprintf('Para x=%.2f -> Límites [%.2f, %.2f] -> G(x) = %.4f\n', xi, c, d, G_vals(i));
end

% 4. INTEGRAL EXTERNA
Resultado = Simpson1D(G_vals, hx);

fprintf('--------------------------------------\n');
fprintf('RESULTADO FINAL = %.5f\n', Resultado);
fprintf('--------------------------------------\n');
% Debería dar aprox 134.236 según el PDF [cite: 476]