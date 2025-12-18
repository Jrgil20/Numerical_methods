% ==========================================
% REGLA DEL TRAPECIO: DESDE TABLA DE DATOS
% Referencia: Ejemplo 3, Pag 3
% ==========================================

% 1. Input de Datos
x = [0.0; 0.5; 1.0; 1.5; 2.0];
y = [2.0; 3.2; 4.1; 4.9; 5.9];

% 2. Calcular el paso 'h'
% Asumimos paso constante (equiespaciados) [cite: 796]
h = x(2) - x(1);

% 3. Algoritmo del Trapecio
% Formula: (h/2) * [ y_inicial + y_final + 2*sum(y_intermedios) ]

primero = y(1);
ultimo  = y(end);
intermedios = y(2:end-1); % Todos menos el primero y el ultimo

Area = (h/2) * (primero + ultimo + 2 * sum(intermedios));

% 4. Resultado
fprintf('Paso (h): %.4f\n', h);
fprintf('Integral Aproximada (Área): %.6f\n', Area);

% El PDF dice que debe dar 8.075 [cite: 798]