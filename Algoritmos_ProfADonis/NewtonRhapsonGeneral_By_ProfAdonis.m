% ----------------------------------------------------
% SCRIPT OCTAVE: NEWTON-RAPHSON (SIN FUNCIONES)
% FunciÃ³n: f(x) = x^3 - 2x - 5
% Derivada: f'(x) = 3x^2 - 2
% ----------------------------------------------------

% 1. ParÃ¡metros de Entrada âš™ï¸
x_current = 2.0;            % AproximaciÃ³n inicial (x0)
tolerance = 1e-6;           % Criterio de parada (tolerancia)
max_iterations = 50;        % MÃ¡ximo de iteraciones permitido

% 2. InicializaciÃ³n de variables de control
k = 0;                      % Contador de iteraciones
error = 1;                  % Inicializar el error (debe ser mayor que la tolerancia)

printf('--------------------------------------------------------------\n');
printf('| Iter |       x_n      |      f(x_n)    |  |x_n+1 - x_n| |\n');
printf('--------------------------------------------------------------\n');

% 3. Bucle Principal (While)
while (error >= tolerance) && (k < max_iterations)

    k = k + 1;

    % --- DefiniciÃ³n y EvaluaciÃ³n de f(x) y f'(x) ---

    % f(x) = x^3 - 2x - 5
    f_val = x_current.^3 - 2*x_current - 5;

    % f'(x) = 3x^2 - 2
    f_prime_val = 3*x_current.^2 - 2;

    % ------------------------------------------------

    % Manejo de error: Derivada cercana a cero
    if abs(f_prime_val) < 1e-10
        disp('Â¡Error! La derivada es muy cercana a cero. El mÃ©todo falla.');
        x_current = NaN;
        break;
    end

    % 4. AplicaciÃ³n de la FÃ³rmula de Newton-Raphson
    % x_next = x_current - (f(x_current) / f'(x_current))
    x_next = x_current - (f_val / f_prime_val);

    % 5. CÃ¡lculo del error y preparaciÃ³n para la siguiente iteraciÃ³n
    error = abs(x_next - x_current);

    % Imprimir el paso actual
    printf('| %4d | %14.10f | %14.10f | %14.10f |\n', ...
           k, x_current, f_val, error);

    % Actualizar x_current para la prÃ³xima iteraciÃ³n
    x_current = x_next;

end

printf('--------------------------------------------------------------\n');

% 6. Mostrar el Resultado Final ðŸ†
if isnan(x_current)
    disp('El mÃ©todo no pudo converger.');
elseif k >= max_iterations
    disp('Advertencia: Se alcanzÃ³ el nÃºmero mÃ¡ximo de iteraciones.');
    printf('EstimaciÃ³n final: x = %.10f\n', x_current);
else
    printf('\nResultado:\n');
    printf('La estimaciÃ³n final de la raÃ­z es: x = %.10f\n', x_current);
    printf('NÃºmero de iteraciones: %d\n', k);
end