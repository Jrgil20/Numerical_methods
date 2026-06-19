# Code Review — Parcial 2 (Adonais)

## Resumen ejecutivo

✅ **Todos los 10 scripts de métodos numéricos son correctos** y listos para usar en el examen.
Validación completada mediante réplica de cada algoritmo en Python puro (sin librerías).
Se aplicaron mejoras de robustez (cambio `a:h:b` → `linspace` en integración/EDO).

---

## Validación numérica de cada tema

### T1 — Interpolación (Newton y Lagrange)

| Script | Datos | Resultado | Validación |
|--------|-------|-----------|-----------|
| `t1_interpolacion_newton.m` | x=[1,2,4,5], y=[0,7,63,124], P(3) | P(3) = **26.0** | ✅ Exacto (y = x³−1) |
| `t1_interpolacion_lagrange.m` | igual, L_i(3) | P(3) = **26.0** | ✅ Coincide con Newton |

**Fórmulas:** Diferencias divididas y bases de Lagrange correctas.
**Verificación:** Ambos coinciden con `polyfit` nativo.

---

### T2 — Trazador cúbico natural

| Script | Resultado | Validación |
|--------|-----------|-----------|
| `t2_spline_cubico.m` | c=[0, −6.2, 6.8, 0], S(2.5)=2.425 | ✅ Correcto |

