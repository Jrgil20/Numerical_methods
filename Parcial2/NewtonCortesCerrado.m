% ======================================================
%  SOLUCIONADOR GENÉRICO NEWTON-COTES (CERRADO)
%  Replica la lógica del PROGRAMA 4-2
% ======================================================

% 1. BASE DE DATOS DE COEFICIENTES (W)
% Estructura: {Pesos...}, Numerador(Q), Denominador(R)
DB_NewtonCotes = {
    [1, 1],       1, 2;  % N=1: Trapecio
    [1, 4, 1],    1, 3;  % N=2: Simpson 1/3
    [1, 3, 3, 1], 3, 8;  % N=3: Simpson 3/8
    [7, 32, 12, 32, 7], 2, 45 % N=4: Boole (Villarceau)
};

% 2. CONFIGURACIÓN USUARIO
f = @(x) sin(x);     % Función a integrar (Ejemplo del texto)
a = 0;               % Límite inferior
b = pi/2;            % Límite superior
N = 4;               % ORDEN DEL MÉTODO (1 a 4)

% 3. EXTRACCIÓN DE PARÁMETROS
if N < 1 || N > 4
    error('Orden N no soportado en esta demo.');
end

Weights = DB_NewtonCotes{N, 1}; % Vector de pesos (W)
Q = DB_NewtonCotes{N, 2};
R = DB_NewtonCotes{N, 3};

% 4. EJECUCIÓN DEL ALGORITMO (Como en el libro)
h = (b - a) / N;    % Espaciamiento
x = a:h:b;          % Generación de la retícula
y = f(x);           % Evaluación de la función

ANS = 0;
fprintf('--- Traza del Algoritmo (N=%d) ---\n', N);
fprintf('Factor Global (Q/R) = %d/%d\n', Q, R);

for J = 1:(N+1)     % J recorre los puntos (ajustado a índice 1 de Octave)
    peso = Weights(J);
    valor = y(J);
    aporte = peso * valor;
    ANS = ANS + aporte;
    
    fprintf('Punto %d: f(%.4f)=%.4f * W=%d -> Acum: %.4f\n', ...
            J-1, x(J), valor, peso, ANS);
end

% Ajuste Final
AL = Q / R;
Resultado = ANS * h * AL;

fprintf('----------------------------------\n');
fprintf('RESULTADO FINAL = %.8f\n', Resultado);
fprintf('----------------------------------\n');