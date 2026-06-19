function demostracion_babilonia()
    % =========================================================================
    % DEMOSTRACIÓN ALGEBRAICA Y NUMÉRICA
    % Método de Newton → Fórmula de Babilonia
    % =========================================================================
    
    fprintf('\n');
    fprintf('╔═══════════════════════════════════════════════════════════════════════════════╗\n');
    fprintf('║         DEMOSTRACIÓN: NEWTON PARA RAÍZ CUADRADA = FÓRMULA DE BABILONIA        ║\n');
    fprintf('╚═══════════════════════════════════════════════════════════════════════════════╝\n\n');
    
    % Mostrar la derivación algebraica
    fprintf('PASO 1: Plantear la ecuación a resolver\n');
    fprintf('───────────────────────────────────────\n');
    fprintf('Para hallar √R, resolvemos:  f(x) = x² - R = 0\n\n');
    
    fprintf('PASO 2: Calcular la derivada\n');
    fprintf('────────────────────────────\n');
    fprintf("f'(x) = 2x\n\n");
    
    fprintf('PASO 3: Aplicar la fórmula de Newton\n');
    fprintf('────────────────────────────────────\n');
    fprintf('x_{n+1} = x_n - f(x_n)/f''(x_n)\n');
    fprintf('x_{n+1} = x_n - (x_n² - R)/(2x_n)\n');
    fprintf('x_{n+1} = x_n - x_n²/(2x_n) + R/(2x_n)\n');
    fprintf('x_{n+1} = x_n - x_n/2 + R/(2x_n)\n');
    fprintf('x_{n+1} = x_n/2 + R/(2x_n)\n');
    fprintf('x_{n+1} = (1/2)(x_n + R/x_n)  ← FÓRMULA DE BABILONIA\n\n');
    
    fprintf('═══════════════════════════════════════════════════════════════════════════════\n\n');
    
    % Valores a probar
    raices_a_hallar = [2, 5, 7, 10, 50, 100];
    
    fprintf('VERIFICACIÓN NUMÉRICA CON DIFERENTES VALORES DE R\n');
    fprintf('──────────────────────────────────────────────────\n\n');
    
    for R = raices_a_hallar
        fprintf('┌─ R = %d ─────────────────────────────────────────────────────────────────┐\n', R);
        
        % Parámetros
        x0 = R / 2;  % Punto inicial
        TOL = 1e-12;
        MAX_ITER = 20;
        
        % Definir funciones
        f = @(x) x.^2 - R;
        df = @(x) 2.*x;
        
        % Inicialización
        x_actual = x0;
        iter = 0;
        
        fprintf('│ Punto inicial: x₀ = %.2f\n', x0);
        fprintf('│ Tolerancia: %.0e\n', TOL);
        fprintf('├────────────┬──────────────────┬──────────────────┬──────────────────┤\n');
        fprintf('│ Iteración  │      Newton      │    Babilonia     │   Diferencia     │\n');
        fprintf('├────────────┼──────────────────┼──────────────────┼──────────────────┤\n');
        
        while iter < MAX_ITER
            % Fórmula de Newton
            fx = f(x_actual);
            dfx = df(x_actual);
            x_newton = x_actual - fx / dfx;
            
            % Fórmula de Babilonia
            x_babilonia = 0.5 * (x_actual + R / x_actual);
            
            % Diferencia
            diferencia = abs(x_newton - x_babilonia);
            
            fprintf('│ %10d │ %16.12f │ %16.12f │ %16.3e │\n', ...
                    iter, x_newton, x_babilonia, diferencia);
            
            % Criterio de paro
            error = abs(x_newton - x_actual);
            if error < TOL
                break;
            end
            
            x_actual = x_newton;
            iter = iter + 1;
        end
        
        fprintf('├────────────┴──────────────────┴──────────────────┴──────────────────┤\n');
        fprintf('│ Resultado final: √%d ≈ %.15f\n', R, x_actual);
        fprintf('│ Valor exacto:     √%d = %.15f\n', R, sqrt(R));
        fprintf('│ Error: %.3e  (Convergencia en %d iteraciones)\n', ...
                abs(x_actual - sqrt(R)), iter);
        fprintf('└──────────────────────────────────────────────────────────────────────┘\n\n');
    end
    
    fprintf('═══════════════════════════════════════════════════════════════════════════════\n\n');
    
    % Análisis de convergencia
    fprintf('ANÁLISIS DE CONVERGENCIA\n');
    fprintf('────────────────────────\n\n');
    
    fprintf('El Método de Newton para raíces cuadradas tiene CONVERGENCIA CUADRÁTICA:\n');
    fprintf('Esto significa que el número de cifras significativas correctas se duplica\n');
    fprintf('aproximadamente en cada iteración.\n\n');
    
    fprintf('Ejemplo con √2:\n');
    fprintf('───────────────\n');
    
    R = 2;
    x = 1.5;  % Punto inicial
    
    fprintf('│ Iter │      x_n         │ Cifras correctas │\n');
    fprintf('├──────┼──────────────────┼─────────────────┤\n');
    
    valor_exacto = sqrt(R);
    
    for i = 0:5
        cifras_correctas = -round(log10(abs(x - valor_exacto)));
        fprintf('│ %4d │ %16.14f │      %2d         │\n', i, x, max(0, cifras_correctas));
        if i < 5
            x = 0.5 * (x + R / x);
        end
    end
    
    fprintf('├──────┼──────────────────┼─────────────────┤\n');
    fprintf('│      └─> Convergencia cuadrática verificada\n');
    fprintf('└──────────────────────────────────────────────\n\n');
    
    fprintf('═══════════════════════════════════════════════════════════════════════════════\n');
    fprintf('\n✅ LA FÓRMULA DE NEWTON Y LA FÓRMULA DE BABILONIA SON EQUIVALENTES\n');
    fprintf('   Ambas producen exactamente los mismos iterados numéricos.\n\n');
    
end
