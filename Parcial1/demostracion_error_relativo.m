function demostracion_error_relativo()
    % =========================================================================
    % DEMOSTRACIÓN: ERROR RELATIVO Y CONVERGENCIA CUADRÁTICA
    % =========================================================================
    % Mostrar que para el Método de Newton en raíces cuadradas:
    %
    %       (e_{n+1})/√R = (e_n/√R)² * √R/(2x_n)
    %
    % Esto demuestra que el error RELATIVO también es cuadrático
    % =========================================================================
    
    fprintf('\n');
    fprintf('╔═══════════════════════════════════════════════════════════════════════════════╗\n');
    fprintf('║      DEMOSTRACIÓN: ERROR RELATIVO Y CONVERGENCIA CUADRÁTICA                  ║\n');
    fprintf('║                                                                               ║\n');
    fprintf('║  Fórmula: (e_{n+1})/√R = (e_n/√R)² * √R/(2x_n)                             ║\n');
    fprintf('║  donde:   e_n = x_n - √R   (error absoluto)                                 ║\n');
    fprintf('╚═══════════════════════════════════════════════════════════════════════════════╝\n\n');
    
    % === PARTE 1: DEMOSTRACIÓN ALGEBRAICA ===
    fprintf('═══════════════════════════════════════════════════════════════════════════════\n');
    fprintf('PARTE 1: DEMOSTRACIÓN ALGEBRAICA\n');
    fprintf('═══════════════════════════════════════════════════════════════════════════════\n\n');
    
    fprintf('Partimos de la fórmula de error absoluto ya demostrada:\n\n');
    fprintf('  e_{n+1} = e_n² / (2x_n)  ... (1)\n\n');
    
    fprintf('PASO 1: Dividir ambos lados por √R\n');
    fprintf('────────────────────────────────\n');
    fprintf('  e_{n+1}/√R = (e_n²/(2x_n)) / √R\n');
    fprintf('  e_{n+1}/√R = e_n² / (2x_n√R)  ... (2)\n\n');
    
    fprintf('PASO 2: Reescribir el numerador como (e_n/√R)²\n');
    fprintf('──────────────────────────────────────────\n');
    fprintf('Sabemos que:  (e_n/√R)² = e_n² / R\n\n');
    fprintf('Por lo tanto: e_n² = (e_n/√R)² * R\n\n');
    
    fprintf('PASO 3: Sustituir en la ecuación (2)\n');
    fprintf('───────────────────────────────────\n');
    fprintf('  e_{n+1}/√R = ((e_n/√R)² * R) / (2x_n√R)\n');
    fprintf('  e_{n+1}/√R = (e_n/√R)² * (R / (2x_n√R))\n');
    fprintf('  e_{n+1}/√R = (e_n/√R)² * (√R * √R) / (2x_n√R)\n');
    fprintf('  e_{n+1}/√R = (e_n/√R)² * √R / (2x_n)  ... (3)\n\n');
    
    fprintf('╔═══════════════════════════════════════════════════════════════════════════════╗\n');
    fprintf('║                    ✓ FÓRMULA DEMOSTRADA:                                     ║\n');
    fprintf('║                                                                               ║\n');
    fprintf('║              (e_{n+1})/√R = (e_n/√R)² * √R/(2x_n)                          ║\n');
    fprintf('╚═══════════════════════════════════════════════════════════════════════════════╝\n\n');
    
    fprintf('INTERPRETACIÓN:\n');
    fprintf('────────────────\n');
    fprintf('• El lado izquierdo (e_{n+1})/√R es el ERROR RELATIVO en la iteración n+1\n');
    fprintf('• El primer factor (e_n/√R)² es el CUADRADO del error relativo anterior\n');
    fprintf('• El segundo factor √R/(2x_n) es un factor de ajuste (casi constante)\n\n');
    
    % === PARTE 2: VERIFICACIÓN NUMÉRICA ===
    fprintf('═══════════════════════════════════════════════════════════════════════════════\n');
    fprintf('PARTE 2: VERIFICACIÓN NUMÉRICA\n');
    fprintf('═══════════════════════════════════════════════════════════════════════════════\n\n');
    
    R = 10;
    x = 3.0;
    raiz_exacta = sqrt(R);
    
    fprintf('Calculando √%d con punto inicial x₀ = %.2f\n', R, x);
    fprintf('Valor exacto: √%d = %.15f\n\n', R, raiz_exacta);
    
    % Tabla de verificación
    fprintf('TABLA: Verificación de la fórmula\n');
    fprintf('─────────────────────────────────\n\n');
    
    fprintf('│ n │    e_n (error abs) │  e_n/√R (error rel) │ (e_n/√R)² │ √R/(2x_n) │');
    fprintf(' Predicción     │   Real (e_{n+1}/√R) │   Razón   │\n');
    fprintf('├───┼────────────────────┼─────────────────────┼───────────┼───────────┼');
    fprintf('────────────────┼─────────────────────┼───────────┤\n');
    
    errores_abs = [];
    errores_rel = [];
    
    for iter = 0:5
        % Error absoluto
        e_n = x - raiz_exacta;
        errores_abs = [errores_abs; e_n];
        
        % Error relativo
        e_n_rel = e_n / raiz_exacta;
        errores_rel = [errores_rel; e_n_rel];
        
        % Componentes de la fórmula
        e_n_rel_squared = e_n_rel^2;
        factor_sqrt = sqrt(R) / (2*x);
        prediccion = e_n_rel_squared * factor_sqrt;
        
        % Calcular siguiente iterado
        f_x = x^2 - R;
        df_x = 2*x;
        x_siguiente = x - f_x / df_x;
        
        % Error siguiente
        e_siguiente = x_siguiente - raiz_exacta;
        e_siguiente_rel = e_siguiente / raiz_exacta;
        
        % Razón
        if abs(prediccion) > 1e-20
            razon = e_siguiente_rel / prediccion;
        else
            razon = 0;
        end
        
        fprintf('│ %d │ %18.6e │ %19.6e │ %9.3e │ %9.6f │ %14.6e │ %19.6e │ %9.4f │\n', ...
                iter, e_n, e_n_rel, e_n_rel_squared, factor_sqrt, prediccion, ...
                e_siguiente_rel, razon);
        
        x = x_siguiente;
    end
    
    fprintf('├───┴────────────────────┴─────────────────────┴───────────┴───────────┴');
    fprintf('────────────────┴─────────────────────┴───────────┤\n');
    fprintf('│ Observe: Las columnas "Predicción" y "Real" coinciden casi perfectamente   │\n');
    fprintf('│ La "Razón" está muy cerca de 1.0 (pequeñas variaciones por redondeo)       │\n');
    fprintf('└─────────────────────────────────────────────────────────────────────────────┘\n\n');
    
    % === PARTE 3: ANÁLISIS DEL ERROR RELATIVO ===
    fprintf('═══════════════════════════════════════════════════════════════════════════════\n');
    fprintf('PARTE 3: ANÁLISIS DETALLADO - CONVERGENCIA DEL ERROR RELATIVO\n');
    fprintf('═══════════════════════════════════════════════════════════════════════════════\n\n');
    
    fprintf('La fórmula (e_{n+1})/√R = (e_n/√R)² * √R/(2x_n) muestra que:\n\n');
    
    fprintf('1. ERROR RELATIVO AL CUADRADO:\n');
    fprintf('   El error relativo se eleva al cuadrado en cada iteración\n');
    fprintf('   (e_{n+1}/√R) ∝ (e_n/√R)²\n\n');
    
    fprintf('2. FACTOR DE NORMALIZACIÓN:\n');
    fprintf('   El factor √R/(2x_n) es aproximadamente √R/(2√R) = 1/2 cerca de la raíz\n');
    fprintf('   Por lo tanto: (e_{n+1})/√R ≈ (1/2) * (e_n/√R)²\n\n');
    
    fprintf('3. CONVERGENCIA CUADRÁTICA:\n');
    fprintf('   Si denotamos δ_n = e_n/√R (error relativo), entonces:\n');
    fprintf('   δ_{n+1} ≈ (1/2) * δ_n²\n\n');
    
    fprintf('   Esto significa que δ_n se reduce a δ_n² en cada paso,\n');
    fprintf('   lo cual es CONVERGENCIA CUADRÁTICA.\n\n');
    
    % Tabla de convergencia del error relativo
    fprintf('\n');
    fprintf('TABLA: Convergencia del error relativo delta_n = e_n / sqrt(R)\n');
    fprintf('-----------------------------------------------------------\n\n');
    fprintf('  n     error_rel         log10(delta)   cifras_exactas\n');
    fprintf('---   ----------------  ----------------  ----------------\n');
    
    for i = 1:min(5, length(errores_rel))
        delta_n = errores_rel(i);
        
        if abs(delta_n) > 1e-15
            log_delta = log10(abs(delta_n));
            cifras_exactas = max(0, floor(-log_delta));
        else
            log_delta = -15;
            cifras_exactas = 15;
        end
        
        fprintf('  %d     %.4e         %.4f          %d\n', ...
                i-1, delta_n, log_delta, cifras_exactas);
    end
    
    fprintf('---   ----------------  ----------------  ----------------\n');
    fprintf('Observe: El error relativo se reduce exponencialmente\n');
    fprintf('         Las cifras exactas se duplican en cada iteracion\n\n');
    
    % === PARTE 4: EQUIVALENCIA CON FÓRMULA ANTERIOR ===
    fprintf('═══════════════════════════════════════════════════════════════════════════════\n');
    fprintf('PARTE 4: RELACIÓN CON LA FÓRMULA DE ERROR ABSOLUTO\n');
    fprintf('═══════════════════════════════════════════════════════════════════════════════\n\n');
    
    fprintf('Tenemos dos formas equivalentes de expresar la convergencia:\n\n');
    
    fprintf('FORMA 1 - ERROR ABSOLUTO:\n');
    fprintf('─────────────────────────\n');
    fprintf('  e_{n+1} = e_n² / (2x_n)\n\n');
    
    fprintf('FORMA 2 - ERROR RELATIVO:\n');
    fprintf('─────────────────────────\n');
    fprintf('  (e_{n+1})/√R = (e_n/√R)² * √R/(2x_n)\n\n');
    
    fprintf('RELACIÓN:\n');
    fprintf('─────────\n');
    fprintf('Dividiendo la Forma 1 por √R:\n');
    fprintf('  (e_{n+1})/√R = (e_n²/(2x_n)) / √R\n');
    fprintf('               = (e_n²/R) * (√R/(2x_n))\n');
    fprintf('               = (e_n/√R)² * √R/(2x_n)  ← Forma 2\n\n');
    
    fprintf('Ambas formas son EQUIVALENTES. La elección depende del contexto:\n');
    fprintf('• Forma 1: útil para análisis de convergencia absoluta\n');
    fprintf('• Forma 2: útil para análisis de convergencia relativa\n\n');
    
    % === CONCLUSIÓN ===
    fprintf('═══════════════════════════════════════════════════════════════════════════════\n');
    fprintf('CONCLUSIÓN\n');
    fprintf('═══════════════════════════════════════════════════════════════════════════════\n\n');
    
    fprintf('✓ Se ha demostrado que:\n\n');
    fprintf('  (e_{n+1})/√R = (e_n/√R)² * √R/(2x_n)\n\n');
    
    fprintf('✓ Esta fórmula muestra:\n');
    fprintf('  - Convergencia CUADRÁTICA del error relativo\n');
    fprintf('  - El error relativo se eleva al cuadrado cada iteración\n');
    fprintf('  - Equivalencia con la fórmula de error absoluto\n\n');
    
    fprintf('✓ Implicaciones prácticas:\n');
    fprintf('  - Cifras significativas se duplican/triplican cada iteración\n');
    fprintf('  - Máxima precisión alcanzada en ~5 iteraciones\n');
    fprintf('  - Método es EXTRAORDINARIAMENTE EFICIENTE\n\n');
    
    fprintf('╔═══════════════════════════════════════════════════════════════════════════════╗\n');
    fprintf('║  CONVERGENCIA CUADRÁTICA COMPROBADA (Error Relativo)                         ║\n');
    fprintf('║                                                                               ║\n');
    fprintf('║  (e_{n+1})/√R = (e_n/√R)² * √R/(2x_n)                                       ║\n');
    fprintf('║                                                                               ║\n');
    fprintf('║  Esta es una propiedad fundamental del Método de Newton                      ║\n');
    fprintf('╚═══════════════════════════════════════════════════════════════════════════════╝\n\n');
    
end
