function ejemplo_paso_a_paso()
    % =========================================================================
    % EJEMPLO PASO A PASO: MÉTODO DE NEWTON PARA RAÍZ CUADRADA
    % =========================================================================
    
    fprintf('\n');
    fprintf('╔═══════════════════════════════════════════════════════════════════════════════╗\n');
    fprintf('║             MÉTODO DE NEWTON PARA RAÍZ CUADRADA - PASO A PASO               ║\n');
    fprintf('╚═══════════════════════════════════════════════════════════════════════════════╝\n\n');
    
    % Parámetros del ejemplo
    R = 10;        % Número del cual queremos hallar la raíz
    x = 3.0;       % Punto inicial
    tol = 1e-6;    % Tolerancia
    
    fprintf('PROBLEMA: Hallar √%d usando el Método de Newton\n', R);
    fprintf('Punto inicial: x₀ = %.1f\n', x);
    fprintf('Tolerancia: %.0e\n\n', tol);
    
    % Iteración 0
    fprintf('═══════════════════════════════════════════════════════════════════════════════\n');
    fprintf('ITERACIÓN 0\n');
    fprintf('───────────\n\n');
    
    fprintf('Valor actual: x₀ = %.10f\n\n', x);
    
    fprintf('Paso 1: Calcular f(x₀) = x₀² - %d\n', R);
    fx = x^2 - R;
    fprintf('  f(%.1f) = (%.1f)² - %d = %.10f\n\n', x, x, R, fx);
    
    fprintf("Paso 2: Calcular f'(x₀) = 2x₀\n");
    dfx = 2 * x;
    fprintf("  f'(%.1f) = 2 × %.1f = %.10f\n\n", x, x, dfx);
    
    fprintf('Paso 3: Aplicar Newton: x₁ = x₀ - f(x₀)/f''(x₀)\n');
    fprintf('  x₁ = %.10f - (%.10f)/(%.10f)\n', x, fx, dfx);
    x1 = x - fx / dfx;
    fprintf('  x₁ = %.10f\n\n', x1);
    
    fprintf('Paso 4: Calcular error: |x₁ - x₀|\n');
    error = abs(x1 - x);
    fprintf('  Error = |%.10f - %.10f| = %.10f\n\n', x1, x, error);
    
    fprintf('Verificación con fórmula de Babilonia:\n');
    x1_bab = 0.5 * (x + R / x);
    fprintf('  x₁ = (1/2)(x₀ + R/x₀) = (1/2)(%.1f + %d/%.1f)\n', x, R, x);
    fprintf('  x₁ = (1/2)(%.1f + %.6f) = %.10f\n\n', x, R/x, x1_bab);
    
    % Iteración 1
    fprintf('═══════════════════════════════════════════════════════════════════════════════\n');
    fprintf('ITERACIÓN 1\n');
    fprintf('───────────\n\n');
    
    x = x1;
    fprintf('Valor actual: x₁ = %.10f\n\n', x);
    
    fprintf('f(x₁) = (%.10f)² - %d = %.10f\n', x, R, x^2 - R);
    fx = x^2 - R;
    
    fprintf("f'(x₁) = 2 × %.10f = %.10f\n\n", x, 2*x);
    dfx = 2 * x;
    
    fprintf('x₂ = x₁ - f(x₁)/f''(x₁)\n');
    fprintf('x₂ = %.10f - (%.10f)/(%.10f)\n', x, fx, dfx);
    x2 = x - fx / dfx;
    fprintf('x₂ = %.10f\n\n', x2);
    
    error = abs(x2 - x);
    fprintf('Error = |%.10f - %.10f| = %.10f\n\n', x2, x, error);
    
    % Iteración 2
    fprintf('═══════════════════════════════════════════════════════════════════════════════\n');
    fprintf('ITERACIÓN 2\n');
    fprintf('───────────\n\n');
    
    x = x2;
    fprintf('Valor actual: x₂ = %.10f\n\n', x);
    
    fprintf('f(x₂) = %.10f\n', x^2 - R);
    fx = x^2 - R;
    
    fprintf("f'(x₂) = %.10f\n\n", 2*x);
    dfx = 2 * x;
    
    fprintf('x₃ = %.10f - (%.10f)/(%.10f)\n', x, fx, dfx);
    x3 = x - fx / dfx;
    fprintf('x₃ = %.10f\n\n', x3);
    
    error = abs(x3 - x);
    fprintf('Error = %.10f\n\n', error);
    
    % Resumen
    fprintf('═══════════════════════════════════════════════════════════════════════════════\n');
    fprintf('RESUMEN DE CONVERGENCIA\n');
    fprintf('───────────────────────\n\n');
    
    fprintf('│ Iteración │        x_n        │  Error absoluto  │  Cifras correctas  │\n');
    fprintf('├───────────┼──────────────────┼──────────────────┼──────────────────┤\n');
    
    valores_exactos = [3.0, x1, x2, x3];
    valor_real = sqrt(R);
    
    for i = 0:3
        x_i = valores_exactos(i+1);
        err_abs = abs(x_i - valor_real);
        
        if err_abs < 1e-15
            cifras_correctas = 15;
        else
            cifras_correctas = max(0, floor(-log10(err_abs)));
        end
        
        fprintf('│ %9d │ %18.15f │ %18.3e │ %18d │\n', ...
                i, x_i, err_abs, cifras_correctas);
    end
    
    fprintf('├───────────┴──────────────────┴──────────────────┴──────────────────┤\n');
    fprintf('│ Valor exacto: √%d = %.15f\n', R, valor_real);
    fprintf('└─────────────────────────────────────────────────────────────────────┘\n\n');
    
    fprintf('OBSERVACIONES:\n');
    fprintf('──────────────\n');
    fprintf('1. Convergencia cuadrática: Los dígitos correctos se duplican cada iteración\n');
    fprintf('   - Iteración 0: ~1 cifra correcta\n');
    fprintf('   - Iteración 1: ~3 cifras correctas\n');
    fprintf('   - Iteración 2: ~6 cifras correctas\n');
    fprintf('   - Iteración 3: ~12 cifras correctas\n\n');
    
    fprintf('2. La fórmula simplificada de Newton (Babilonia) es:\n');
    fprintf('   xₙ₊₁ = (1/2)(xₙ + R/xₙ)\n\n');
    
    fprintf('3. Esta fórmula es numéricamente estable y muy eficiente\n');
    fprintf('   para calcular raíces cuadradas.\n\n');
    
end
