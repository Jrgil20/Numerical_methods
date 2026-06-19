
function newton_raiz()
    % Definición de la función F(x) y su derivada F'(x)
    % F(x) = x^2 + 2x - sin(x) - 1
    F = @(x) x.^2 + 2.*x - sin(x) - 1;
    
    % F'(x) = 2x + 2 - cos(x)
    dF = @(x) 2.*x + 2 - cos(x);
    
    % Valores iniciales y tolerancia
    x0 = -5;            % Punto inicial 
    TOL = 0.0001;       % Tolerancia 
    MAX_ITER = 50;      % Máximo de iteraciones
    
    % Inicialización de variables
    x_actual = x0;
    error = Inf;
    iter = 0;
    
    % Cabecera de la tabla [cite: 7, 8]
    disp(sprintf('%-4s | %-15s | %-15s | %-15s | %-15s | %-15s', 'Iter', 'Xi', 'F(xi)', 'F''(xi)', 'Xi+1', 'Error'));
    disp(repmat('-', 1, 75)); % Línea separadora
    
    % Formato para mostrar los números (al menos cuatro decimales [cite: 6])
    fmt = '%-4d | %-15.8f | %-15.8f | %-15.8f | %-15.8f | %-15.8f';

    % Bucle principal del Método de Newton
    while error > TOL && iter < MAX_ITER
        Fx = F(x_actual);
        dFx = dF(x_actual);
        
        % Comprobación de la derivada (para evitar división por cero o por un número muy pequeño)
        if abs(dFx) < 1e-10
            disp('Advertencia: La derivada es demasiado pequeña. El método podría divergir.');
            break;
        end
        
        % Fórmula de Newton: Xi+1 = Xi - F(Xi)/F'(Xi)
        x_siguiente = x_actual - Fx / dFx;
        
        % Cálculo del error: |Xi+1 - Xi|
        error = abs(x_siguiente - x_actual);
        
        % Mostrar los resultados de la iteración actual
        disp(sprintf(fmt, iter, x_actual, Fx, dFx, x_siguiente, error));
        
        % Preparar para la siguiente iteración
        x_actual = x_siguiente;
        iter = iter + 1;
    end

    disp(repmat('-', 1, 75));
    if error <= TOL
        disp(sprintf('✅ Raíz encontrada después de %d iteraciones: x ≈ %.8f', iter, x_actual));
        disp(sprintf('Error final: %.8f (Tolerancia: %.4f)', error, TOL));
    else
        disp('❌ El método no convergió después de las iteraciones máximas.');
    end
end
