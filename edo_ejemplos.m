% =================================================
% SOLUCIONADOR EJERCICIOS PROPUESTOS (Pag 4-5)
% Configuración global: h = 0.1 [cite: 595]
% =================================================

h = 0.1;

% --- SELECCIONA EL EJERCICIO (DESCOMENTA UNO) ---

% EJERCICIO 1 [cite: 596-601]
% f = @(x,y) x + y^2;  x0 = 0; y0 = 0; x_final = 0.5;

% EJERCICIO 2 [cite: 602]
% f = @(x,y) x^2 + y^2; x0 = 0; y0 = 1; x_final = 0.5;

% EJERCICIO 3 [cite: 604]
% f = @(x,y) x*y + sqrt(y); x0 = 0; y0 = 1; x_final = 0.5;

% EJERCICIO 4 [cite: 604] (Cuidado: empieza en x=1)
f = @(x,y) x*y^2 - y/x; x0 = 1; y0 = 1; x_final = 1.5;

% ------------------------------------------------
% MOTOR RK4 (NO TOCAR)
x = x0; y = y0;
n = round((x_final - x0) / h);

fprintf('Ejercicio RK4 (h=%.2f)\n', h);
fprintf('%-6s | %-10s\n', 'X', 'Y (Estimado)');
fprintf('%.2f   | %.6f\n', x, y);

for i = 1:n
    k1 = f(x, y);
    k2 = f(x + h/2, y + h/2*k1);
    k3 = f(x + h/2, y + h/2*k2);
    k4 = f(x + h,   y + h*k3);
    
    y = y + (h/6)*(k1 + 2*k2 + 2*k3 + k4);
    x = x + h;
    
    fprintf('%.2f   | %.6f\n', x, y);
end