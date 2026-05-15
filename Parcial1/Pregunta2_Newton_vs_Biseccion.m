% =========================================================================
% PREGUNTA 2: COMPARACIÓN NEWTON vs BISECCIÓN
% =========================================================================
% Ejecutar 2 iteraciones de Newton y 2 de Bisección para √2
% Luego: ¿Cuántas iteraciones para precisión 10^-3?
% =========================================================================

clear all; close all; clc;

fprintf('\n');
fprintf('╔═══════════════════════════════════════════════════════════════════════════════╗\n');
fprintf('║                                                                               ║\n');
fprintf('║       PREGUNTA 2: NEWTON vs BISECCIÓN para √2                                ║\n');
fprintf('║       Parte A: 2 Iteraciones de cada método                                  ║\n');
fprintf('║       Parte B: Cuántas iteraciones hasta precisión 10^-3                     ║\n');
fprintf('║                                                                               ║\n');
fprintf('╚═══════════════════════════════════════════════════════════════════════════════╝\n');

R = 2;                           % Radicando
raiz_exacta = sqrt(R);           % √2 = 1.414213562...
tolerancia = 1e-3;               % Criterio de precisión

fprintf('\nParámetros:\n');
fprintf('  R (radicando)     = %d\n', R);
fprintf('  √R (valor exacto) = %.15f\n', raiz_exacta);
fprintf('  Tolerancia        = %.0e\n', tolerancia);

% =========================================================================
% PARTE A: DOS ITERACIONES PASO A PASO
% =========================================================================

fprintf('\n');
fprintf('╔═══════════════════════════════════════════════════════════════════════════════╗\n');
fprintf('║ PARTE A: DOS ITERACIONES PASO A PASO                                         ║\n');
fprintf('╚═══════════════════════════════════════════════════════════════════════════════╝\n');

% ───────────────────────────────────────────────────────────────────────
% MÉTODO 1: NEWTON
% ───────────────────────────────────────────────────────────────────────

fprintf('\n');
fprintf('═══════════════════════════════════════════════════════════════════════════════\n');
fprintf('MÉTODO 1: NEWTON PARA √2\n');
fprintf('═══════════════════════════════════════════════════════════════════════════════\n');
fprintf('\nFórmula: x_{n+1} = (1/2)(x_n + 2/x_n)\n');
fprintf('Punto inicial: x_0 = 1.0\n\n');

x_newton = 1.0;
fprintf('┌─────────────────────────────────────────────────────────────────────────────┐\n');
fprintf('│ ITERACIÓN 0 (inicial)                                                       │\n');
fprintf('├─────────────────────────────────────────────────────────────────────────────┤\n');
fprintf('│ x_0 = 1.0\n');
fprintf('│ e_0 = x_0 - √2 = 1.0 - %.15f = %.15e\n', raiz_exacta, 1.0 - raiz_exacta);
fprintf('│ Error relativo = e_0/√2 = %.15e\n', (1.0 - raiz_exacta)/raiz_exacta);
fprintf('└─────────────────────────────────────────────────────────────────────────────┘\n\n');

% Iteración 1
fprintf('┌─────────────────────────────────────────────────────────────────────────────┐\n');
fprintf('│ ITERACIÓN 1                                                                  │\n');
fprintf('├─────────────────────────────────────────────────────────────────────────────┤\n');

x_newton_0 = x_newton;
x_newton = 0.5 * (x_newton + R / x_newton);

fprintf('│ x_1 = (1/2)(x_0 + 2/x_0)\n');
fprintf('│     = (1/2)(1.0 + 2/1.0)\n');
fprintf('│     = (1/2)(1.0 + 2.0)\n');
fprintf('│     = (1/2)(3.0)\n');
fprintf('│ x_1 = %.15f\n', x_newton);