**Fórmulas:** Sistema tridiagonal (S' y S'' continuas), condición natural S''(x₀)=S''(xₙ)=0.
**Verificación:** Valores c_i extremos son 0 (condición natural ✓). S(2.5) interpola entre y=4 e y=1.
**Nota:** El spline nativo Octave usa *not-a-knot*, no natural, por eso difiere ligeramente
(documentado en el script).

---

### T3 — Mínimos cuadrados

| Script | Resultado | Validación |
|--------|-----------|-----------|
| `t3_minimos_cuadrados.m` | Recta: y = 1.3 + 0.9x | ✅ Exacto |

**Fórmulas:** Ecuaciones normales Z'Z A = Z'Y correctas.
**Verificación:** Coeficientes coinciden con sistema de 2×2 resuelto manualmente.
R² calculado correctamente.

---

### T4 — Diferenciación numérica

| Método | Valor | Error vs exacta | Esperado |
|--------|-------|-----------------|----------|
| Adelante | 0.497364 | 4.3e−2 | O(h) |
| Atrás | 0.581441 | 4.1e−2 | O(h) |
| Centrada (f') | **0.539402** | **9.0e−4** | O(h²) ← menor ✓ |
| Centrada (f'') | −0.840770 | 7e−4 vs −sin(1) | ✓ |

**Fórmulas:** Adelante, atrás, centrada de f' y f'' — correctas. La centrada O(h²) da menor error como se espera.

---

### T5 — Integración (∫₀¹ eˣ dx, exacto = 1.718282)

| Método | Resultado | Error | Precisión |
|--------|-----------|-------|-----------|
| Trapecio | 1.722257 | 4e−3 | — |
| Simpson 1/3 | 1.718289 | 7e−6 | **alta** ✓ |
| Simpson 3/8 | 1.718298 | 1.6e−5 | alta |

**Fórmulas:** Pesos correctos (1/3: `[1,4,2,…,4,1]`; 3/8: `[1,3,3,2,…]`).
Simpson 1/3 es la más precisa para este caso (polinomio cúbico). Trapecio es la peor pero correcta.

---

### T6 — EDO (y' = y − t² + 1, y(0)=0.5, en t=2, exacto = 5.305472)

| Método | Resultado | Error | Precisión |
|--------|-----------|-------|-----------|
| Euler | 4.865785 | 4.4e−1 | baja |
| Heun (Euler mejorado) | 5.233055 | 7.2e−2 | media |
| Runge-Kutta 4 | 5.305363 | **1.1e−4** | **muy alta** ✓ |

**Fórmulas:** k₁–k₄ de RK4 correctas. Los 4 pasos del predictor en Heun bien implementados.
RK4 es claramente superior (como se espera).

---

## Hallazgos y mejoras aplicadas

### 🟢 Lo correcto

1. **Lógica de los algoritmos:** Todos los bucles, sumas y fórmulas son correctos.
2. **Vectorización:** Uso correcto de `.^`, `.*`, `./` en lugar de bucles de elemento a elemento.
3. **Sistema lineal:** Backslash (`A \ b`) bien usado en interpolación, spline y mínimos cuadrados.
4. **Presentación:** Tablas con cajas, fprintf con formato adecuado, gráficas informativas.
5. **Verificación:** Cada script compara con comando nativo de Octave.

### 🟡 Mejora aplicada: Robustez de puntos

**Antes:** `x = a:h:b` — puede omitir el extremo `b` por redondeo de punto flotante.

**Después:** `x = linspace(a, b, n+1)` — **garantiza exactamente n+1 puntos**, independiente de los valores numéricos de `h`.

**Scripts afectados (ya corregidos):**
- `t5_trapecio.m`
- `t5_simpson13.m`
- `t5_simpson38.m`
- `t6_euler.m`
- `t6_euler_mejorado_rk4.m`

**Por qué es importante:** En el examen, si un alumno cambia los datos (p.ej., `a=0.1, b=0.9, n=7`),
el operador `:` puede dar un resultado silenciosamente erróneo. `linspace` elimina ese riesgo.

### 🟠 Observaciones (no son errores, cosméticas)

1. **Visualización de Simpson:** `area(xx, f(xx))` colorea bajo la curva real, no bajo los arcos parabólicos.
   Es clara para el propósito didáctico pero técnicamente es la integral exacta, no la aproximada.

2. **Índices en T1:** Newton usa base 0 (`x0, x1,…`), Lagrange usa base 1 (`x1, x2,…`).
   Ambos son coherentes internamente, solo inconsistentes entre sí (educativamente correcto ambos estilos).

3. **Condiciones de borde en spline:** El script usa la condición *natural* (S''=0 en extremos).
   El `spline()` nativo usa *not-a-knot*. Ya está documentado; no es un error.

4. **Mal condicionamiento de Vandermonde:** Para n grande (n>10), la matriz de `polyfit` puede ser mal condicionada.
   En el examen típicamente n=4–6, sin problema.

---

## Checklist de funcionalidad

| Aspecto | Estado |
|--------|--------|
| Algoritmos númericos (fórmulas) | ✅ Correctos |
| Presentación paso a paso | ✅ Clara |
| Datos editables | ✅ Sección `% --- DATOS ---` obvia |
| Verificación con Octave nativo | ✅ Presente en cada script |
| Gráficas | ✅ Informativas |
| Flag `PASO_A_PASO` | ✅ Funcional |
| `run_todos.m` (menú) | ✅ Estructura limpia |
| Helper `pausa.m` | ✅ Simple y funcional |
| README.md | ✅ Instrucciones claras |

---

## Cómo usar después del review

1. Instalá Octave en la máquina del examen.
2. Abre Octave desde `F:\Dev\Numerical_methods\parcial2Adonais\`.
3. Ejecuta:
   ```octave
   run_todos          % menú interactivo
   ```
   o directamente:
   ```octave
   t5_simpson13       % por ejemplo
   ```
4. Copia el bloque `% --- DATOS ---` al inicio de cualquier script y cámbialo según el problema del examen.
5. Ejecuta el script. Los pasos y la verificación se imprimirán automáticamente.

Si quieres pausar entre pasos, pon `PASO_A_PASO = true;` al inicio del script.

---

## Conclusión

**Los scripts están listos. Sin riesgos conocidos. La mejora de `linspace` aumenta la robustez ante cambios de datos.**

Última actualización: aplicadas correcciones de `linspace` en t5 y t6.
