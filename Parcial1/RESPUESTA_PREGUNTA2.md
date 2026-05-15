# PREGUNTA 2: NEWTON vs BISECCIÓN para √2

## Enunciado

Ejecute dos iteraciones del esquema anterior (Método de Newton) para $R = 2$ con $x_0 = 1$ y dos iteraciones del método de Bisección en el intervalo $[1, 2]$.

Luego responda: **¿Cuántas iteraciones son necesarias para que cada método alcance una precisión del orden de $10^{-3}$?**

---

## PARTE A: DOS ITERACIONES DE CADA MÉTODO

### MÉTODO 1: NEWTON PARA √2

**Parámetros:**
- Radicando: $R = 2$
- Fórmula de iteración: $x_{n+1} = \frac{1}{2}\left(x_n + \frac{R}{x_n}\right)$
- Punto inicial: $x_0 = 1.0$
- Valor exacto: $\sqrt{2} = 1.414213562373095...$

#### Iteración 0 (Estado Inicial)

$$x_0 = 1.0$$

Error absoluto:
$$e_0 = x_0 - \sqrt{2} = 1.0 - 1.414213562... = -0.414213562... = -4.142135623730950 \times 10^{-1}$$

Error relativo:
$$\delta_0 = \frac{e_0}{\sqrt{2}} = \frac{-0.414213562}{1.414213562} = -0.292893219...$$

#### Iteración 1

Aplicamos la fórmula de Newton:

$$x_1 = \frac{1}{2}\left(x_0 + \frac{2}{x_0}\right) = \frac{1}{2}\left(1.0 + \frac{2}{1.0}\right) = \frac{1}{2}(1.0 + 2.0) = \frac{1}{2}(3.0) = 1.5$$

Error absoluto:
$$e_1 = x_1 - \sqrt{2} = 1.5 - 1.414213562 = 0.085786437... = 8.578643762690485 \times 10^{-2}$$

Error relativo:
$$\delta_1 = \frac{e_1}{\sqrt{2}} = \frac{0.0857864}{1.414213562} = 0.0606601718...$$

**Observación**: $|e_1| = 0.0858 > 10^{-3}$, no cumple la tolerancia.

#### Iteración 2

Aplicamos la fórmula nuevamente:

$$x_2 = \frac{1}{2}\left(x_1 + \frac{2}{x_1}\right) = \frac{1}{2}\left(1.5 + \frac{2}{1.5}\right)$$

$$= \frac{1}{2}\left(1.5 + 1.333333...\right) = \frac{1}{2}(2.833333...) = 1.416666...$$

$$x_2 = 1.416666666666667$$

Error absoluto:
$$e_2 = x_2 - \sqrt{2} = 1.416666... - 1.414213562 = 0.002453104... = 2.453104293571373 \times 10^{-3}$$

Error relativo:
$$\delta_2 = \frac{e_2}{\sqrt{2}} = \frac{0.00245310}{1.414213562} = 1.734606680... \times 10^{-3}$$

**Observación**: $|e_2| = 0.002453 > 10^{-3}$ por muy poco (apenas no cumple la tolerancia estricta, pero está muy cerca).

**Tabla Resumen - NEWTON**

| $n$ | $x_n$ | $e_n = x_n - \sqrt{2}$ | $\|e_n\|$ | $\|e_n\| < 10^{-3}$? |
|---|---|---|---|---|
| 0 | 1.000000000 | -0.414213562 | 4.142136e-01 | **NO** |
| 1 | 1.500000000 | 0.085786438 | 8.578644e-02 | **NO** |
| 2 | 1.416666667 | 0.002453104 | 2.453104e-03 | **NO** (apenas) |

---

### MÉTODO 2: BISECCIÓN EN [1, 2] PARA √2