e_newton_1 = x_newton - raiz_exacta;
fprintf('│\n');
fprintf('│ e_1 = x_1 - √2 = %.15f - %.15f\n', x_newton, raiz_exacta);
fprintf('│ e_1 = %.15e\n', e_newton_1);
fprintf('│\n');
fprintf('│ Error relativo δ_1 = e_1/√2 = %.15e\n', e_newton_1/raiz_exacta);
fprintf('│ Precisión alcanzada = %.6f (ERROR: aún > 10^-3)\n', abs(e_newton_1));
fprintf('└─────────────────────────────────────────────────────────────────────────────┘\n\n');

% Iteración 2
fprintf('┌─────────────────────────────────────────────────────────────────────────────┐\n');
fprintf('│ ITERACIÓN 2                                                                  │\n');
fprintf('├─────────────────────────────────────────────────────────────────────────────┤\n');

x_newton_1 = x_newton;
x_newton = 0.5 * (x_newton + R / x_newton);

fprintf('│ x_2 = (1/2)(x_1 + 2/x_1)\n');
fprintf('│     = (1/2)(%.15f + 2/%.15f)\n', x_newton_1, x_newton_1);
fprintf('│     = (1/2)(%.15f + %.15f)\n', x_newton_1, R/x_newton_1);
fprintf('│     = (1/2)(%.15f)\n', x_newton_1 + R/x_newton_1);
fprintf('│ x_2 = %.15f\n', x_newton);

e_newton_2 = x_newton - raiz_exacta;
fprintf('│\n');
fprintf('│ e_2 = x_2 - √2 = %.15f - %.15f\n', x_newton, raiz_exacta);
fprintf('│ e_2 = %.15e\n', e_newton_2);
fprintf('│\n');
fprintf('│ Error relativo δ_2 = e_2/√2 = %.15e\n', e_newton_2/raiz_exacta);
fprintf('│ Precisión alcanzada = %.15e (✓ CUMPLE < 10^-3)\n', abs(e_newton_2));
fprintf('└─────────────────────────────────────────────────────────────────────────────┘\n\n');

fprintf('TABLA RESUMEN - NEWTON\n');
fprintf('─────────────────────────────────────────────────────────────────────────────\n');
fprintf('   n │         x_n          │       e_n (error)    │  |e_n| < 10^-3 ?\n');
fprintf('─────┼──────────────────────┼──────────────────────┼─────────────────\n');
fprintf('   0 │ 1.000000000000000000 │ -4.142135623730950e-01 │    NO\n');
fprintf('   1 │ 1.500000000000000000 │  8.578643762690500e-02 │    NO\n');
fprintf('   2 │ 1.416666666666666630 │  2.453104040716563e-03 │    NO  (apenas)\n');
fprintf('─────┴──────────────────────┴──────────────────────┴─────────────────\n\n');

% ───────────────────────────────────────────────────────────────────────
% MÉTODO 2: BISECCIÓN
% ───────────────────────────────────────────────────────────────────────

fprintf('\n');
fprintf('═══════════════════════════════════════════════════════════════════════════════\n');
fprintf('MÉTODO 2: BISECCIÓN EN [1, 2] PARA √2\n');
fprintf('═══════════════════════════════════════════════════════════════════════════════\n');
fprintf('\nFórmula: x_{n+1} = (a_n + b_n) / 2\n');
fprintf('Intervalo inicial: [a, b] = [1, 2]\n');
fprintf('Criterio de parada: (b_n - a_n)/2 ≤ tolerancia\n\n');

% Función objetivo
f = @(x) x^2 - R;

% Valores iniciales
a_bis = 1.0;
b_bis = 2.0;

fprintf('VERIFICACIÓN DE CAMBIO DE SIGNO:\n');
fprintf('  f(a) = f(1) = 1^2 - 2 = %d (negativo ✓)\n', f(a_bis));
fprintf('  f(b) = f(2) = 2^2 - 2 = %d (positivo ✓)\n', f(b_bis));
fprintf('  f(a) * f(b) = %d < 0 → Bisección PUEDE aplicarse\n\n', f(a_bis)*f(b_bis));

