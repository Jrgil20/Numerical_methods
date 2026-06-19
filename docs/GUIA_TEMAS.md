# Guía de Temas y Fórmulas — Métodos Numéricos

Referencia rápida de fórmulas clave y comandos nativos de Octave para cada tema.

---

## 1️⃣ Interpolación Polinomial

### Fórmulas

**Newton (Diferencias Divididas):**
```
P_n(x) = f[x_0] + f[x_0,x_1](x-x_0) + f[x_0,x_1,x_2](x-x_0)(x-x_1) + ...

donde f[x_i..x_j] = (f[x_{i+1}..x_j] - f[x_i..x_{j-1}]) / (x_j - x_i)
```

**Lagrange (Bases):**
```
P_n(x) = Σ y_i · L_i(x)

donde L_i(x) = Π_{j≠i} (x - x_j)/(x_i - x_j)
```

### Comandos Octave

```octave
% Interpolación
interp1(x, y, xi, 'method')    % method = 'linear', 'spline', 'pchip'

% Polinomios
polyfit(x, y, n)               % coeficientes del polinomio grado n
polyval(p, x)                  % evaluar polinomio p en x
```

### Scripts de referencia

- Manual: `00-Fundamentos/03-Interpolacion/lagrange_interpolacion.m`
- Paso a paso: `04-Parcial2-Adonais/t1_interpolacion_*.m`

---

## 2️⃣ Trazadores (Splines)

### Fórmulas

**Spline Cúbico Natural:** En cada tramo [x_i, x_{i+1}]:
```
S_i(x) = a_i + b_i(x-x_i) + c_i(x-x_i)² + d_i(x-x_i)³

Condiciones:
- S'  continua en nodos interiores
- S'' continua en nodos interiores
- S''(x_0) = S''(x_n) = 0  (natural)
```

Sistema tridiagonal para las segundas derivadas c_i:
```
h_{i-1}·c_{i-1} + 2(h_{i-1}+h_i)·c_i + h_i·c_{i+1} = 
    3[f[x_i,x_{i+1}] - f[x_{i-1},x_i]]
```

### Comandos Octave

```octave
spline(x, y, xi)      % spline (nota: usa not-a-knot, no natural)
```

### Scripts de referencia

- Manual: `04-Parcial2-Adonais/t2_spline_cubico.m`

---

## 3️⃣ Ajuste de Curvas (Mínimos Cuadrados)

### Fórmulas

**Ecuaciones Normales:**
```
[Z]^T [Z] {A} = [Z]^T {Y}

donde Z = matriz de diseño (Vandermonde para polinom.)
```

**Matriz Z (grado g):**
```
Z = [ 1     x_1    x_1²  ... x_1^g ]
    [ 1     x_2    x_2²  ... x_2^g ]
    [ ...                         ]
    [ 1     x_N    x_N²  ... x_N^g ]
```

**Error y bondad:**
```
Sr = Σ (y_i - y_pred_i)²          % suma de residuos al cuadrado
St = Σ (y_i - ȳ)²                 % suma total
R² = 1 - Sr/St                     % coef. de determinación
```

### Comandos Octave

```octave
polyfit(x, y, g)                  % coeficientes, grado g
polyval(p, x)                     % evaluar
roots(p)                          % raíces del polinomio
```

### Scripts de referencia

- Manual: `04-Parcial2-Adonais/t3_minimos_cuadrados.m`

---

## 4️⃣ Diferenciación Numérica

### Fórmulas

**Primera derivada:**
```
Adelante  (O(h)):    f'(x) ≈ [f(x+h) - f(x)] / h
Atrás     (O(h)):    f'(x) ≈ [f(x) - f(x-h)] / h
Centrada  (O(h²)):   f'(x) ≈ [f(x+h) - f(x-h)] / (2h)   ← mejor
```

**Segunda derivada:**
```
Centrada  (O(h²)):   f''(x) ≈ [f(x-h) - 2f(x) + f(x+h)] / h²
```

### Comandos Octave

```octave
diff(y) ./ diff(x)                % derivada con diff
gradient(y, h)                    % derivada centrada
```

### Scripts de referencia