**Parámetros:**
- Función objetivo: $f(x) = x^2 - 2$
- Intervalo inicial: $[a, b] = [1, 2]$
- Fórmula de iteración: $c = \frac{a + b}{2}$
- Criterio de parada: $\frac{b - a}{2} \leq \text{tolerancia}$

**Verificación de Cambio de Signo** (Teorema de Bolzano):
- $f(a) = f(1) = 1^2 - 2 = -1 < 0$ ✓
- $f(b) = f(2) = 2^2 - 2 = 2 > 0$ ✓
- $f(a) \cdot f(b) = (-1) \cdot 2 = -2 < 0$ ✓ → Bisección puede aplicarse

#### Iteración 1

**Estado inicial:**
- $a_1 = 1.0$
- $b_1 = 2.0$

**Calcular punto medio:**
$$c_1 = \frac{a_1 + b_1}{2} = \frac{1.0 + 2.0}{2} = 1.5$$

**Evaluar función:**
- $f(a_1) = f(1) = -1.0$
- $f(c_1) = f(1.5) = (1.5)^2 - 2 = 2.25 - 2 = 0.25$
- $f(b_1) = f(2) = 2.0$

**Determinar nuevo intervalo:**

Verificamos en qué subintervalo está la raíz:
$$f(a_1) \times f(c_1) = (-1.0) \times 0.25 = -0.25 < 0$$

**La raíz está en $[a_1, c_1] = [1.0, 1.5]$**, por lo que:
- $a_2 = 1.0$
- $b_2 = 1.5$

**Error de la iteración:**
$$\text{error}_1 = \frac{b_1 - a_1}{2} = \frac{2.0 - 1.0}{2} = 0.5$$

**Observación**: $0.5 > 10^{-3}$, no cumple la tolerancia.

#### Iteración 2

**Estado:**
- $a_2 = 1.0$
- $b_2 = 1.5$

**Calcular punto medio:**
$$c_2 = \frac{a_2 + b_2}{2} = \frac{1.0 + 1.5}{2} = 1.25$$

**Evaluar función:**
- $f(a_2) = f(1) = -1.0$
- $f(c_2) = f(1.25) = (1.25)^2 - 2 = 1.5625 - 2 = -0.4375$
- $f(b_2) = f(1.5) = 0.25$

**Determinar nuevo intervalo:**

Verificamos:
$$f(c_2) \times f(b_2) = (-0.4375) \times 0.25 = -0.109375 < 0$$

**La raíz está en $[c_2, b_2] = [1.25, 1.5]$**, por lo que:
- $a_3 = 1.25$
- $b_3 = 1.5$

**Error de la iteración:**
$$\text{error}_2 = \frac{b_2 - a_2}{2} = \frac{1.5 - 1.0}{2} = 0.25$$

**Observación**: $0.25 > 10^{-3}$, no cumple la tolerancia.

**Tabla Resumen - BISECCIÓN**

| $n$ | $a_n$ | $b_n$ | $c_n$ | error$_n$ | $< 10^{-3}$? |
|---|---|---|---|---|---|
| 0 | 1.000000 | 2.000000 | 1.500000 | 5.000e-01 | **NO** |
| 1 | 1.000000 | 1.500000 | 1.250000 | 2.500e-01 | **NO** |
| 2 | 1.250000 | 1.500000 | 1.375000 | 1.250e-01 | **NO** |

---

## PARTE B: CUÁNTAS ITERACIONES PARA PRECISIÓN 10^{-3}?

### MÉTODO NEWTON

Continuamos iterando hasta que $|e_n| < 10^{-3}$:

| $n$ | $x_n$ | $\|e_n\| = \|x_n - \sqrt{2}\|$ | $< 10^{-3}$? |
|---|---|---|---|
| 0 | 1.000000000 | 4.142135624e-01 | NO |
| 1 | 1.500000000 | 8.578643763e-02 | NO |
| 2 | 1.416666667 | 2.453104294e-03 | NO |
| **3** | **1.414215686** | **2.123901415e-06** | **SÍ ✓** |