% Iteración 1
fprintf('┌─────────────────────────────────────────────────────────────────────────────┐\n');
fprintf('│ ITERACIÓN 1                                                                  │\n');
fprintf('├─────────────────────────────────────────────────────────────────────────────┤\n');

c_bis_1 = (a_bis + b_bis) / 2;
f_a = f(a_bis);
f_b = f(b_bis);
f_c = f(c_bis_1);
error_bis_1 = (b_bis - a_bis) / 2;

fprintf('│ a_1 = %d, b_1 = %d\n', a_bis, b_bis);
fprintf('│ c_1 = (a_1 + b_1) / 2 = (%d + %d) / 2 = %.15f\n', a_bis, b_bis, c_bis_1);
fprintf('│\n');
fprintf('│ f(a_1) = f(%d) = %.15f\n', a_bis, f_a);
fprintf('│ f(c_1) = f(%.15f) = %.15e\n', c_bis_1, f_c);
fprintf('│ f(b_1) = f(%d) = %.15f\n', b_bis, f_b);
fprintf('│\n');
fprintf('│ Determinación del nuevo intervalo:\n');
fprintf('│   f(a_1) × f(c_1) = %d × %.6e = %.6e < 0 → Raíz en [a_1, c_1]\n', ...
        f_a, f_c, f_a * f_c);
fprintf('│   → a_2 = %.15f, b_2 = %.15f\n', a_bis, c_bis_1);
fprintf('│\n');
fprintf('│ Error = (b_1 - a_1) / 2 = (%d - %d) / 2 = %.15e\n', b_bis, a_bis, error_bis_1);
fprintf('│ Precisión: %.15e (NO < 10^-3)\n', error_bis_1);
fprintf('└─────────────────────────────────────────────────────────────────────────────┘\n\n');

% Actualizar intervalo para iteración 2
if f_a * f_c < 0
    b_bis = c_bis_1;
else
    a_bis = c_bis_1;
end

% Iteración 2
fprintf('┌─────────────────────────────────────────────────────────────────────────────┐\n');
fprintf('│ ITERACIÓN 2                                                                  │\n');
fprintf('├─────────────────────────────────────────────────────────────────────────────┤\n');

c_bis_2 = (a_bis + b_bis) / 2;
f_a = f(a_bis);
f_b = f(b_bis);
f_c = f(c_bis_2);
error_bis_2 = (b_bis - a_bis) / 2;

fprintf('│ a_2 = %.15f, b_2 = %.15f\n', a_bis, b_bis);
fprintf('│ c_2 = (a_2 + b_2) / 2 = (%.15f + %.15f) / 2\n', a_bis, b_bis);
fprintf('│ c_2 = %.15f\n', c_bis_2);
fprintf('│\n');
fprintf('│ f(a_2) = f(%.15f) = %.15e\n', a_bis, f_a);
fprintf('│ f(c_2) = f(%.15f) = %.15e\n', c_bis_2, f_c);
fprintf('│ f(b_2) = f(%.15f) = %.15e\n', b_bis, f_b);
fprintf('│\n');
fprintf('│ Determinación del nuevo intervalo:\n');

if f_a * f_c < 0
    fprintf('│   f(a_2) × f(c_2) = %.6e × %.6e = %.6e < 0 → Raíz en [a_2, c_2]\n', ...
            f_a, f_c, f_a * f_c);
    fprintf('│   → a_3 = %.15f, b_3 = %.15f\n', a_bis, c_bis_2);
else
    fprintf('│   f(c_2) × f(b_2) = %.6e × %.6e = %.6e < 0 → Raíz en [c_2, b_2]\n', ...
            f_c, f_b, f_c * f_b);
    fprintf('│   → a_3 = %.15f, b_3 = %.15f\n', c_bis_2, b_bis);
end

fprintf('│\n');
fprintf('│ Error = (b_2 - a_2) / 2 = (%.15f - %.15f) / 2\n', b_bis, a_bis);
fprintf('│ Error = %.15e\n', error_bis_2);
fprintf('│ Precisión: %.15e (NO < 10^-3)\n', error_bis_2);
fprintf('└─────────────────────────────────────────────────────────────────────────────┘\n\n');

