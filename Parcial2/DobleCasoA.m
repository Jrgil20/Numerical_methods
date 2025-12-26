% ==========================================================
% INTEGRAL DOBLE - REGIÓN RECTANGULAR (TRAPECIO)
% Referencia: Ejemplo 1, Pag 2 del PDF
% ==========================================================

% 1. DEFINICIÓN DEL PROBLEMA
f = @(x,y) x.^2 + y.^2;  % Función f(x,y)
ax = 0; bx = 2;          % Límites para X (Exteriores)
ay = 0; by = 1;          % Límites para Y (Interiores)
nx = 2;                  % Número de tramos en X
ny = 2;                  % Número de tramos en Y

% 2. MOTOR DE INTEGRACIÓN 1D (TRAPECIO)
% Definimos una función local para no repetir código
function area = Trapecio1D(valores_z, h)
    % Fórmula: h/2 * (Extremos + 2*Intermedios)
    area = (h/2) * (valores_z(1) + 2*sum(valores_z(2:end-1)) + valores_z(end));
end

% 3. ALGORITMO PRINCIPAL (Iteración Anidada)
hx = (bx - ax) / nx;     % Paso en X
x_vec = ax:hx:bx;        % Vector de coordenadas X
G_vals = zeros(1, length(x_vec)); % Aquí guardaremos los resultados de la integral interna

fprintf('--- Calculando Integral Interna G(x) ---\n');

% Bucle Externo: Recorremos cada "rebanada" de X
for i = 1:length(x_vec)
    xi_actual = x_vec(i);
    
    % Para este X fijo, integramos en Y
    hy = (by - ay) / ny;
    y_vec = ay:hy:by;
    
    % Evaluamos la función f(xi, y) variando solo Y
    z_vals = f(xi_actual, y_vec);
    
    % Resolvemos la integral interna (Obtenemos el área de la rebanada)
    G_vals(i) = Trapecio1D(z_vals, hy);
    
    fprintf('Para x=%.2f -> G(x) = %.4f\n', xi_actual, G_vals(i));
end

% 4. INTEGRAL EXTERNA
% Ahora integramos los valores de G(x) respecto a X
Resultado = Trapecio1D(G_vals, hx);

fprintf('--------------------------------------\n');
fprintf('RESULTADO FINAL (Volumen) = %.6f\n', Resultado);
fprintf('--------------------------------------\n');
% Debería dar 3.75 según el PDF [cite: 451]