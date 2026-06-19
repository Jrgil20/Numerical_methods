% =========================================================================
%  PARCIAL 2 (Adonais) - MEGA-ARCHIVO AUTOCONTENIDO
%  Todos los temas en un solo fichero.  Cópialo a cualquier carpeta de
%  Octave y ejecútalo con:   parcial2_mega
%
%  Temas incluidos:
%    T1 - Interpolación de Newton (diferencias divididas)
%    T1 - Interpolación de Lagrange (bases L_i)
%    T2 - Trazador cúbico natural (spline)
%    T3 - Mínimos cuadrados (ecuaciones normales)
%    T4 - Diferenciación numérica (adelante/atrás/centrada)
%    T5 - Regla del Trapecio compuesta
%    T5 - Simpson 1/3 compuesta
%    T5 - Simpson 3/8 compuesta
%    T6 - Método de Euler (EDO)
%    T6 - Euler mejorado (Heun) y Runge-Kutta 4
% =========================================================================
function parcial2_mega()
    opciones = { ...
        'T1 - Interpolación de Newton', ...
        'T1 - Interpolación de Lagrange', ...
        'T2 - Trazador cúbico (spline)', ...
        'T3 - Mínimos cuadrados', ...
        'T4 - Diferenciación numérica', ...
        'T5 - Trapecio compuesta', ...
        'T5 - Simpson 1/3', ...
        'T5 - Simpson 3/8', ...
        'T6 - Euler (EDO)', ...
        'T6 - Euler mejorado y RK4', ...
        'SALIR' };

    while true
        c = menu('PARCIAL 2 - elige un tema', opciones{:});
        if c == numel(opciones) || c == 0
            fprintf('\nFin del menú. ¡Suerte en el parcial!\n\n');
            break;
        end
        fprintf('\n>>> Ejecutando: %s\n', opciones{c});
        switch c
            case 1,  t1_newton();
            case 2,  t1_lagrange();
            case 3,  t2_spline_cubico();
            case 4,  t3_minimos_cuadrados();
            case 5,  t4_diferenciacion();
            case 6,  t5_trapecio();
            case 7,  t5_simpson13();
            case 8,  t5_simpson38();
            case 9,  t6_euler();
            case 10, t6_euler_mejorado_rk4();
        end
    end
end

% =========================================================================
%  UTILIDAD: pausa condicional
% =========================================================================
function pausa(activo)
    if nargin >= 1 && activo
        input('   ... [Enter para continuar] ', 's');
    end
end

% =========================================================================
%  T1 - INTERPOLACIÓN DE NEWTON  (diferencias divididas)
% =========================================================================
function t1_newton()
    clc;
    PASO_A_PASO = false;   % <-- pon true para pausar entre pasos

    % --- DATOS (editar para el examen) ------------------------------------
    x  = [1; 2; 4; 5];
    y  = [0; 7; 63; 124];
    xq = 3;
    % ----------------------------------------------------------------------

    x = x(:); y = y(:);
    n = numel(x);

    fprintf('\n');
    fprintf('╔═══════════════════════════════════════════════════════════════════╗\n');
    fprintf('║      INTERPOLACIÓN DE NEWTON  -  DIFERENCIAS DIVIDIDAS            ║\n');
    fprintf('╚═══════════════════════════════════════════════════════════════════╝\n\n');

    fprintf('Nodos dados (n = %d puntos):\n', n);
    for i = 1:n
        fprintf('   x%d = %8.4f     f(x%d) = %10.4f\n', i-1, x(i), i-1, y(i));
    end
    fprintf('\nQueremos estimar f(%.4f)\n\n', xq);
    pausa(PASO_A_PASO);

    fprintf('═══ PASO 1: Tabla de diferencias divididas ═══\n\n');
    D = zeros(n, n);
    D(:,1) = y;
    for j = 2:n
        for i = 1:(n-j+1)
            D(i,j) = (D(i+1,j-1) - D(i,j-1)) / (x(i+j-1) - x(i));
            fprintf('  f[x%d..x%d] = (%.4f - %.4f) / (%.4f - %.4f) = %.6f\n', ...
                    i-1, i+j-2, D(i+1,j-1), D(i,j-1), x(i+j-1), x(i), D(i,j));
        end
        fprintf('\n');
    end
    pausa(PASO_A_PASO);

    fprintf('Tabla completa (cada columna = orden de diferencia):\n');
    fprintf('   xi    |');
    for j = 1:n, fprintf('   orden %d   ', j-1); end
    fprintf('\n');
    for i = 1:n
        fprintf(' %7.3f |', x(i));
        for j = 1:(n-i+1)
            fprintf(' %10.5f ', D(i,j));
        end
        fprintf('\n');
    end
    fprintf('\n');
    pausa(PASO_A_PASO);

    fprintf('═══ PASO 2: Coeficientes del polinomio (b_k = f[x0..xk]) ═══\n\n');
    b = D(1, :);
    for k = 1:n
        fprintf('   b%d = %12.6f\n', k-1, b(k));
    end
    fprintf('\n');
    pausa(PASO_A_PASO);

    fprintf('═══ PASO 3: Evaluación de P_n(%.4f) ═══\n\n', xq);
    Pq   = b(1);
    prod = 1;
    fprintf('   término 0: b0 = %.6f\n', b(1));
    for k = 2:n
        prod = prod * (xq - x(k-1));
        term = b(k) * prod;
        Pq   = Pq + term;
        fprintf('   término %d: b%d * Π(xq-xj) = %.6f * %.6f = %.6f\n', ...
                k-1, k-1, b(k), prod, term);
    end
    fprintf('\n   >> P_n(%.4f) = %.6f\n\n', xq, Pq);
    pausa(PASO_A_PASO);

    fprintf('═══ VERIFICACIÓN (Octave nativo) ═══\n\n');
    p_fit  = polyfit(x, y, n-1);
    Pq_fit = polyval(p_fit, xq);
    fprintf('   polyfit/polyval  -> P(%.4f) = %.6f\n', xq, Pq_fit);
    fprintf('   interp1 (spline) -> f(%.4f) = %.6f\n', xq, interp1(x, y, xq, 'spline'));
    fprintf('   diferencia |manual - polyfit| = %.2e\n\n', abs(Pq - Pq_fit));

    xx = linspace(min(x)-0.5, max(x)+0.5, 300);
    yy = b(n) * ones(size(xx));
    for k = n-1:-1:1
        yy = yy .* (xx - x(k)) + b(k);
    end
    figure;
    plot(xx, yy, 'b-', 'LineWidth', 2); hold on;
    plot(x, y, 'ro', 'MarkerSize', 9, 'MarkerFaceColor', 'r');
    plot(xq, Pq, 'ks', 'MarkerSize', 11, 'MarkerFaceColor', 'g');
    grid on; xlabel('x'); ylabel('P_n(x)');
    title('Interpolación de Newton');
    legend('P_n(x)', 'nodos', sprintf('estimado en x=%.2f', xq), 'Location', 'NorthWest');

    fprintf('Gráfica generada. Fin del Tema 1 (Newton).\n\n');
