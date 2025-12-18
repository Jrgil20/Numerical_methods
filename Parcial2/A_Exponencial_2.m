% --- DATOS (Ejemplo Pag. 2) ---
x = [0; 1; 2; 3; 4; 5];
y = [0.3; 1.8; 3.9; 10.3; 15.4; 25.7];

% --- PROCESAMIENTO ---
x = x(:);
y = y(:);
n = length(x);

% Linealización: ln(y) = ax + ln(b) -> Y = aX + c
X = x;
Y = log(y);

% Construcción del Sistema Normal (Pag. 3)
M = [sum(X.^2), sum(X);
     sum(X),    n     ];

B = [sum(X.*Y);
     sum(Y)   ];

% --- MOSTRAR INTERMEDIOS ---
disp('Matriz del Sistema (M):');
disp(M);
disp('Vector Independiente (B):');
disp(B);

% --- SOLUCIÓN ---
incognitas = M \ B;
a = incognitas(1);
c = incognitas(2);
b = exp(c);

% --- RESULTADOS ---
fprintf('a = %.6f\n', a);
fprintf('b = %.6f\n', b);
fprintf('Ecuación: y = %.6f * e^(%.6f * x)\n', b, a);