- Manual: `04-Parcial2-Adonais/t4_diferenciacion.m`

---

## 5️⃣ Integración Numérica

### Fórmulas

**Trapecio Compuesta:**
```
I ≈ (h/2) [ f(x_0) + f(x_n) + 2·Σ_{i=1}^{n-1} f(x_i) ]

Error: O(h²)  (lento)
```

**Simpson 1/3 Compuesta (n par):**
```
I ≈ (h/3) [ f(x_0) + f(x_n) + 4·Σ(índices impares) + 2·Σ(índices pares) ]

Pesos: [1, 4, 2, 4, 2, ..., 4, 2, 4, 1]
Error: O(h⁴)  (muy bueno)
```

**Simpson 3/8 Compuesta (n múltiplo de 3):**
```
I ≈ (3h/8) [ f(x_0) + f(x_n) + 3·Σ(no múlt. 3) + 2·Σ(múltiplos de 3) ]

Pesos: [1, 3, 3, 2, 3, 3, 2, ..., 3, 3, 1]
Error: O(h⁴)
```

### Comandos Octave

```octave
trapz(x, y)                       % trapecio
quad(f, a, b)                     % integración adaptativa
```

### Scripts de referencia

- Manual: `04-Parcial2-Adonais/t5_*.m`

---

## 6️⃣ Ecuaciones Diferenciales (EDO)

### Fórmulas

**Problema:** y' = f(t, y),  y(t_0) = y_0

**Euler (O(h)):**
```
y_{i+1} = y_i + h·f(t_i, y_i)

Error local: O(h²)
Error global: O(h)
```

**Euler Mejorado / Heun (O(h²)):**
```
predictor:  y* = y_i + h·f(t_i, y_i)
corrector:  y_{i+1} = y_i + (h/2)[f(t_i, y_i) + f(t_{i+1}, y*)]

Error global: O(h²)
```

**Runge-Kutta 4 (O(h⁴)):**
```
k₁ = f(t_i, y_i)
k₂ = f(t_i + h/2, y_i + h/2·k₁)
k₃ = f(t_i + h/2, y_i + h/2·k₂)
k₄ = f(t_i + h, y_i + h·k₃)

y_{i+1} = y_i + (h/6)(k₁ + 2k₂ + 2k₃ + k₄)

Error global: O(h⁴)  ← muy preciso
```

### Comandos Octave

```octave
lsode(@(y,t) f(t,y), y0, t)      % solver ODE robusto
```

### Scripts de referencia

- Manual: `04-Parcial2-Adonais/t6_*.m`

---

## 📊 Resumen de órdenes de error

| Método | Error local | Error global | Velocidad |
|--------|------------|--------------|-----------|
| Euler | O(h²) | O(h) | Lenta |
| Euler mejorado / Heun | O(h³) | O(h²) | Media |
| RK4 | O(h⁵) | O(h⁴) | Rápida |
| Trapecio | O(h³) | O(h²) | Media |
| Simpson 1/3 | O(h⁵) | O(h⁴) | Rápida |
| Bisección | — | O(h) | Lenta |
| Newton | — | O(h²) | Muy rápida |

---

## 💡 Tips Pro para el examen

1. **Sistema de ecuaciones → backslash:** `x = A \ b;` (más estable que inversa)

2. **Polinomios en Octave:** Los coeficientes van de **mayor a menor grado**: `p = [a_n, ..., a_1, a_0]`

3. **Vectorización:** Usa operadores con punto: `x.^2`, `sin(x)`, etc.

4. **Gráficas interactivas:**
   ```octave
   plot(x, y, 'b-', 'LineWidth', 2);
   hold on;
   plot(x, y_approx, 'r--');
   grid on;
   legend('exacta', 'aprox');
   ```

5. **Para integración/ODEs:** Usa `linspace(a, b, n)` en lugar de `a:h:b` (más robusto)

6. **Verificación rápida:** Compara tu resultado manual con el comando nativo
   ```octave
   y_manual = ...       % tu implementación
   y_native = trapz(x,y) % Octave
   fprintf('diff = %.2e\n', abs(y_manual - y_native))
   ```

---

**Última actualización:** 2026-06-19