**Cálculo de iteración 3:**

$$x_3 = \frac{1}{2}\left(x_2 + \frac{2}{x_2}\right) = \frac{1}{2}\left(1.416666667 + \frac{2}{1.416666667}\right)$$

$$= \frac{1}{2}(1.416666667 + 1.411764705) = \frac{1}{2}(2.828431372)$$

$$x_3 = 1.414215686...$$

Error:
$$e_3 = 1.414215686 - 1.414213562 = 0.000002124 = 2.124 \times 10^{-6} < 10^{-3}$$ ✓

**✓ NEWTON REQUIERE 3 ITERACIONES**

### MÉTODO BISECCIÓN

Continuamos iterando hasta que $\frac{b_n - a_n}{2} < 10^{-3}$:

| $n$ | $a_n$ | $b_n$ | $c_n$ | error$_n$ | $< 10^{-3}$? |
|---|---|---|---|---|---|
| 0 | 1.0000000000 | 2.0000000000 | 1.5000000000 | 5.0000e-01 | NO |
| 1 | 1.0000000000 | 1.5000000000 | 1.2500000000 | 2.5000e-01 | NO |
| 2 | 1.2500000000 | 1.5000000000 | 1.3750000000 | 1.2500e-01 | NO |
| 3 | 1.3750000000 | 1.5000000000 | 1.4375000000 | 6.2500e-02 | NO |
| 4 | 1.3750000000 | 1.4375000000 | 1.4062500000 | 3.1250e-02 | NO |
| 5 | 1.4062500000 | 1.4375000000 | 1.4218750000 | 1.5625e-02 | NO |
| 6 | 1.4062500000 | 1.4218750000 | 1.4140625000 | 7.8125e-03 | NO |
| 7 | 1.4140625000 | 1.4218750000 | 1.4179687500 | 3.9063e-03 | NO |
| 8 | 1.4140625000 | 1.4179687500 | 1.4160156250 | 1.9531e-03 | NO |
| **9** | **1.4140625000** | **1.4160156250** | **1.4150390625** | **9.7656e-04** | **SÍ ✓** |

**✓ BISECCIÓN REQUIERE 9 ITERACIONES**

---

## ANÁLISIS Y COMPARACIÓN

### Resultado Final

| Método | Iteraciones | Convergencia |
|--------|---|---|
| **Newton** | **3** | Cuadrática (orden $p=2$) |
| **Bisección** | **9** | Lineal (orden $p=1$) |
| **Ratio** | **3.0×** | — |

### Interpretación

**Newton es 3 veces más eficiente que Bisección** para alcanzar precisión de $10^{-3}$.

Bisección requiere $\frac{9}{3} = 3$ veces más iteraciones.

### Justificación Teórica

#### 1. NEWTON - Convergencia Cuadrática (Orden $p = 2$)

La fórmula del error absoluto que demostramos es:
$$e_{n+1} = \frac{e_n^2}{2x_n}$$

Esto implica:
$$|e_{n+1}| \leq C |e_n|^2$$

donde $C = \frac{1}{2x_n} \approx \frac{1}{2\sqrt{2}} \approx 0.35$ cerca de la solución.

**Comportamiento del error:**
- $e_0 = -0.414$ → $|e_0| \approx 0.4$
- $e_1 = 0.086$ → $|e_1| \approx (0.4)^2 \times C \approx 0.057$
- $e_2 = 0.0025$ → $|e_2| \approx (0.057)^2 \times C \approx 0.001$
- $e_3 = 0.000002$ → $|e_3| \approx (0.001)^2 \times C \approx 10^{-7}$

**El error se eleva al cuadrado cada iteración** → Convergencia exponencial en precisión.

#### 2. BISECCIÓN - Convergencia Lineal (Orden $p = 1$)

La fórmula del error es:
$$\text{error}_n = \frac{b_0 - a_0}{2^{n+1}} = \frac{1}{2^{n+1}}$$

