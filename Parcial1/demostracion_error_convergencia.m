function demostracion_error_convergencia()
    % =========================================================================
    % DEMOSTRACIÓN: CONVERGENCIA CUADRÁTICA DEL ERROR
    % =========================================================================
    % Mostrar que para el Método de Newton en raíces cuadradas:
    %
    %       e_{n+1} = e_n² / (2x_n)
    %
    % donde e_n = x_n - √R es el error en la iteración n
    %
    % Esta fórmula demuestra la CONVERGENCIA CUADRÁTICA del método
    % =========================================================================
    
    fprintf('\n');
    fprintf('╔═══════════════════════════════════════════════════════════════════════════════╗\n');
    fprintf('║         DEMOSTRACIÓN: CONVERGENCIA CUADRÁTICA DEL ERROR                      ║\n');
    fprintf('║                                                                               ║\n');
    fprintf('║  Fórmula:  e_{n+1} = e_n² / (2x_n)                                           ║\n');
    fprintf('║  donde:    e_n = x_n - √R (error en la iteración n)                          ║\n');
    fprintf('╚═══════════════════════════════════════════════════════════════════════════════╝\n\n');
    
    % === PARTE 1: DEMOSTRACIÓN ALGEBRAICA ===
    fprintf('═══════════════════════════════════════════════════════════════════════════════\n');
    fprintf('PARTE 1: DEMOSTRACIÓN ALGEBRAICA\n');
    fprintf('═══════════════════════════════════════════════════════════════════════════════\n\n');
    
    fprintf('PASO 1: Definir el error\n');
    fprintf('───────────────────────\n');
    fprintf('Definimos el error en la iteración n como:\n');
    fprintf('  e_n = x_n - √R\n');
    fprintf('  Entonces: x_n = √R + e_n\n\n');
    
    fprintf('PASO 2: Sabemos que\n');
    fprintf('────────────────────\n');
    fprintf('Del método de Newton-Babilonia:\n');
    fprintf('  x_{n+1} = (1/2)(x_n + R/x_n)\n\n');
    
    fprintf('PASO 3: Calcular el error en la siguiente iteración\n');
    fprintf('─────────────────────────────────────────────────\n');
    fprintf('e_{n+1} = x_{n+1} - √R\n\n');
    
    fprintf('e_{n+1} = (1/2)(x_n + R/x_n) - √R\n');
    fprintf('        = (1/2)x_n + R/(2x_n) - √R\n');
    fprintf('        = (1/2)(√R + e_n) + R/(2(√R + e_n)) - √R\n');
    fprintf('        = (1/2)√R + (1/2)e_n + R/(2(√R + e_n)) - √R\n');
    fprintf('        = -(1/2)√R + (1/2)e_n + R/(2(√R + e_n))  ... (1)\n\n');
    
    fprintf('PASO 4: Multiplicar ambos lados por 2(√R + e_n)\n');
    fprintf('──────────────────────────────────────────────\n');
    fprintf('2(√R + e_n)·e_{n+1} = 2(√R + e_n)·[-(1/2)√R + (1/2)e_n + R/(2(√R + e_n))]\n\n');
    
    fprintf('2(√R + e_n)·e_{n+1} = -(√R + e_n)·√R + (√R + e_n)·e_n + R\n\n');
    
    fprintf('Expandiendo el primer término:\n');
    fprintf('  -(√R + e_n)·√R = -R - √R·e_n\n\n');
    
    fprintf('Expandiendo el segundo término:\n');
    fprintf('  (√R + e_n)·e_n = √R·e_n + e_n²\n\n');
    
    fprintf('Sustituyendo:\n');
    fprintf('2(√R + e_n)·e_{n+1} = -R - √R·e_n + √R·e_n + e_n² + R\n');
    fprintf('2(√R + e_n)·e_{n+1} = e_n²\n\n');
    
    fprintf('PASO 5: Despejar e_{n+1}\n');
    fprintf('───────────────────────\n');
    fprintf('e_{n+1} = e_n² / (2(√R + e_n))\n');
    fprintf('e_{n+1} = e_n² / (2x_n)      [ya que x_n = √R + e_n]\n\n');
    
    fprintf('╔═══════════════════════════════════════════════════════════════════════════════╗\n');
    fprintf('║                    ✓ FÓRMULA DEMOSTRADA:                                     ║\n');
    fprintf('║                                                                               ║\n');
    fprintf('║                       e_{n+1} = e_n² / (2x_n)                                ║\n');
    fprintf('╚═══════════════════════════════════════════════════════════════════════════════╝\n\n');
    
    % === PARTE 2: VERIFICACIÓN NUMÉRICA ===
    fprintf('═══════════════════════════════════════════════════════════════════════════════\n');
    fprintf('PARTE 2: VERIFICACIÓN NUMÉRICA\n');
    fprintf('═══════════════════════════════════════════════════════════════════════════════\n\n');
    
    % Parámetros
    R = 10;
    x = 3.0;  % Punto inicial
    valor_exacto = sqrt(R);
    
    fprintf('Calculando √%d usando Newton\n', R);
    fprintf('Punto inicial: x₀ = %.10f\n', x);
    fprintf('Valor exacto: √%d = %.15f\n\n', R, valor_exacto);
    
    fprintf('│ Iter │     x_n      │     √R      │     e_n      │  e_n²/(2x_n) │  e_{n+1}  │  Estado    │\n');
    fprintf('├──────┼──────────────┼─────────────┼──────────────┼──────────────┼───────────┼────────────┤\n');
    
    errores = [];
    x_valores = [];
    razones = [];
    epsilon_maquina = eps;  % Precisión de máquina (~2.22e-16)
    
    for iter = 0:5
        % Error actual
        e_n = x - valor_exacto;
        errores = [errores; e_n];
        x_valores = [x_valores; x];
        
        % Predicción del error siguiente usando la fórmula
        if abs(e_n) > 1e-15
            e_siguiente_predicho = e_n^2 / (2*x);
        else
            e_siguiente_predicho = 0;
        end
        
        % Siguiente iterado usando Newton
        f_x = x^2 - R;
        df_x = 2*x;
        x_siguiente = x - f_x / df_x;
        
        % Error real siguiente
        e_siguiente_real = x_siguiente - valor_exacto;
        
        % Determinar el estado
        if abs(e_siguiente_real) < epsilon_maquina * 100
            estado = 'Límite eps';
        else
            estado = 'Normal';
        end
        
        % Razón de errores (debería ser ~1)
        if abs(e_siguiente_predicho) > 1e-20
            razon = e_siguiente_real / e_siguiente_predicho;
            razones = [razones; razon];
        end
        
        fprintf('│ %4d │ %12.10f │ %11.10f │ %12.3e │ %12.3e │ %9.3e │ %-10s │\n', ...
                iter, x, valor_exacto, e_n, e_siguiente_predicho, e_siguiente_real, estado);
        
        x = x_siguiente;
    end
    
    fprintf('├──────┴──────────────┴─────────────┴──────────────┴──────────────┴───────────┴────────────┤\n');
    fprintf('│ Nota: "Límite eps" indica que hemos alcanzado el límite de precisión de máquina        │\n');
    fprintf('│ (epsilon ≈ 2.22e-16). Los valores menores que esto son ruido numérico.                │\n');
    fprintf('└────────────────────────────────────────────────────────────────────────────────────────┘\n\n');
    
    % === PARTE 3: ANÁLISIS DE CONVERGENCIA ===
    fprintf('═══════════════════════════════════════════════════════════════════════════════\n');
    fprintf('ACLARACIÓN: EPSILON DE MÁQUINA\n');
    fprintf('═══════════════════════════════════════════════════════════════════════════════\n\n');
    
    fprintf('Epsilon de máquina (precisión numérica): %.2e\n', epsilon_maquina);
    fprintf('(Este es el número positivo más pequeño que puede representarse)\n\n');
    
    fprintf('En las iteraciones finales:\n');
    fprintf('- El error calculado es TAN PEQUEÑO que es comparable con epsilon\n');
    fprintf('- La predicción e_n²/(2x_n) ≈ 3.383e-25 es MUCHO MENOR que epsilon\n');
    fprintf('- El error real e_{n+1} se redondea a 0 por limitación de máquina\n\n');
    
    fprintf('ESTO NO ES UN ERROR DEL MÉTODO, sino un LÍMITE DE LA PRECISIÓN NUMÉRICA\n');
    fprintf('El método es perfecto, solo que la computadora no puede representar\n');
    fprintf('números tan pequeños como 1e-25.\n\n');
    
    fprintf('═══════════════════════════════════════════════════════════════════════════════\n');
    
    fprintf('═══════════════════════════════════════════════════════════════════════════════\n');
    fprintf('PARTE 3: CONVERGENCIA CUADRÁTICA - ANÁLISIS DEL ERROR\n');
    fprintf('═══════════════════════════════════════════════════════════════════════════════\n\n');
    
    fprintf('1. El error en cada iteración es CUADRÁTICO en el error anterior\n');
    fprintf('   (proporcional al cuadrado del error anterior)\n\n');
    
    fprintf('2. El factor 1/(2x_n) es aproximadamente 1/(2√R)\n');
    fprintf('   (casi constante cerca de la raíz)\n\n');
    
    fprintf('3. Por lo tanto:\n');
    fprintf('   |e_{n+1}| ≈ |e_n|² / (2√R)\n\n');
    
    fprintf('VERIFICACIÓN - Razón de cifras correctas\n');
    fprintf('────────────────────────────────────────\n');
    fprintf('Si el error se reduce como e_{n+1} ~ e_n², entonces el número de\n');
    fprintf('dígitos correctos debería duplicarse aproximadamente.\n\n');
    
    fprintf('│ Iter │  |e_n|      │  Log₁₀|e_n| │ Cifras correctas │ Predicción │\n');
    fprintf('├──────┼────────────┼──────────────┼──────────────────┼────────────┤\n');
    
    for i = 1:length(errores)
        e_abs = abs(errores(i));
        if e_abs > 1e-15
            log_e = log10(e_abs);
            cifras_correctas = max(0, floor(-log_e));
        else
            log_e = -15;
            cifras_correctas = 15;
        end
        
        if i > 1
            % Predicción basada en cuadratura del error anterior
            e_abs_ant = abs(errores(i-1));
            prediccion = max(0, floor(-log10(e_abs_ant^2 / (2*sqrt(R)))));
        else
            prediccion = 0;
        end
        
        fprintf('│ %4d │ %10.3e │ %12.2f │ %16d │ %10d │\n', ...
                i-1, e_abs, log_e, cifras_correctas, prediccion);
    end
    
    fprintf('├──────┴────────────┴──────────────┴──────────────────┴────────────┤\n');
    fprintf('│ Observe cómo el número de cifras correctas se duplica/triplica    │\n');
    fprintf('│ en cada iteración: CONVERGENCIA CUADRÁTICA                        │\n');
    fprintf('└────────────────────────────────────────────────────────────────────┘\n\n');
    
    % === PARTE 4: CONCLUSIÓN ===
    fprintf('═══════════════════════════════════════════════════════════════════════════════\n');
    fprintf('CONCLUSIÓN\n');
    fprintf('═══════════════════════════════════════════════════════════════════════════════\n\n');
    
    fprintf('✓ Se ha demostrado algebraicamente que:\n\n');
    fprintf('   e_{n+1} = e_n² / (2x_n)\n\n');
    
    fprintf('✓ Esta fórmula ha sido verificada numéricamente\n\n');
    
    fprintf('✓ Implicaciones:\n');
    fprintf('  - Convergencia CUADRÁTICA (muy rápida)\n');
    fprintf('  - El error se reduce exponencialmente: |e_n| ~ c^(2^n)\n');
    fprintf('  - Número de cifras correctas se duplica cada iteración\n');
    fprintf('  - Máxima precisión alcanzada en muy pocas iteraciones\n\n');
    
    fprintf('╔═══════════════════════════════════════════════════════════════════════════════╗\n');
    fprintf('║  Esta es la razón por la que el Método de Newton es tan eficiente            ║\n');
    fprintf('║  para calcular raíces cuadradas (y resolver ecuaciones en general)            ║\n');
    fprintf('╚═══════════════════════════════════════════════════════════════════════════════╝\n\n');
    
end