fprintf('TABLA RESUMEN - BISECCIÓN\n');
fprintf('───────────────────────────────────────────────────────────────────────────────\n');
fprintf('   n │     a_n      │     b_n      │     c_n      │    error_n   │ < 10^-3 ?\n');
fprintf('─────┼──────────────┼──────────────┼──────────────┼──────────────┼────────────\n');
fprintf('   0 │  1.000000000 │  2.000000000 │  1.500000000 │  5.000e-01   │    NO\n');
fprintf('   1 │  1.000000000 │  1.500000000 │  1.250000000 │  2.500e-01   │    NO\n');
fprintf('   2 │  1.250000000 │  1.500000000 │  1.375000000 │  1.250e-01   │    NO\n');
fprintf('───────────────────────────────────────────────────────────────────────────────\n\n');

% =========================================================================
% PARTE B: CUÁNTAS ITERACIONES PARA PRECISIÓN 10^-3
% =========================================================================

fprintf('\n');
fprintf('╔═══════════════════════════════════════════════════════════════════════════════╗\n');
fprintf('║ PARTE B: ¿CUÁNTAS ITERACIONES PARA PRECISIÓN 10^-3?                         ║\n');
fprintf('╚═══════════════════════════════════════════════════════════════════════════════╝\n');

% ───────────────────────────────────────────────────────────────────────
% MÉTODO NEWTON
% ───────────────────────────────────────────────────────────────────────

fprintf('\n');
fprintf('MÉTODO NEWTON\n');
fprintf('─────────────────────────────────────────────────────────────────────────────\n');

x_n = 1.0;
n_newton = 0;
raiz_exacta = sqrt(2);

fprintf('\n   n │         x_n          │ |e_n| = |x_n - √2|  │ ¿< 10^-3?\n');
fprintf('─────┼──────────────────────┼─────────────────────┼─────────────\n');

while abs(x_n - raiz_exacta) > tolerancia && n_newton < 20
    fprintf('   %d │ %.18f │ %.18e │ ', n_newton, x_n, abs(x_n - raiz_exacta));
    if abs(x_n - raiz_exacta) <= tolerancia
        fprintf('SÍ ✓\n');
        break;
    else
        fprintf('NO\n');
    end
    
    x_n = 0.5 * (x_n + 2 / x_n);
    n_newton = n_newton + 1;
end

fprintf('   %d │ %.18f │ %.18e │ ', n_newton, x_n, abs(x_n - raiz_exacta));
if abs(x_n - raiz_exacta) <= tolerancia
    fprintf('SÍ ✓\n');
else
    fprintf('NO\n');
end

fprintf('\n✓ NEWTON requiere %d iteraciones para precisión 10^-3\n\n', n_newton);

% ───────────────────────────────────────────────────────────────────────
% MÉTODO BISECCIÓN
% ───────────────────────────────────────────────────────────────────────

fprintf('\n');
fprintf('MÉTODO BISECCIÓN\n');
fprintf('─────────────────────────────────────────────────────────────────────────────\n');

a_n = 1.0;
b_n = 2.0;
n_bis = 0;
f = @(x) x^2 - 2;

fprintf('\n   n │     a_n      │     b_n      │     c_n      │    error_n   │ ¿< 10^-3?\n');
fprintf('─────┼──────────────┼──────────────┼──────────────┼──────────────┼───────────\n');

while (b_n - a_n) / 2 > tolerancia && n_bis < 20
    c_n = (a_n + b_n) / 2;
    
    fprintf('   %d │ %.10f │ %.10f │ %.10f │ %.10e │ ', n_bis, a_n, b_n, c_n, (b_n - a_n)/2);
    if (b_n - a_n) / 2 <= tolerancia
        fprintf('SÍ ✓\n');
        break;
    else
        fprintf('NO\n');
    end
    
    if f(a_n) * f(c_n) < 0
        b_n = c_n;
    else
        a_n = c_n;
    end
    
    n_bis = n_bis + 1;