end

% =========================================================================
%  T1 - INTERPOLACIÓN DE LAGRANGE  (bases L_i)
% =========================================================================
function t1_lagrange()
    clc;
    PASO_A_PASO = false;   % <-- pon true para pausar entre pasos

    % --- DATOS (editar para el examen) ------------------------------------
    x  = [1; 2; 4; 5];
    y  = [0; 7; 63; 124];
    xq = 3;
    % ----------------------------------------------------------------------

    x = x(:); y = y(:);
    n = numel(x);

    fprintf('\n');
    fprintf('╔═══════════════════════════════════════════════════════════════════╗\n');
    fprintf('║          INTERPOLACIÓN DE LAGRANGE  -  BASES L_i(x)             ║\n');
    fprintf('╚═══════════════════════════════════════════════════════════════════╝\n\n');

    fprintf('Nodos dados (n = %d puntos):\n', n);
    for i = 1:n
        fprintf('   x%d = %8.4f     f(x%d) = %10.4f\n', i, x(i), i, y(i));
    end
    fprintf('\nEstimar f(%.4f)\n\n', xq);
    pausa(PASO_A_PASO);

    fprintf('═══ PASO 1: Evaluación de cada base de Lagrange en xq = %.4f ═══\n\n', xq);
    L = zeros(n, 1);
    for i = 1:n
        num = 1; den = 1;
        fprintf('   L%d(xq): ', i);
        for j = 1:n
            if j ~= i
                num = num * (xq - x(j));
                den = den * (x(i) - x(j));
                fprintf('(%.3f-%.3f)/(%.3f-%.3f) ', xq, x(j), x(i), x(j));
            end
        end
        L(i) = num / den;
        fprintf('\n          = %.6f / %.6f = %.6f\n\n', num, den, L(i));
    end
    pausa(PASO_A_PASO);

    fprintf('   Comprobación  Σ L_i(xq) = %.6f  (debe ser 1.000000)\n\n', sum(L));
    pausa(PASO_A_PASO);

    fprintf('═══ PASO 2: P_n(xq) = Σ y_i · L_i(xq) ═══\n\n');
    Pq = 0;
    for i = 1:n
        term = y(i) * L(i);
        Pq = Pq + term;
        fprintf('   y%d·L%d = %.4f · %.6f = %.6f\n', i, i, y(i), L(i), term);
    end
    fprintf('\n   >> P_n(%.4f) = %.6f\n\n', xq, Pq);
    pausa(PASO_A_PASO);

    fprintf('═══ VERIFICACIÓN (Octave nativo) ═══\n\n');
    p_fit  = polyfit(x, y, n-1);
    Pq_fit = polyval(p_fit, xq);
    fprintf('   polyfit/polyval -> P(%.4f) = %.6f\n', xq, Pq_fit);
    fprintf('   diferencia |manual - polyfit| = %.2e\n\n', abs(Pq - Pq_fit));

    xx = linspace(min(x)-0.5, max(x)+0.5, 300);
    yy = polyval(p_fit, xx);

    figure;
    subplot(2,1,1);
    plot(xx, yy, 'b-', 'LineWidth', 2); hold on;
    plot(x, y, 'ro', 'MarkerSize', 9, 'MarkerFaceColor', 'r');
    plot(xq, Pq, 'gs', 'MarkerSize', 11, 'MarkerFaceColor', 'g');
    grid on; title('Interpolación de Lagrange'); ylabel('P_n(x)');
    legend('P_n(x)', 'nodos', sprintf('x=%.2f', xq), 'Location', 'NorthWest');

    subplot(2,1,2); hold on;
    for i = 1:n
        Li = ones(size(xx));
        for j = 1:n
            if j ~= i, Li = Li .* (xx - x(j)) / (x(i) - x(j)); end
        end
        plot(xx, Li, 'LineWidth', 1.5);
    end
    grid on; title('Bases de Lagrange L_i(x)'); xlabel('x'); ylabel('L_i(x)');

    fprintf('Gráfica generada. Fin del Tema 1 (Lagrange).\n\n');
end