Esto implica:
$$|e_{n+1}| = \frac{1}{2}|e_n|$$

**Comportamiento del error:**
- error$_0$ = 1/2 = 0.5
- error$_1$ = 1/4 = 0.25
- error$_2$ = 1/8 = 0.125
- ...
- error$_8$ = 1/512 ≈ 0.00195 (aún no)
- error$_9$ = 1/1024 ≈ 0.000977 ✓

**El error se reduce por factor constante cada iteración** → Convergencia lineal.

#### 3. Fórmula Teórica para Bisección

Para alcanzar tolerancia $\epsilon$ con bisección:

$$\frac{b_0 - a_0}{2^{n+1}} < \epsilon$$

$$2^{n+1} > \frac{b_0 - a_0}{\epsilon}$$

$$n + 1 > \log_2\left(\frac{b_0 - a_0}{\epsilon}\right)$$

$$n \geq \log_2\left(\frac{b_0 - a_0}{\epsilon}\right) - 1$$

Para nuestro caso:
$$n \geq \log_2\left(\frac{2 - 1}{10^{-3}}\right) - 1 = \log_2(1000) - 1 \approx 9.97 - 1 = 8.97$$

Por lo tanto, se necesitan $n \geq 9$ iteraciones (coincide con nuestro cálculo).

### Comparación de Órdenes de Convergencia

| Característica | Newton ($p=2$) | Bisección ($p=1$) |
|---|---|---|
| **Definición** | $\|e_{n+1}\| \leq C\|e_n\|^2$ | $\|e_{n+1}\| = \frac{1}{2}\|e_n\|$ |
| **Cifras exactas** | Se duplican cada iteración | Se añade 1 cada 3-4 iteraciones |
| **Iteraciones para $10^{-3}$** | 3 | 9 |
| **Iteraciones para $10^{-6}$** | 4 | ~20 |
| **Ventaja** | Extraordinariamente rápido | Garantizado con cambio de signo |
| **Desventaja** | Requiere $f'(x)$ | Lento para alta precisión |

---

## CONCLUSIÓN

### Respuesta a la Pregunta

**Para alcanzar una precisión del orden de $10^{-3}$ cuando se calcula $\sqrt{2}$:**

- **Método de Newton**: **3 iteraciones** (convergencia cuadrática)
- **Método de Bisección**: **9 iteraciones** (convergencia lineal)

### Resumen Conceptual

1. **Newton es 3× más eficiente** que bisección para este problema
2. **Newton duplica dígitos correctos** cada iteración → convergencia exponencial en precisión
3. **Bisección reduce error por factor 2** cada iteración → convergencia lineal
4. Esta diferencia se amplifica enormemente para **precisiones más altas**:
   - Para $10^{-6}$: Newton ≈ 4 iters, Bisección ≈ 20 iters
   - Para $10^{-15}$ (máquina): Newton ≈ 5 iters, Bisección ≈ 50 iters

### Implicación Práctica

**El Método de Newton es la opción preferida para calcular raíces cuadradas** cuando se requiere alta precisión, porque:
- ✓ Converge cuadráticamente (extraordinariamente rápido)
- ✓ Requiere muy pocas iteraciones (~4-5 para máxima precisión)
- ✓ Económico en tiempo computacional
- ✗ Requiere derivada (pero para raíces es trivial)

---

## Validación Numérica

Script Octave: `Pregunta2_Newton_vs_Biseccion.m`

Ejecutar con:
```bash
octave Pregunta2_Newton_vs_Biseccion.m
```

Verifica:
- ✓ 2 iteraciones de Newton paso a paso
- ✓ 2 iteraciones de Bisección paso a paso
- ✓ Cuántas iteraciones hasta precisión $10^{-3}$
- ✓ Tabla comparativa completa
- ✓ Análisis teórico de convergencia
