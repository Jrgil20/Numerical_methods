function newton_raiz_cuadrada()
    % =========================================================================
    % METODO DE NEWTON PARA CALCULAR LA RAIZ CUADRADA
    % =========================================================================
    % Demostración de que el Método de Newton aplicado a f(x) = x² - R
    % produce la fórmula: x_{n+1} = (1/2)(x_n + R/x_n)
    %
    % Esta es la famosa FORMULA DE BABILONIA o METODO BABILONICO
    % =========================================================================
    
    % Número del cual queremos hallar la raíz cuadrada
    R = 25;
    
    % Valor inicial (con x0 ≠ 0)
    x0 = 5.5;
    
    % Parámetros del método
    TOL = 1e-8;        % Tolerancia
    MAX_ITER = 20;      % Máximo de iteraciones
    
    % Definir f(x) = x² - R
    f = @(x) x.^2 - R;
    
    % Definir f'(x) = 2x
    df = @(x) 2.*x;
    
    fprintf('\n');
    fprintf('╔═══════════════════════════════════════════════════════════════════════════════╗\n');
    fprintf('║                 MÉTODO DE NEWTON PARA RAÍZ CUADRADA                          ║\n');
    fprintf('║                                                                               ║\n');
    fprintf('║  Encontrando: √%d                                                            ║\n', R);
    fprintf('║  Ecuación a resolver: f(x) = x² - %d = 0                                     ║\n', R);
    fprintf('║  Derivada: f''(x) = 2x                                                        ║\n');
    fprintf('║  Fórmula de Newton: x_{n+1} = x_n - f(x_n)/f''(x_n)                          ║\n');
    fprintf('║  Simplificada (Babilonia): x_{n+1} = (1/2)(x_n + R/x_n)                      ║\n');
    fprintf('╚═══════════════════════════════════════════════════════════════════════════════╝\n\n');
    
    % Inicialización
    x_actual = x0;
    error = Inf;
    iter = 0;
    
    % Encabezado de la tabla
    fprintf('%-5s | %-18s | %-18s | %-18s | %-18s | %-18s\n', ...
            'Iter', 'x_n', 'f(x_n)', "f'(x_n)", 'x_{n+1}', 'Error');
    fprintf('%s\n', repmat('-', 1, 98));
    
    % Almacenar historial
    historial = [];
    
    % Bucle principal del Método de Newton
    while error > TOL && iter < MAX_ITER
        % Calcular función y derivada en el punto actual
        fx = f(x_actual);
        dfx = df(x_actual);
        
        % Validar que la derivada no sea cero
        if abs(dfx) < 1e-10
            fprintf('❌ Error: La derivada es demasiado pequeña (≈ %e)\n', dfx);
            fprintf('   El método no puede continuar.\n');
            break;
        end
        
        % Fórmula clásica de Newton: x_{n+1} = x_n - f(x_n)/f'(x_n)
        x_siguiente = x_actual - fx / dfx;
        
        % Calcular error absoluto
        error = abs(x_siguiente - x_actual);
        
        % Mostrar los resultados de la iteración
        fprintf('%-5d | %-18.10f | %-18.10f | %-18.10f | %-18.10f | %-18.10e\n', ...
                iter, x_actual, fx, dfx, x_siguiente, error);
        
        % Guardar en historial
        historial = [historial; iter, x_actual, fx, dfx, x_siguiente, error];
        
        % Actualizar para siguiente iteración
        x_actual = x_siguiente;
        iter = iter + 1;
    end
    
    fprintf('%s\n\n', repmat('-', 1, 98));
    
    % Resultados finales
    if error <= TOL
        fprintf('✅ CONVERGENCIA EXITOSA\n');
        fprintf('   Raíz encontrada en %d iteraciones\n', iter);
        fprintf('   √%d ≈ %.15f\n', R, x_actual);
        fprintf('   Valor exacto: %.15f\n', sqrt(R));
        fprintf('   Error absoluto final: %.2e\n', error);
        fprintf('   Error relativo: %.2e\n\n', error / sqrt(R));
    else
        fprintf('❌ El método NO convergió en %d iteraciones\n\n', MAX_ITER);
    end
    
    % =====================================================================
    % VERIFICACIÓN: Demostrar que la fórmula se reduce a Babilonia
    % =====================================================================
    fprintf('╔═══════════════════════════════════════════════════════════════════════════════╗\n');
    fprintf('║                    VERIFICACIÓN DE LA FÓRMULA                                ║\n');
    fprintf('║                     Fórmula de Babilonia vs Newton                           ║\n');
    fprintf('╚═══════════════════════════════════════════════════════════════════════════════╝\n\n');
    
    fprintf('Para la última iteración:\n');
    fprintf('x_n = %.10f\n', historial(end, 2));
    fprintf('R = %d\n\n', R);
    
    % Aplicar fórmula de Newton
    x_newton = historial(end, 2) - f(historial(end, 2)) / df(historial(end, 2));
    fprintf('Fórmula de NEWTON (clásica):\n');
    fprintf('  x_{n+1} = x_n - f(x_n)/f''(x_n)\n');
    fprintf('  x_{n+1} = %.10f - (%.10f)/(%.10f)\n', ...
            historial(end, 2), f(historial(end, 2)), df(historial(end, 2)));
    fprintf('  x_{n+1} = %.10f\n\n', x_newton);
    
    % Aplicar fórmula de Babilonia
    x_babilonia = 0.5 * (historial(end, 2) + R / historial(end, 2));
    fprintf('Fórmula de BABILONIA (simplificada):\n');
    fprintf('  x_{n+1} = (1/2)(x_n + R/x_n)\n');
    fprintf('  x_{n+1} = (1/2)(%.10f + %d/%.10f)\n', ...
            historial(end, 2), R, historial(end, 2));
    fprintf('  x_{n+1} = %.10f\n\n', x_babilonia);
    
    fprintf('Diferencia entre ambas fórmulas: %.2e\n', abs(x_newton - x_babilonia));
    fprintf('(Están completamente de acuerdo, demostrando la equivalencia)\n\n');
    
    % =====================================================================
    % VISUALIZACIÓN GRÁFICA
    % =====================================================================
    fprintf('Generando gráficos...\n\n');
    
    % Crear figura con subplots
    figure('Position', [100, 100, 1200, 800]);
    
    % Subplot 1: Convergencia de iterados
    subplot(2, 2, 1);
    hold on;
    plot(historial(:, 1), historial(:, 2), 'bo-', 'LineWidth', 2, 'MarkerSize', 6);
    plot(historial(:, 1), ones(size(historial(:, 1))) * sqrt(R), 'r--', 'LineWidth', 2);
    xlabel('Iteración', 'FontSize', 11, 'FontWeight', 'bold');
    ylabel('x_n', 'FontSize', 11, 'FontWeight', 'bold');
    title('Convergencia de los iterados x_n hacia √R', 'FontSize', 12, 'FontWeight', 'bold');
    grid on;
    legend(['Iterados x_n'; sprintf('√%d (valor exacto)', R)], 'Location', 'best');
    hold off;
    
    % Subplot 2: Error absoluto (escala logarítmica)
    subplot(2, 2, 2);
    semilogy(historial(2:end, 1), historial(2:end, 6), 'go-', 'LineWidth', 2, 'MarkerSize', 6);
    hold on;
    semilogy(historial(2:end, 1), ones(size(historial(2:end, 1))) * TOL, 'r--', 'LineWidth', 2);
    xlabel('Iteración', 'FontSize', 11, 'FontWeight', 'bold');
    ylabel('Error absoluto |x_{n+1} - x_n|', 'FontSize', 11, 'FontWeight', 'bold');
    title('Decrecimiento del error (escala logarítmica)', 'FontSize', 12, 'FontWeight', 'bold');
    grid on;
    legend(['Error'; sprintf('Tolerancia = %.0e', TOL)], 'Location', 'best');
    hold off;
    
    % Subplot 3: Función f(x) = x² - R y tangentes
    subplot(2, 2, 3);
    x_plot = linspace(0.1, 8, 200);
    y_plot = x_plot.^2 - R;
    plot(x_plot, y_plot, 'b-', 'LineWidth', 2);
    hold on;
    plot(x_plot, zeros(size(x_plot)), 'k--', 'LineWidth', 1);
    plot([0, 8], [0, 0], 'k-', 'LineWidth', 1);
    
    % Mostrar los primeros 4 iterados y sus tangentes
    colores = {'r', 'g', 'm', 'c'};
    for i = 1:min(4, size(historial, 1))
        x_i = historial(i, 2);
        f_i = historial(i, 3);
        df_i = historial(i, 4);
        
        % Punto actual
        plot(x_i, f_i, 'o', 'Color', colores{i}, 'MarkerSize', 8, 'MarkerFaceColor', colores{i});
        
        % Tangente
        x_tan = linspace(x_i - 1, x_i + 1, 100);
        y_tan = f_i + df_i * (x_tan - x_i);
        plot(x_tan, y_tan, '--', 'Color', colores{i}, 'LineWidth', 1.5);
        
        % Siguiente iterado en el eje x
        if i < size(historial, 1)
            x_next = historial(i+1, 2);
            plot(x_next, 0, 'x', 'Color', colores{i}, 'MarkerSize', 10, 'LineWidth', 2);
        end
    end
    
    % Raíz exacta
    plot(sqrt(R), 0, 'r*', 'MarkerSize', 15, 'LineWidth', 2);
    
    xlabel('x', 'FontSize', 11, 'FontWeight', 'bold');
    ylabel('f(x) = x² - R', 'FontSize', 11, 'FontWeight', 'bold');
    title('Método de Newton: Interpretación geométrica', 'FontSize', 12, 'FontWeight', 'bold');
    grid on;
    xlim([0, 8]);
    ylim([-30, 40]);
    legend('f(x) = x² - R', 'y = 0', '', '', '', 'Raíz exacta', 'Location', 'best');
    hold off;
    
    % Subplot 4: Verificación de Babilonia
    subplot(2, 2, 4);
    x_bab = [];
    x_new = [];
    for i = 1:size(historial, 1)-1
        x_i = historial(i, 2);
        x_bab = [x_bab; 0.5 * (x_i + R / x_i)];
        x_new = [x_new; x_i - f(x_i) / df(x_i)];
    end
    plot(1:length(x_bab), x_bab, 'b*-', 'LineWidth', 2, 'MarkerSize', 10);
    hold on;
    plot(1:length(x_new), x_new, 'ro--', 'LineWidth', 2, 'MarkerSize', 8);
    xlabel('Iteración', 'FontSize', 11, 'FontWeight', 'bold');
    ylabel('x_{n+1}', 'FontSize', 11, 'FontWeight', 'bold');
    title('Equivalencia: Fórmula de Babilonia vs Newton', 'FontSize', 12, 'FontWeight', 'bold');
    grid on;
    legend(['Babilonia: (1/2)(x_n + R/x_n)'; 'Newton: x_n - f(x_n)/f''(x_n)'], 'Location', 'best');
    hold off;
    
    % Ajustar espaciado entre subplots
    % Nota: sgtitle no está disponible en versiones antiguas de Octave
    % Se omite para compatibilidad
    
    fprintf('✅ Gráficos generados exitosamente.\n');
    fprintf('\n');
    
end