% =========================================================================
%  T2 - TRAZADOR CÚBICO NATURAL  (spline)
% =========================================================================
function t2_spline_cubico()
    clc;
    PASO_A_PASO = false;   % <-- pon true para pausar entre pasos

    % --- DATOS (editar para el examen) ------------------------------------
    x  = [1; 2; 3; 4];
    y  = [1; 4; 1; 5];
    xq = 2.5;
    % ----------------------------------------------------------------------

    x = x(:); y = y(:);
    n = numel(x);
    m = n - 1;

    fprintf('\n');
    fprintf('╔═══════════════════════════════════════════════════════════════════╗\n');
    fprintf('║            TRAZADOR CÚBICO NATURAL  -  PASO A PASO              ║\n');
    fprintf('╚═══════════════════════════════════════════════════════════════════╝\n\n');

    fprintf('Nodos (%d puntos, %d tramos):\n', n, m);
    for i = 1:n
        fprintf('   x%d = %7.3f   y%d = %7.3f\n', i, x(i), i, y(i));
    end
    fprintf('\n');

    fprintf('═══ PASO 1: Anchos de cada tramo h_i = x_{i+1}-x_i ═══\n\n');
    h = diff(x);
    for i = 1:m
        fprintf('   h%d = %.4f - %.4f = %.4f\n', i, x(i+1), x(i), h(i));
    end
    fprintf('\n');
    pausa(PASO_A_PASO);

    fprintf('═══ PASO 2: Sistema tridiagonal para las segundas derivadas (c) ═══\n\n');
    A = zeros(n, n);
    r = zeros(n, 1);
    A(1,1) = 1;
    A(n,n) = 1;
    for i = 2:n-1
        A(i,i-1) = h(i-1);
        A(i,i)   = 2*(h(i-1) + h(i));
        A(i,i+1) = h(i);
        r(i)     = 3*((y(i+1)-y(i))/h(i) - (y(i)-y(i-1))/h(i-1));
        fprintf('   fila %d:  %.3f·c%d + %.3f·c%d + %.3f·c%d = %.4f\n', ...
                i, h(i-1), i-1, 2*(h(i-1)+h(i)), i, h(i), i+1, r(i));
    end
    fprintf('\n   (filas 1 y %d: c1 = 0 y c%d = 0  -> spline natural)\n\n', n, n);
    disp('   Matriz A ='); disp(A);
    disp('   Vector r ='); disp(r');
    pausa(PASO_A_PASO);

    fprintf('═══ PASO 3: Resolver  A c = r  (c = A\\r) ═══\n\n');
    c = A \ r;
    for i = 1:n
        fprintf('   c%d = %.6f\n', i, c(i));
    end
    fprintf('\n');
    pausa(PASO_A_PASO);

    fprintf('═══ PASO 4: Coeficientes de cada tramo S_i ═══\n\n');
    a_s = y(1:m);
    b_s = zeros(m,1); d_s = zeros(m,1);
    for i = 1:m
        b_s(i) = (y(i+1)-y(i))/h(i) - h(i)*(2*c(i)+c(i+1))/3;
        d_s(i) = (c(i+1)-c(i))/(3*h(i));
    end
    fprintf('   tramo | a_i      b_i       c_i       d_i      (válido en [x_i,x_{i+1}])\n');
    for i = 1:m
        fprintf('   %4d  | %8.4f %8.4f %8.4f %8.4f   [%.2f, %.2f]\n', ...
                i, a_s(i), b_s(i), c(i), d_s(i), x(i), x(i+1));
    end
    fprintf('\n');
    pausa(PASO_A_PASO);

    fprintf('═══ PASO 5: Evaluación de S(%.4f) ═══\n\n', xq);
    k = find(xq >= x(1:m) & xq <= x(2:n), 1);
    if isempty(k), k = m; end
    dx  = xq - x(k);
    Sq  = a_s(k) + b_s(k)*dx + c(k)*dx^2 + d_s(k)*dx^3;
    fprintf('   xq está en el tramo %d  [%.2f, %.2f],  dx = xq-x%d = %.4f\n', ...
            k, x(k), x(k+1), k, dx);
    fprintf('   S(xq) = %.4f + %.4f·%.4f + %.4f·%.4f² + %.4f·%.4f³\n', ...
            a_s(k), b_s(k), dx, c(k), dx, d_s(k), dx);
    fprintf('   >> S(%.4f) = %.6f\n\n', xq, Sq);
    pausa(PASO_A_PASO);

    fprintf('═══ VERIFICACIÓN (Octave nativo: spline) ═══\n\n');
    Sq_native = spline(x, y, xq);
    fprintf('   spline(x,y,xq) = %.6f\n', Sq_native);
    fprintf('   (Nota: spline() usa condición "not-a-knot", no natural,\n');
    fprintf('    por eso puede diferir ligeramente del spline natural manual)\n\n');

    xx = linspace(x(1), x(n), 400);
    yy = zeros(size(xx));
    for t_idx = 1:numel(xx)
        kk = find(xx(t_idx) >= x(1:m) & xx(t_idx) <= x(2:n), 1);
        if isempty(kk), kk = m; end
        dxx = xx(t_idx) - x(kk);
        yy(t_idx) = a_s(kk) + b_s(kk)*dxx + c(kk)*dxx^2 + d_s(kk)*dxx^3;
    end
    figure;
    plot(xx, yy, 'b-', 'LineWidth', 2); hold on;
    plot(xx, spline(x, y, xx), 'r--', 'LineWidth', 1.2);
    plot(x, y, 'ko', 'MarkerSize', 9, 'MarkerFaceColor', 'k');
    plot(xq, Sq, 'gs', 'MarkerSize', 11, 'MarkerFaceColor', 'g');
    grid on; xlabel('x'); ylabel('S(x)');
    title('Trazador cúbico natural (manual) vs spline() nativo');
    legend('Spline natural (manual)', 'spline() nativo', 'nodos', ...
           sprintf('S(%.2f)', xq), 'Location', 'NorthWest');

    fprintf('Gráfica generada. Fin del Tema 2 (Spline cúbico).\n\n');
end

% =========================================================================
%  T3 - MÍNIMOS CUADRADOS  (ecuaciones normales)
% =========================================================================
function t3_minimos_cuadrados()
    clc;
    PASO_A_PASO = false;   % <-- pon true para pausar entre pasos

    % --- DATOS (editar para el examen) ------------------------------------
    x = [1; 2; 3; 4; 5];
    y = [2; 3; 5; 4; 6];
    g = 1;                  % grado del polinomio (1 = recta)
    % ----------------------------------------------------------------------

    x = x(:); y = y(:);
    N = numel(x);

    fprintf('\n');
    fprintf('╔═══════════════════════════════════════════════════════════════════╗\n');
    fprintf('║       AJUSTE POR MÍNIMOS CUADRADOS  -  ECUACIONES NORMALES      ║\n');
    fprintf('╚═══════════════════════════════════════════════════════════════════╝\n\n');

    fprintf('Datos (%d puntos), ajuste polinomial de grado %d:\n', N, g);
    for i = 1:N
        fprintf('   x = %7.3f   y = %7.3f\n', x(i), y(i));
    end
    fprintf('\n');

    fprintf('═══ PASO 1: Matriz de diseño Z (Vandermonde) ═══\n\n');
    Z = zeros(N, g+1);
    for p = 0:g
        Z(:, p+1) = x.^p;
    end
    fprintf('   Columnas = [1, x, x^2, ..., x^%d]\n', g);
    disp(Z);
    pausa(PASO_A_PASO);

    fprintf('═══ PASO 2: Construir el sistema normal  (Z''Z) A = Z''Y ═══\n\n');
    M = Z' * Z;
    B = Z' * y;
    disp('   Z''Z =');  disp(M);
    disp('   Z''Y =');  disp(B);
    pausa(PASO_A_PASO);

    fprintf('═══ PASO 3: Resolver el sistema (A = Z\\Y por backslash) ═══\n\n');
    A = Z \ y;
    for k = 0:g
        fprintf('   a%d (coef. de x^%d) = %.6f\n', k, k, A(k+1));
    end
    p_poly = flipud(A)';
    fprintf('\n   Polinomio (formato Octave, mayor->menor grado):\n   p = [');
    fprintf(' %.5f', p_poly); fprintf(' ]\n\n');
    pausa(PASO_A_PASO);

    fprintf('═══ PASO 4: Residuos, error cuadrático y R^2 ═══\n\n');
    y_pred = Z * A;
    res    = y - y_pred;
    Sr     = sum(res.^2);
    St     = sum((y - mean(y)).^2);
    R2     = 1 - Sr/St;
    fprintf('   %3s  %10s  %10s  %10s\n', 'i', 'y', 'y_pred', 'residuo');
    for i = 1:N
        fprintf('   %3d  %10.4f  %10.4f  %10.4f\n', i, y(i), y_pred(i), res(i));
    end
    fprintf('\n   Error cuadrático total  Sr = %.6f\n', Sr);
    fprintf('   Coef. de determinación  R^2 = %.6f\n\n', R2);
    pausa(PASO_A_PASO);

    fprintf('═══ VERIFICACIÓN (Octave nativo: polyfit) ═══\n\n');
    p_native = polyfit(x, y, g);
    fprintf('   polyfit -> p = [');
    fprintf(' %.5f', p_native); fprintf(' ]\n');
    fprintf('   diferencia máx con el manual = %.2e\n\n', max(abs(p_poly - p_native)));

    rt = roots(p_poly);
    rt = rt(abs(imag(rt)) < 1e-9);
    if ~isempty(rt)
        fprintf('   roots(p): el ajuste cruza el eje X en x =');
        fprintf(' %.4f', real(rt)); fprintf('\n\n');
    end

    xx = linspace(min(x)-0.5, max(x)+0.5, 200);
    figure;
    plot(x, y, 'ro', 'MarkerSize', 9, 'MarkerFaceColor', 'r'); hold on;
    plot(xx, polyval(p_poly, xx), 'b-', 'LineWidth', 2);
    grid on; xlabel('x'); ylabel('y');
    title(sprintf('Mínimos cuadrados (grado %d),  R^2 = %.4f', g, R2));
    legend('datos', 'ajuste', 'Location', 'NorthWest');

    fprintf('Gráfica generada. Fin del Tema 3 (Mínimos cuadrados).\n\n');
end

% =========================================================================
%  T4 - DIFERENCIACIÓN NUMÉRICA
% =========================================================================
function t4_diferenciacion()
    clc;
    PASO_A_PASO = false;   % <-- pon true para pausar entre pasos

    % --- DATOS (editar para el examen) ------------------------------------
    f   = @(x) sin(x);
    df  = @(x) cos(x);
    d2f = @(x) -sin(x);
    x0  = 1.0;
    h   = 0.1;
    % ----------------------------------------------------------------------

    fprintf('\n');
    fprintf('╔═══════════════════════════════════════════════════════════════════╗\n');
    fprintf('║              DIFERENCIACIÓN NUMÉRICA  -  PASO A PASO            ║\n');
    fprintf('╚═══════════════════════════════════════════════════════════════════╝\n\n');

    fprintf('Función: f(x) = sin(x)   en x0 = %.4f   con h = %.4f\n\n', x0, h);

    fm = f(x0 - h);  fc = f(x0);  fp = f(x0 + h);
    fprintf('Valores de la función:\n');
    fprintf('   f(x0-h) = f(%.4f) = %.6f\n', x0-h, fm);
    fprintf('   f(x0)   = f(%.4f) = %.6f\n', x0,   fc);
    fprintf('   f(x0+h) = f(%.4f) = %.6f\n\n', x0+h, fp);
    pausa(PASO_A_PASO);

    fprintf('═══ PASO 1: Primera derivada - hacia ADELANTE  O(h) ═══\n\n');
    d_fwd = (fp - fc) / h;
    fprintf('   f''(x0) ≈ [f(x0+h)-f(x0)]/h = (%.6f - %.6f)/%.4f = %.6f\n\n', ...
            fp, fc, h, d_fwd);
    pausa(PASO_A_PASO);

    fprintf('═══ PASO 2: Primera derivada - hacia ATRÁS  O(h) ═══\n\n');
    d_bwd = (fc - fm) / h;
    fprintf('   f''(x0) ≈ [f(x0)-f(x0-h)]/h = (%.6f - %.6f)/%.4f = %.6f\n\n', ...
            fc, fm, h, d_bwd);
    pausa(PASO_A_PASO);

    fprintf('═══ PASO 3: Primera derivada - CENTRADA  O(h^2) ═══\n\n');
    d_cen = (fp - fm) / (2*h);
    fprintf('   f''(x0) ≈ [f(x0+h)-f(x0-h)]/(2h) = (%.6f - %.6f)/%.4f = %.6f\n\n', ...
            fp, fm, 2*h, d_cen);
    pausa(PASO_A_PASO);

    fprintf('═══ PASO 4: Segunda derivada - CENTRADA  O(h^2) ═══\n\n');
    d2_cen = (fm - 2*fc + fp) / h^2;
    fprintf('   f''''(x0) ≈ [f(x0-h)-2f(x0)+f(x0+h)]/h^2\n');
    fprintf('           = (%.6f - 2·%.6f + %.6f)/%.4f² = %.6f\n\n', ...
            fm, fc, fp, h, d2_cen);
    pausa(PASO_A_PASO);

    fprintf('═══ PASO 5: Comparación con la derivada exacta ═══\n\n');
    exact1 = df(x0);
    exact2 = d2f(x0);
    fprintf('   f''(x0) exacta  = %.6f\n', exact1);
    fprintf('   f''''(x0) exacta = %.6f\n\n', exact2);
    fprintf('   %-22s %12s %12s\n', 'Método', 'valor', '|error|');
    fprintf('   %-22s %12.6f %12.2e\n', 'Adelante  (f'')',  d_fwd,  abs(d_fwd-exact1));
    fprintf('   %-22s %12.6f %12.2e\n', 'Atrás     (f'')',  d_bwd,  abs(d_bwd-exact1));
    fprintf('   %-22s %12.6f %12.2e\n', 'Centrada  (f'')',  d_cen,  abs(d_cen-exact1));
    fprintf('   %-22s %12.6f %12.2e\n', 'Centrada  (f'''')', d2_cen, abs(d2_cen-exact2));
    fprintf('\n   (la centrada O(h^2) debe tener MENOR error que adelante/atrás)\n\n');
    pausa(PASO_A_PASO);

    fprintf('═══ VERIFICACIÓN (Octave nativo: diff y gradient) ═══\n\n');
    xs = (x0 - 5*h):h:(x0 + 5*h);
    ys = f(xs);
    dydx_diff = diff(ys) ./ diff(xs);
    g_grad    = gradient(ys, h);
    [~, idx]  = min(abs(xs - x0));
    fprintf('   diff(y)./diff(x)  en x0 ≈ %.6f\n', dydx_diff(idx));
    fprintf('   gradient(y,h)     en x0 ≈ %.6f\n\n', g_grad(idx));

    xx = linspace(x0-3, x0+3, 300);
    figure;
    plot(xx, f(xx),  'b-',  'LineWidth', 2); hold on;
    plot(xx, df(xx), 'r--', 'LineWidth', 1.5);
    plot(x0, d_cen, 'gs', 'MarkerSize', 11, 'MarkerFaceColor', 'g');
    grid on; xlabel('x'); ylabel('y');
    title('f(x), su derivada exacta y la estimación centrada');
    legend('f(x)', "f'(x) exacta", "f'(x0) centrada", 'Location', 'NorthWest');

    fprintf('Gráfica generada. Fin del Tema 4 (Diferenciación).\n\n');
end

% =========================================================================
%  T5 - TRAPECIO COMPUESTA
% =========================================================================
function t5_trapecio()
    clc;
    PASO_A_PASO = false;   % <-- pon true para pausar entre pasos

    % --- DATOS (editar para el examen) ------------------------------------
    f        = @(x) exp(x);
    a        = 0;
    b        = 1;
    n        = 6;
    I_exacta = exp(1) - 1;
    % ----------------------------------------------------------------------

    fprintf('\n');
    fprintf('╔═══════════════════════════════════════════════════════════════════╗\n');
    fprintf('║            REGLA DEL TRAPECIO COMPUESTA  -  PASO A PASO         ║\n');
    fprintf('╚═══════════════════════════════════════════════════════════════════╝\n\n');

    fprintf('Integrar f(x)=exp(x) en [%.3f, %.3f] con n = %d subintervalos\n\n', a, b, n);

    fprintf('═══ PASO 1: Paso h y nodos x_i ═══\n\n');
    h = (b - a) / n;
    x = linspace(a, b, n+1);
    y = f(x);
    fprintf('   h = (b-a)/n = (%.3f-%.3f)/%d = %.6f\n\n', b, a, n, h);
    fprintf('   %3s  %12s  %12s\n', 'i', 'x_i', 'f(x_i)');
    for i = 1:numel(x)
        fprintf('   %3d  %12.6f  %12.6f\n', i-1, x(i), y(i));
    end
    fprintf('\n');
    pausa(PASO_A_PASO);

    fprintf('═══ PASO 2: Suma de términos interiores (×2) ═══\n\n');
    S_int = 0;
    for i = 2:numel(x)-1
        S_int = S_int + y(i);
        fprintf('   + f(x%d) = %.6f   (acumulado interior = %.6f)\n', i-1, y(i), S_int);
    end
    fprintf('\n   Σ interiores = %.6f   ->  2·Σ = %.6f\n\n', S_int, 2*S_int);
    pausa(PASO_A_PASO);

    fprintf('═══ PASO 3: Aplicar la fórmula ═══\n\n');
    I = (h/2) * (y(1) + y(end) + 2*S_int);
    fprintf('   I ≈ (h/2)[ f(x0) + f(xn) + 2·Σ ]\n');
    fprintf('     = (%.6f/2)[ %.6f + %.6f + %.6f ]\n', h, y(1), y(end), 2*S_int);
    fprintf('     = %.8f\n\n', I);
    pausa(PASO_A_PASO);

    fprintf('═══ PASO 4: Error ═══\n\n');
    fprintf('   I exacta    = %.8f\n', I_exacta);
    fprintf('   I trapecio  = %.8f\n', I);
    fprintf('   |error|     = %.2e\n\n', abs(I - I_exacta));
    pausa(PASO_A_PASO);

    fprintf('═══ VERIFICACIÓN (Octave nativo: trapz) ═══\n\n');
    I_trapz = trapz(x, y);
    fprintf('   trapz(x,y) = %.8f   (dif con manual = %.2e)\n\n', ...
            I_trapz, abs(I - I_trapz));

    xx = linspace(a, b, 300);
    figure;
    plot(xx, f(xx), 'b-', 'LineWidth', 2); hold on;
    for i = 1:numel(x)-1
        patch([x(i) x(i+1) x(i+1) x(i)], [0 0 y(i+1) y(i)], ...
              [0.7 0.85 1], 'EdgeColor', [0.2 0.4 0.8]);
    end
    plot(xx, f(xx), 'b-', 'LineWidth', 2);
    plot(x, y, 'ro', 'MarkerFaceColor', 'r');
    grid on; xlabel('x'); ylabel('f(x)');
    title(sprintf('Trapecio compuesta (n=%d),  I ≈ %.6f', n, I));
    legend('f(x)', 'trapecios', 'Location', 'NorthWest');

    fprintf('Gráfica generada. Fin del Tema 5 (Trapecio).\n\n');
end

% =========================================================================
%  T5 - SIMPSON 1/3 COMPUESTA
% =========================================================================
function t5_simpson13()
    clc;
    PASO_A_PASO = false;   % <-- pon true para pausar entre pasos

    % --- DATOS (editar para el examen) ------------------------------------
    f        = @(x) exp(x);
    a        = 0;
    b        = 1;
    n        = 6;           % DEBE ser par
    I_exacta = exp(1) - 1;
    % ----------------------------------------------------------------------

    fprintf('\n');
    fprintf('╔═══════════════════════════════════════════════════════════════════╗\n');
    fprintf('║             SIMPSON 1/3 COMPUESTA  -  PASO A PASO              ║\n');
    fprintf('╚═══════════════════════════════════════════════════════════════════╝\n\n');

    if mod(n,2) ~= 0
        error('Simpson 1/3 requiere n PAR. Tienes n = %d.', n);
    end
    fprintf('Integrar f(x)=exp(x) en [%.3f, %.3f] con n = %d (par)\n\n', a, b, n);

    fprintf('═══ PASO 1: Paso h y nodos ═══\n\n');
    h = (b - a) / n;
    x = linspace(a, b, n+1);
    y = f(x);
    fprintf('   h = (b-a)/n = %.6f\n\n', h);
    fprintf('   %3s  %12s  %12s  %s\n', 'i', 'x_i', 'f(x_i)', 'peso');
    for i = 1:numel(x)
        if i == 1 || i == numel(x), w = 1;
        elseif mod(i-1, 2) == 1,    w = 4;
        else,                       w = 2;
        end
        fprintf('   %3d  %12.6f  %12.6f   %d\n', i-1, x(i), y(i), w);
    end
    fprintf('\n');
    pausa(PASO_A_PASO);

    fprintf('═══ PASO 2: Sumas de impares (×4) y pares (×2) ═══\n\n');
    S_imp = 0; S_par = 0;
    for i = 2:numel(x)-1
        if mod(i-1, 2) == 1
            S_imp = S_imp + y(i);
            fprintf('   impar  + f(x%d) = %.6f  (Σimp = %.6f)\n', i-1, y(i), S_imp);
        else
            S_par = S_par + y(i);
            fprintf('   par    + f(x%d) = %.6f  (Σpar = %.6f)\n', i-1, y(i), S_par);
        end
    end
    fprintf('\n   4·Σimp = %.6f      2·Σpar = %.6f\n\n', 4*S_imp, 2*S_par);
    pausa(PASO_A_PASO);

    fprintf('═══ PASO 3: Aplicar la fórmula ═══\n\n');
    I = (h/3) * (y(1) + y(end) + 4*S_imp + 2*S_par);
    fprintf('   I ≈ (h/3)[ f(x0)+f(xn) + 4Σimp + 2Σpar ]\n');
    fprintf('     = (%.6f/3)[ %.6f + %.6f + %.6f + %.6f ]\n', ...
            h, y(1), y(end), 4*S_imp, 2*S_par);
    fprintf('     = %.8f\n\n', I);
    pausa(PASO_A_PASO);

    fprintf('═══ PASO 4: Error ═══\n\n');
    fprintf('   I exacta     = %.8f\n', I_exacta);
    fprintf('   I Simpson1/3 = %.8f\n', I);
    fprintf('   |error|      = %.2e\n\n', abs(I - I_exacta));
    pausa(PASO_A_PASO);

    fprintf('═══ VERIFICACIÓN (Octave nativo: quad) ═══\n\n');
    I_quad = quad(f, a, b);
    fprintf('   quad(f,a,b) = %.8f   (dif con manual = %.2e)\n\n', ...
            I_quad, abs(I - I_quad));

    xx = linspace(a, b, 300);
    figure;
    area(xx, f(xx), 'FaceColor', [0.8 0.9 0.8], 'EdgeColor', 'none'); hold on;
    plot(xx, f(xx), 'b-', 'LineWidth', 2);
    plot(x, y, 'ro', 'MarkerFaceColor', 'r');
    grid on; xlabel('x'); ylabel('f(x)');
    title(sprintf('Simpson 1/3 (n=%d),  I ≈ %.6f', n, I));
    legend('área', 'f(x)', 'nodos', 'Location', 'NorthWest');

    fprintf('Gráfica generada. Fin del Tema 5 (Simpson 1/3).\n\n');
end

% =========================================================================
%  T5 - SIMPSON 3/8 COMPUESTA
% =========================================================================
function t5_simpson38()
    clc;
    PASO_A_PASO = false;   % <-- pon true para pausar entre pasos

    % --- DATOS (editar para el examen) ------------------------------------
    f        = @(x) exp(x);
    a        = 0;
    b        = 1;
    n        = 6;           % DEBE ser múltiplo de 3
    I_exacta = exp(1) - 1;
    % ----------------------------------------------------------------------

    fprintf('\n');
    fprintf('╔═══════════════════════════════════════════════════════════════════╗\n');
    fprintf('║             SIMPSON 3/8 COMPUESTA  -  PASO A PASO              ║\n');
    fprintf('╚═══════════════════════════════════════════════════════════════════╝\n\n');

    if mod(n,3) ~= 0
        error('Simpson 3/8 requiere n múltiplo de 3. Tienes n = %d.', n);
    end
    fprintf('Integrar f(x)=exp(x) en [%.3f, %.3f] con n = %d (múltiplo de 3)\n\n', a, b, n);

    fprintf('═══ PASO 1: Paso h, nodos y pesos ═══\n\n');
    h = (b - a) / n;
    x = linspace(a, b, n+1);
    y = f(x);
    fprintf('   h = (b-a)/n = %.6f\n\n', h);
    fprintf('   %3s  %12s  %12s  %s\n', 'i', 'x_i', 'f(x_i)', 'peso');
    for i = 1:numel(x)
        if i == 1 || i == numel(x),      w = 1;
        elseif mod(i-1, 3) == 0,         w = 2;
        else,                            w = 3;
        end
        fprintf('   %3d  %12.6f  %12.6f   %d\n', i-1, x(i), y(i), w);
    end
    fprintf('\n');
    pausa(PASO_A_PASO);

    fprintf('═══ PASO 2: Σ peso 3 (no múlt. de 3) y Σ peso 2 (múlt. de 3) ═══\n\n');
    S3 = 0; S2 = 0;
    for i = 2:numel(x)-1
        if mod(i-1, 3) == 0
            S2 = S2 + y(i);
            fprintf('   peso2  + f(x%d) = %.6f  (Σ2 = %.6f)\n', i-1, y(i), S2);
        else
            S3 = S3 + y(i);
            fprintf('   peso3  + f(x%d) = %.6f  (Σ3 = %.6f)\n', i-1, y(i), S3);
        end
    end
    fprintf('\n   3·Σ3 = %.6f      2·Σ2 = %.6f\n\n', 3*S3, 2*S2);
    pausa(PASO_A_PASO);

    fprintf('═══ PASO 3: Aplicar la fórmula ═══\n\n');
    I = (3*h/8) * (y(1) + y(end) + 3*S3 + 2*S2);
    fprintf('   I ≈ (3h/8)[ f(x0)+f(xn) + 3Σ3 + 2Σ2 ]\n');
    fprintf('     = (3·%.6f/8)[ %.6f + %.6f + %.6f + %.6f ]\n', ...
            h, y(1), y(end), 3*S3, 2*S2);
    fprintf('     = %.8f\n\n', I);
    pausa(PASO_A_PASO);

    fprintf('═══ PASO 4: Error ═══\n\n');
    fprintf('   I exacta     = %.8f\n', I_exacta);
    fprintf('   I Simpson3/8 = %.8f\n', I);
    fprintf('   |error|      = %.2e\n\n', abs(I - I_exacta));
    pausa(PASO_A_PASO);

    fprintf('═══ VERIFICACIÓN (Octave nativo: quad) ═══\n\n');
    I_quad = quad(f, a, b);
    fprintf('   quad(f,a,b) = %.8f   (dif con manual = %.2e)\n\n', ...
            I_quad, abs(I - I_quad));

    xx = linspace(a, b, 300);
    figure;
    area(xx, f(xx), 'FaceColor', [0.95 0.85 0.7], 'EdgeColor', 'none'); hold on;
    plot(xx, f(xx), 'b-', 'LineWidth', 2);
    plot(x, y, 'ro', 'MarkerFaceColor', 'r');
    grid on; xlabel('x'); ylabel('f(x)');
    title(sprintf('Simpson 3/8 (n=%d),  I ≈ %.6f', n, I));
    legend('área', 'f(x)', 'nodos', 'Location', 'NorthWest');

    fprintf('Gráfica generada. Fin del Tema 5 (Simpson 3/8).\n\n');
end

% =========================================================================
%  T6 - MÉTODO DE EULER  (EDO)
% =========================================================================
function t6_euler()
    clc;
    PASO_A_PASO = false;   % <-- pon true para pausar entre pasos

    % --- DATOS (editar para el examen) ------------------------------------
    f      = @(t, y) y - t.^2 + 1;
    t0     = 0;
    y0     = 0.5;
    tf     = 2;
    h      = 0.2;
    y_exac = @(t) (t+1).^2 - 0.5*exp(t);
    % ----------------------------------------------------------------------

    fprintf('\n');
    fprintf('╔═══════════════════════════════════════════════════════════════════╗\n');
    fprintf('║                MÉTODO DE EULER (EDO)  -  PASO A PASO           ║\n');
    fprintf('╚═══════════════════════════════════════════════════════════════════╝\n\n');

    fprintf("PVI:  y' = y - t^2 + 1,   y(%.1f) = %.3f\n", t0, y0);
    fprintf('Intervalo [%.1f, %.1f] con paso h = %.3f\n\n', t0, tf, h);

    fprintf('═══ PASO 1: Malla de tiempos ═══\n\n');
    N = round((tf - t0) / h) + 1;
    t = linspace(t0, tf, N);
    fprintf('   N = %d puntos:  t = [', N);
    fprintf(' %.2f', t); fprintf(' ]\n\n');
    pausa(PASO_A_PASO);

    fprintf('═══ PASO 2: Iteración  y_{i+1} = y_i + h·f(t_i, y_i) ═══\n\n');
    y = zeros(1, N);
    y(1) = y0;
    fprintf('   %3s  %8s  %12s  %12s  %14s\n', 'i', 't_i', 'y_i', 'f(t_i,y_i)', 'y_{i+1}');
    for i = 1:N-1
        fi = f(t(i), y(i));
        y(i+1) = y(i) + h*fi;
        fprintf('   %3d  %8.3f  %12.6f  %12.6f  %14.6f\n', i-1, t(i), y(i), fi, y(i+1));
    end
    fprintf('\n');
    pausa(PASO_A_PASO);

    fprintf('═══ PASO 3: Comparación con la solución exacta ═══\n\n');
    fprintf('   %3s  %8s  %14s  %14s  %12s\n', 'i', 't_i', 'y Euler', 'y exacta', '|error|');
    for i = 1:N
        ye = y_exac(t(i));
        fprintf('   %3d  %8.3f  %14.6f  %14.6f  %12.2e\n', ...
                i-1, t(i), y(i), ye, abs(y(i)-ye));
    end
    fprintf('\n   Error final |y_N - y_exacta| = %.4e\n\n', abs(y(end)-y_exac(tf)));
    pausa(PASO_A_PASO);

    fprintf('═══ VERIFICACIÓN (Octave nativo: lsode) ═══\n\n');
    fode    = @(y, t) f(t, y);
    y_lsode = lsode(fode, y0, t);
    fprintf('   y(tf) lsode = %.6f   (dif con Euler = %.4e)\n\n', ...
            y_lsode(end), abs(y(end)-y_lsode(end)));

    tt = linspace(t0, tf, 300);
    figure;
    plot(tt, y_exac(tt), 'k-',  'LineWidth', 2); hold on;
    plot(t,  y,          'bo-', 'LineWidth', 1.5, 'MarkerFaceColor', 'b');
    plot(t,  y_lsode,    'r.--');
    grid on; xlabel('t'); ylabel('y');
    title(sprintf('Euler (h=%.2f) vs solución exacta', h));
    legend('exacta', 'Euler', 'lsode', 'Location', 'NorthWest');

    fprintf('Gráfica generada. Fin del Tema 6 (Euler).\n\n');
end

% =========================================================================
%  T6 - EULER MEJORADO (HEUN) y RUNGE-KUTTA 4
% =========================================================================
function t6_euler_mejorado_rk4()
    clc;
    PASO_A_PASO = false;   % <-- pon true para pausar entre pasos

    % --- DATOS (editar para el examen) ------------------------------------
    f      = @(t, y) y - t.^2 + 1;
    t0     = 0;  y0 = 0.5;  tf = 2;  h = 0.2;
    y_exac = @(t) (t+1).^2 - 0.5*exp(t);
    % ----------------------------------------------------------------------

    fprintf('\n');
    fprintf('╔═══════════════════════════════════════════════════════════════════╗\n');
    fprintf('║        EULER MEJORADO (HEUN) y RUNGE-KUTTA 4  -  PASO A PASO    ║\n');
    fprintf('╚═══════════════════════════════════════════════════════════════════╝\n\n');

    fprintf("PVI:  y' = y - t^2 + 1,   y(%.1f) = %.3f,  h = %.3f\n\n", t0, y0, h);

    N = round((tf - t0) / h) + 1;
    t = linspace(t0, tf, N);

    fprintf('═══ PASO 1: Euler mejorado (Heun) - predictor/corrector ═══\n\n');
    yH = zeros(1, N); yH(1) = y0;
    fprintf('   %3s  %8s  %12s  %12s  %12s  %12s\n', ...
            'i', 't_i', 'y_i', 'predictor', 'f_corr', 'y_{i+1}');
    for i = 1:N-1
        f1       = f(t(i), yH(i));
        ypre     = yH(i) + h*f1;
        f2       = f(t(i+1), ypre);
        yH(i+1)  = yH(i) + (h/2)*(f1 + f2);
        fprintf('   %3d  %8.3f  %12.6f  %12.6f  %12.6f  %12.6f\n', ...
                i-1, t(i), yH(i), ypre, f2, yH(i+1));
    end
    fprintf('\n');
    pausa(PASO_A_PASO);

    fprintf('═══ PASO 2: Runge-Kutta de 4º orden (k1..k4) ═══\n\n');
    yR = zeros(1, N); yR(1) = y0;
    fprintf('   %3s  %8s  %10s  %10s  %10s  %10s  %12s\n', ...
            'i', 't_i', 'k1', 'k2', 'k3', 'k4', 'y_{i+1}');
    for i = 1:N-1
        k1 = f(t(i),       yR(i));
        k2 = f(t(i)+h/2,   yR(i)+h/2*k1);
        k3 = f(t(i)+h/2,   yR(i)+h/2*k2);
        k4 = f(t(i)+h,     yR(i)+h*k3);
        yR(i+1) = yR(i) + (h/6)*(k1 + 2*k2 + 2*k3 + k4);
        fprintf('   %3d  %8.3f  %10.5f  %10.5f  %10.5f  %10.5f  %12.6f\n', ...
                i-1, t(i), k1, k2, k3, k4, yR(i+1));
    end
    fprintf('\n');
    pausa(PASO_A_PASO);

    yE = zeros(1, N); yE(1) = y0;
    for i = 1:N-1
        yE(i+1) = yE(i) + h*f(t(i), yE(i));
    end

    fprintf('═══ PASO 3: Comparación de errores en t = %.2f ═══\n\n', tf);
    ye = y_exac(t);
    fprintf('   %3s  %8s  %12s  %12s  %12s  %12s\n', ...
            'i', 't_i', 'Euler', 'Heun', 'RK4', 'exacta');
    for i = 1:N
        fprintf('   %3d  %8.3f  %12.6f  %12.6f  %12.6f  %12.6f\n', ...
                i-1, t(i), yE(i), yH(i), yR(i), ye(i));
    end
    fprintf('\n   |error| final:\n');
    fprintf('     Euler        = %.4e\n', abs(yE(end)-ye(end)));
    fprintf('     Heun         = %.4e\n', abs(yH(end)-ye(end)));
    fprintf('     Runge-Kutta4 = %.4e   <- el más preciso\n\n', abs(yR(end)-ye(end)));
    pausa(PASO_A_PASO);

    fprintf('═══ VERIFICACIÓN (Octave nativo: lsode) ═══\n\n');
    y_lsode = lsode(@(y,t) f(t,y), y0, t);
    fprintf('   y(tf) lsode = %.6f   (dif con RK4 = %.4e)\n\n', ...
            y_lsode(end), abs(yR(end)-y_lsode(end)));

    tt = linspace(t0, tf, 300);
    figure;
    plot(tt, y_exac(tt), 'k-',  'LineWidth', 2); hold on;
    plot(t, yE, 'ms:',  'LineWidth', 1.2, 'MarkerFaceColor', 'm');
    plot(t, yH, 'bo--', 'LineWidth', 1.2, 'MarkerFaceColor', 'b');
    plot(t, yR, 'g^-',  'LineWidth', 1.2, 'MarkerFaceColor', 'g');
    grid on; xlabel('t'); ylabel('y');
    title(sprintf('Euler vs Heun vs RK4 (h=%.2f)', h));
    legend('exacta', 'Euler', 'Heun', 'RK4', 'Location', 'NorthWest');

    fprintf('Gráfica generada. Fin del Tema 6 (Heun y RK4).\n\n');
end
