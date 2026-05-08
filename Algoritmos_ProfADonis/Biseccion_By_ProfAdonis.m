% Script de Octave para el MÃ©todo de BisecciÃ³n con tabla de resultados
% FunciÃ³n: f(x) = x^3 - 2*x - 5
% Intervalo inicial: [a, b] = [0, 5]

% --- ConfiguraciÃ³n Inicial ---
a = 0;             % Extremo inferior del intervalo
b = 5;             % Extremo superior del intervalo
tol = 1e-5;        % Tolerancia para el error absoluto de la raÃ­z: |b-a|/2 < tol
max_iter = 50;     % NÃºmero mÃ¡ximo de iteraciones
iter = 0;          % Contador de iteraciones

% --- InicializaciÃ³n de la Tabla ---
% Columnas: [IteraciÃ³n (k), a, b, c=(a+b)/2, f(c), Error_Absoluto_Intervalo]
resultados = [];

% --- EvaluaciÃ³n de los extremos iniciales ---
% f(x) = x^3 - 2*x - 5
fa = a^3 - 2*a - 5;
fb = b^3 - 2*b - 5;

% --- ComprobaciÃ³n de Signo ---
if fa * fb > 0
    disp('Error: La funciÃ³n no cambia de signo en el intervalo inicial.');
    disp('El mÃ©todo de bisecciÃ³n no garantiza una raÃ­z en [0, 5].');
else
    % --- Encabezado ---
    disp('Iniciando MÃ©todo de BisecciÃ³n para f(x) = x^3 - 2x - 5 en [0, 5]');
    disp('--------------------------------------------------------------------------------');

    % Imprimir encabezados de la tabla
    fprintf('%3s | %10s | %10s | %10s | %12s | %10s\n', ...
            'k', 'a', 'b', 'c=(a+b)/2', 'f(c)', 'Error_Intervalo');
    fprintf('--------------------------------------------------------------------------------\n');

    % --- Bucle principal del mÃ©todo de bisecciÃ³n ---
    while (b - a) / 2 > tol && iter < max_iter
        iter = iter + 1;

        % 1. Calcular el punto medio (c)
        c = (a + b) / 2;

        % 2. Evaluar la funciÃ³n en el punto medio (fc)
        fc = c^3 - 2*c - 5;

        % 3. Calcular el error absoluto del intervalo
        error_intervalo = (b - a) / 2;

        % 4. Almacenar y mostrar resultados de la iteraciÃ³n
        % [IteraciÃ³n, a, b, c, f(c), Error_Intervalo]
        fila = [iter, a, b, c, fc, error_intervalo];
        resultados = [resultados; fila];

        fprintf('%3d | %10.6f | %10.6f | %10.6f | %12.6e | %10.6e\n', ...
                fila(1), fila(2), fila(3), fila(4), fila(5), fila(6));

        % 5. Comprobar el criterio de parada (si fc es la raÃ­z)
        if abs(fc) < tol
            break;
        end

        % 6. Actualizar el intervalo
        % Si f(a) y f(c) tienen signos opuestos, la raÃ­z estÃ¡ en [a, c]
        % (Recalculamos fa para la comparaciÃ³n, ya que 'a' puede haber cambiado en la iteraciÃ³n anterior)
        fa_actual = a^3 - 2*a - 5;
        if fa_actual * fc < 0
            b = c;
        % Si f(c) y f(b) tienen signos opuestos, la raÃ­z estÃ¡ en [c, b]
        else
            a = c;
        end
    end

    % --- Resumen Final ---
    fprintf('--------------------------------------------------------------------------------\n');
    fprintf('Convergencia alcanzada.\n');
    fprintf('RaÃ­z aproximada: %.8f\n', c);
    fprintf('Valor de la funciÃ³n en la raÃ­z: %.8e\n', c^3 - 2*c - 5);
    fprintf('Iteraciones realizadas: %d\n', iter);
end