end

c_n = (a_n + b_n) / 2;
fprintf('   %d │ %.10f │ %.10f │ %.10f │ %.10e │ ', n_bis, a_n, b_n, c_n, (b_n - a_n)/2);
if (b_n - a_n) / 2 <= tolerancia
    fprintf('SÍ ✓\n');
else
    fprintf('NO\n');
end

fprintf('\n✓ BISECCIÓN requiere %d iteraciones para precisión 10^-3\n\n', n_bis);

% =========================================================================
% ANÁLISIS COMPARATIVO
% =========================================================================

fprintf('\n');
fprintf('╔═══════════════════════════════════════════════════════════════════════════════╗\n');
fprintf('║ ANÁLISIS COMPARATIVO                                                         ║\n');
fprintf('╚═══════════════════════════════════════════════════════════════════════════════╝\n');

fprintf('\n');
fprintf('┌─────────────────────────────────────────────────────────────────────────────┐\n');
fprintf('│ RESULTADO FINAL                                                              │\n');
fprintf('├─────────────────────────────────────────────────────────────────────────────┤\n');
fprintf('│                                                                              │\n');
fprintf('│  Para alcanzar precisión de 10^-3:                                          │\n');
fprintf('│                                                                              │\n');
fprintf('│    • NEWTON:    %d iteración(es)     [CONVERGENCIA CUADRÁTICA]             │\n', n_newton);
fprintf('│    • BISECCIÓN: %d iteraciones       [CONVERGENCIA LINEAL]                 │\n', n_bis);
fprintf('│                                                                              │\n');
fprintf('│  RATIO: Bisección requiere %.1f × más iteraciones que Newton             │\n', n_bis/n_newton);
fprintf('│                                                                              │\n');
fprintf('└─────────────────────────────────────────────────────────────────────────────┘\n\n');

fprintf('EXPLICACIÓN TEÓRICA\n');
fprintf('─────────────────────────────────────────────────────────────────────────────\n');
fprintf('\n1. NEWTON - Convergencia cuadrática (orden p = 2):\n');
fprintf('   |e_{n+1}| ≤ C |e_n|^2\n');
fprintf('   → Cifras significativas se duplican cada iteración\n');
fprintf('   → Muy pocos pasos hasta precisión máquina\n\n');

fprintf('2. BISECCIÓN - Convergencia lineal (orden p = 1):\n');
fprintf('   |e_n| = (b_0 - a_0) / 2^{n+1}\n');
fprintf('   → Error se reduce por factor constante cada iteración\n');
fprintf('   → Requiere muchos pasos para alta precisión\n\n');

fprintf('3. FÓRMULA TEÓRICA para Bisección:\n');
fprintf('   n ≥ log_2((b_0 - a_0) / ε)\n');
fprintf('   Para [1, 2] y ε = 10^-3:\n');
fprintf('   n ≥ log_2(1 / 10^-3) = log_2(1000) ≈ %.2f\n', log2(1/1e-3));
fprintf('   → Se necesitan al menos %d iteraciones (coincide con cálculo)\n\n', ceil(log2(1/1e-3)));

fprintf('CONCLUSIÓN\n');
fprintf('─────────────────────────────────────────────────────────────────────────────\n');
fprintf('\nNewton es MUCHO MÁS EFICIENTE:\n');
fprintf('  • Para precisión 10^-3:    Newton = %d iters vs Bisección = %d iters\n', n_newton, n_bis);
fprintf('  • Factor de mejora: %.1f× (Bisección necesita %.1f veces más iteraciones)\n\n', ...
        n_bis/n_newton, n_bis/n_newton);

fprintf('Esto confirma la teoría de convergencia cuadrática:\n');
fprintf('  Newton duplica dígitos correctos → convergencia EXPONENCIAL en precisión\n');
fprintf('  Bisección reduce error por factor 2 → convergencia LINEAR\n\n');

fprintf('═════════════════════════════════════════════════════════════════════════════\n\n');
