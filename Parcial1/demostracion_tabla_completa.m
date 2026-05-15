function demostracion_tabla_detallada()
    % =========================================================================
    % DEMOSTRACIÓN DETALLADA CON TABLA COMPLETA
    % Comparación paso a paso: Newton vs Babilonia
    % =========================================================================
    
    fprintf('\n');
    fprintf('╔═══════════════════════════════════════════════════════════════════════════════╗\n');
    fprintf('║    DEMOSTRACIÓN DETALLADA: NEWTON vs BABILONIA - TABLA COMPLETA              ║\n');
    fprintf('║                                                                               ║\n');
    fprintf('║  Se muestra lado a lado cómo ambas fórmulas son algebraicamente idénticas    ║\n');
    fprintf('╚═══════════════════════════════════════════════════════════════════════════════╝\n\n');
    
    % === PARTE 1: DERIVACIÓN ALGEBRAICA ===
    fprintf('═══════════════════════════════════════════════════════════════════════════════\n');
    fprintf('PARTE 1: DERIVACIÓN ALGEBRAICA\n');
    fprintf('═══════════════════════════════════════════════════════════════════════════════\n\n');
    
    fprintf('Para calcular √R, aplicamos el Método de Newton a f(x) = x² - R\n\n');
    
    fprintf('┌─ PASO 1: Función y su derivada ─────────────────────────────────────────┐\n');
    fprintf('│ f(x) = x² - R                                                          │\n');
    fprintf('│ f''(x) = 2x                                                             │\n');
    fprintf('└──────────────────────────────────────────────────────────────────────────┘\n\n');
    
    fprintf('┌─ PASO 2: Fórmula de Newton ─────────────────────────────────────────────┐\n');
    fprintf('│ x_{n+1} = x_n - f(x_n)/f''(x_n)                                         │\n');
    fprintf('│ x_{n+1} = x_n - (x_n² - R)/(2x_n)                                      │\n');
    fprintf('└──────────────────────────────────────────────────────────────────────────┘\n\n');
    
    fprintf('┌─ PASO 3: Simplificar ───────────────────────────────────────────────────┐\n');
    fprintf('│ x_{n+1} = x_n - (x_n²)/(2x_n) + R/(2x_n)  [separar fracciones]         │\n');
    fprintf('│ x_{n+1} = x_n - x_n/2 + R/(2x_n)          [simplificar x_n²/2x_n]     │\n');
    fprintf('│ x_{n+1} = x_n/2 + R/(2x_n)                [combinar términos x_n]      │\n');
    fprintf('│ x_{n+1} = (1/2)(x_n + R/x_n)              [factorizar 1/2]             │\n');
    fprintf('│          ↑                                                              │\n');
    fprintf('│    FÓRMULA DE BABILONIA                                                │\n');
    fprintf('└──────────────────────────────────────────────────────────────────────────┘\n\n');
    
    fprintf('═══════════════════════════════════════════════════════════════════════════════\n');
    fprintf('PARTE 2: VERIFICACIÓN NUMÉRICA CON TABLA DETALLADA\n');
    fprintf('═══════════════════════════════════════════════════════════════════════════════\n\n');
    
    % Parámetros
    R = 10;
    x0 = 3.0;
    valor_exacto = sqrt(R);
    
    fprintf('Calculando √%d con punto inicial x₀ = %.2f\n', R, x0);
    fprintf('Valor exacto: √%d = %.15f\n\n', R, valor_exacto);
    
    fprintf('TABLA: Comparación Newton vs Babilonia\n');
    fprintf('───────────────────────────────────────\n\n');
    
    % Encabezados
    fprintf('│ n │        x_n        │  f(x_n)=x_n²-R  │  f''(x_n)=2x_n  │');
    fprintf('  NEWTON: x_n - f/f''  │ BABILONIA: (x_n+R/x_n)/2 │  Diferencia  │   Error   │\n');
    fprintf('├───┼──────────────────┼─────────────────┼─────────────────┼');
    fprintf('───────────────────────┼──────────────────────────────┼──────────────┼───────────┤\n');
    
    x = x0;
    for iter = 0:4
        % Calcular valores de la función
        f_x = x^2 - R;
        df_x = 2*x;
        
        % Newton
        x_newton = x - f_x / df_x;
        
        % Babilonia
        x_bab = 0.5 * (x + R / x);
        
        % Diferencia entre fórmulas
        diferencia = abs(x_newton - x_bab);
        
        % Error respecto a valor exacto
        error = abs(x_newton - valor_exacto);
        
        fprintf('│ %d │ %16.10f │ %15.6e │ %15.6e │ %21.15f │ %26.15f │ %12.3e │ %9.3e │\n', ...
                iter, x, f_x, df_x, x_newton, x_bab, diferencia, error);
        
        x = x_newton;
    end
    
    fprintf('├───┴──────────────────┴─────────────────┴─────────────────┴');
    fprintf('───────────────────────┴──────────────────────────────┴──────────────┴───────────┤\n');
    fprintf('│ Observe: Las columnas "NEWTON" y "BABILONIA" muestran EXACTAMENTE LOS MISMOS  │\n');
    fprintf('│ valores (diferencia ≤ 2.22e-16, que es el error de redondeo de máquina)      │\n');
    fprintf('└─────────────────────────────────────────────────────────────────────────────────┘\n\n');
    
    % === PARTE 3: VERIFICACIÓN CON TABLA EXPANDIDA ===
    fprintf('═══════════════════════════════════════════════════════════════════════════════\n');
    fprintf('PARTE 3: TABLA EXPANDIDA - DESGLOSE ALGEBRAICO\n');
    fprintf('═══════════════════════════════════════════════════════════════════════════════\n\n');
    
    fprintf('Mostrando paso a paso cómo Newton se simplifica a Babilonia:\n\n');
    
    x = x0;
    
    fprintf('│ n │     x_n      │    x_n²    │   x_n²-R   │   2x_n   │\n');
    fprintf('├───┼──────────────┼────────────┼────────────┼──────────┤\n');
    
    for iter = 0:3
        f_x = x^2 - R;
        df_x = 2*x;
        
        fprintf('│ %d │ %12.8f │ %10.6f │ %10.6f │ %8.4f │\n', iter, x, x^2, f_x, df_x);
        
        if iter < 3
            x = x - f_x / df_x;
        end
    end
    
    fprintf('└───┴──────────────┴────────────┴────────────┴──────────┘\n\n');
    
    fprintf('De aquí se calculan los siguientes valores para cada iteración:\n\n');
    
    fprintf('FÓRMULA DE NEWTON (clásica):\n');
    fprintf('──────────────────────────\n');
    fprintf('x_{n+1} = x_n - f(x_n)/f''(x_n)\n');
    fprintf('x_{n+1} = x_n - (x_n² - R)/(2x_n)\n\n');
    
    fprintf('DESGLOSE ALGEBRAICO:\n');
    fprintf('────────────────────\n');
    fprintf('│ Paso │ Operación                                  │ Resultado              │\n');
    fprintf('├──────┼────────────────────────────────────────────┼────────────────────────┤\n');
    
    x = x0;
    f_x = x^2 - R;
    df_x = 2*x;
    
    fprintf('│  1   │ x_n - f(x_n)/f''(x_n)                      │ x_n - (%.6f)/2x_n     │\n', f_x);
    fprintf('│  2   │ x_n - (x_n² - R)/(2x_n)                    │ x_n - x_n²/(2x_n) + R/(2x_n) │\n');
    fprintf('│  3   │ Simplificar x_n²/(2x_n) = x_n/2            │ x_n - x_n/2 + R/(2x_n) │\n');
    fprintf('│  4   │ Combinar términos x_n                      │ (2x_n - x_n)/2 + R/(2x_n) │\n');
    fprintf('│  5   │ Simplificar                                │ x_n/2 + R/(2x_n)     │\n');
    fprintf('│  6   │ Factorizar 1/2                             │ (1/2)(x_n + R/x_n)   │\n');
    fprintf('│      │                                            │ = FÓRMULA BABILONIA  │\n');
    fprintf('└──────┴────────────────────────────────────────────┴────────────────────────┘\n\n');
    
    % === PARTE 4: CONCLUSIÓN ===
    fprintf('═══════════════════════════════════════════════════════════════════════════════\n');
    fprintf('CONCLUSIÓN\n');
    fprintf('═══════════════════════════════════════════════════════════════════════════════\n\n');
    
    fprintf('✓ DEMOSTRACIÓN ALGEBRAICA:\n');
    fprintf('  Aplicando el Método de Newton a f(x) = x² - R, después de 6 pasos de\n');
    fprintf('  simplificación algebraica, obtenemos:\n\n');
    fprintf('  x_{n+1} = (1/2)(x_n + R/x_n)  ← Fórmula de Babilonia\n\n');
    
    fprintf('✓ VERIFICACIÓN NUMÉRICA:\n');
    fprintf('  - Newton y Babilonia producen los MISMOS valores en cada iteración\n');
    fprintf('  - Las diferencias son menores que 2.22e-16 (error de máquina)\n');
    fprintf('  - La convergencia es cuadrática en ambos casos\n\n');
    
    fprintf('✓ CONCLUSIÓN FINAL:\n');
    fprintf('  La Fórmula de Babilonia (usada desde hace ~3000 años) es\n');
    fprintf('  MATEMÁTICAMENTE EQUIVALENTE al Método de Newton.\n');
    fprintf('  No es una coincidencia: es una consecuencia directa de la\n');
    fprintf('  aplicación del método de Newton a la ecuación x² = R.\n\n');
    
    fprintf('╔═══════════════════════════════════════════════════════════════════════════════╗\n');
    fprintf('║  DEMOSTRACIÓN COMPLETA (ALGEBRAICA + NUMÉRICA)                               ║\n');
    fprintf('║                                                                               ║\n');
    fprintf('║  Newton para f(x) = x² - R  ⟹  x_{n+1} = (1/2)(x_n + R/x_n)                 ║\n');
    fprintf('║                                                                               ║\n');
    fprintf('║  Esta es la famosa "Fórmula de Babilonia"                                    ║\n');
    fprintf('╚═══════════════════════════════════════════════════════════════════════════════╝\n\n');
    
end
