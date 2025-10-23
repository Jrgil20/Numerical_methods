
function lagrange_interpolacion()
    % Se requiere la Symbolic Math Toolbox para manejar fracciones y la expresión del polinomio.
    if ~license('test', 'symbolic_toolbox')
        disp('Error: La Symbolic Math Toolbox no está disponible. No se puede garantizar el cálculo con FRACCIONES.');
        return;
    end
    
    % Definición de los puntos de datos [cite: 9, 10]
    % X: [5, 2, 9]
    % F(X): [18, 5, 11]
    X = [5, 2, 9];
    F = [18, 5, 11];
    n = length(X); % Grado del polinomio: n-1 = 2
    
    % Definición de la variable simbolica 'x'
    syms x
    g_x = sym(0); % Inicialización del polinomio de interpolación g(x) [cite: 12]
    
    disp(sprintf('Puntos dados: X = [%s], F(X) = [%s]', num2str(X), num2str(F)));
    disp('----------------------------------------------------');
    
    % --- 2.b. Calcule cada término de Li --- [cite: 13]
    disp('2.b. Cálculo de los Polinomios Base de Lagrange (Li(x)):');
    
    L = cell(1, n); % Almacena los polinomios base Li
    
    for i = 1:n
        Li = sym(1); % Inicializar el término Li con 1
        % Construir el producto: Prod (x - Xj) / (Xi - Xj) para j != i
        for j = 1:n
            if i ~= j
                % Multiplicar por el término (x - Xj) / (Xi - Xj)
                % Utilizamos 'sym(X(i) - X(j))' para asegurar que el denominador sea una fracción exacta.
                denominador = sym(X(i) - X(j));
                
                % Comprobación de denominador cero (puntos duplicados)
                if denominador == 0
                    error('Error: Puntos X duplicados. La interpolación no es posible.');
                end
                
                Li = Li * ((x - X(j)) / denominador);
            end
        end
        L{i} = simplify(Li); % Simplificar la expresión de Li
        disp(sprintf('   L%d(x) = %s', i, char(L{i}))); % Mostrar el término Li
    end
    
    disp('----------------------------------------------------');
    
    % --- 2.a. Plantee la ecuación general g(x) (con Li, fi) --- [cite: 12]
    % g(x) = Sum (Fi * Li(x))
    for i = 1:n
        % Agregar el término Fi * Li(x) a g(x)
        % Utilizamos 'sym(F(i))' para asegurar que el coeficiente F(i) sea una fracción exacta.
        g_x = g_x + sym(F(i)) * L{i};
    end
    
    disp('2.a. Ecuación General del Polinomio g(x):');
    disp(sprintf('   g(x) = %s', char(g_x)));
    
    disp('----------------------------------------------------');
    
    % --- 2.c. Plantee 2.1 con los términos calculados en 2.2 --- [cite: 15]
    % (Esto es esencialmente mostrar la suma de los términos F_i * L_i antes de agrupar)
    % La línea 2.a ya planteó la suma de los términos. Ahora mostramos la expresión sin simplificar:
    disp('2.c. Ecuación del Polinomio (Suma de términos F_i * L_i):');
    g_x_no_simplificada = sym(0);
    for i = 1:n
        g_x_no_simplificada = g_x_no_simplificada + sym(F(i)) * L{i};
    end
    disp(sprintf('   g(x) = %s', char(g_x_no_simplificada)));
    
    disp('----------------------------------------------------');
    
    % --- 2.d. Agrupe los coeficientes con el mismo exponente (sin sumarlos aún) --- [cite: 16]
    % La función 'collect' realiza esta agrupación en la expresión g_x
    g_x_agrupada = collect(g_x, x);
    disp('2.d. Ecuación Agrupada por Potencias de x (Coeficientes como Fracciones):');
    disp(sprintf('   g(x) = %s', char(g_x_agrupada)));
    
    disp('----------------------------------------------------');
    
    % --- 2.e. Plantee la ecuación de interpolación final --- [cite: 17]
    % La función 'simplify' o 'expand' de MATLAB ya realiza la suma final para obtener la forma estándar.
    g_x_final = simplify(g_x);
    disp('2.e. Ecuación de Interpolación Final (Simplificada y con Coeficientes Sumados):');
    disp(sprintf('   g(x) = %s', char(g_x_final)));
    
    % Extracción de los coeficientes finales para verificar que son fracciones
    coeficientes = fliplr(coeffs(g_x_final, x, 'All')); % Coeficientes en orden descendente
    disp('   Coeficientes Finales (en orden x^2, x^1, x^0) en formato de fracción:');
    for k = 1:length(coeficientes)
        disp(sprintf('      Coeficiente de x^%d: %s', length(coeficientes) - k, char(coeficientes(k))));
    end
    
    disp('----------------------------------------------------');
    
    % --- 2.f. Evalúe el polinomio en x=7 --- [cite: 19]
    x_eval = 7;
    % Sustituir el valor de x en la ecuación final
    valor_g_x = subs(g_x_final, x, x_eval);
    
    disp(sprintf('2.f. Evaluación del Polinomio en x = %d:', x_eval));
    disp(sprintf('   g(%d) = %s (Forma Fraccionaria)', x_eval, char(valor_g_x)));
    % Mostrar también el valor numérico para referencia
    disp(sprintf('   g(%d) ≈ %.8f (Forma Decimal)', x_eval, double(valor_g_x)));
end
