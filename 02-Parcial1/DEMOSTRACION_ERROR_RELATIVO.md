# Demostración: Error Relativo y Convergencia Cuadrática

## Problema Demostrado

Demostrar que para el Método de Newton aplicado al cálculo de $\sqrt{R}$:

$$\frac{e_{n+1}}{\sqrt{R}} = \left(\frac{e_n}{\sqrt{R}}\right)^2 \cdot \frac{\sqrt{R}}{2x_n}$$

donde $e_n = x_n - \sqrt{R}$ es el error absoluto en la iteración $n$.

---

## Derivación Algebraica

### Paso 1: Partir de la fórmula de error absoluto

Ya hemos demostrado que:
$$e_{n+1} = \frac{e_n^2}{2x_n} \quad \cdots (1)$$

### Paso 2: Dividir ambos lados por $\sqrt{R}$

$$\frac{e_{n+1}}{\sqrt{R}} = \frac{e_n^2/(2x_n)}{\sqrt{R}} = \frac{e_n^2}{2x_n\sqrt{R}} \quad \cdots (2)$$

### Paso 3: Reescribir el numerador

Observamos que:
$$\left(\frac{e_n}{\sqrt{R}}\right)^2 = \frac{e_n^2}{R}$$

Por lo tanto:
$$e_n^2 = \left(\frac{e_n}{\sqrt{R}}\right)^2 \cdot R$$

### Paso 4: Sustituir en la ecuación (2)

$$\frac{e_{n+1}}{\sqrt{R}} = \frac{\left(\frac{e_n}{\sqrt{R}}\right)^2 \cdot R}{2x_n\sqrt{R}}$$

$$= \left(\frac{e_n}{\sqrt{R}}\right)^2 \cdot \frac{R}{2x_n\sqrt{R}}$$

$$= \left(\frac{e_n}{\sqrt{R}}\right)^2 \cdot \frac{\sqrt{R} \cdot \sqrt{R}}{2x_n\sqrt{R}}$$

$$= \left(\frac{e_n}{\sqrt{R}}\right)^2 \cdot \frac{\sqrt{R}}{2x_n}$$

### ✓ Fórmula Demostrada

$$\boxed{\frac{e_{n+1}}{\sqrt{R}} = \left(\frac{e_n}{\sqrt{R}}\right)^2 \cdot \frac{\sqrt{R}}{2x_n}}$$

---

## Interpretación Conceptual

La fórmula muestra tres elementos clave:

1. **Error Relativo Cuadrado**: El lado izquierdo $\frac{e_{n+1}}{\sqrt{R}}$ es el error relativo en la iteración $n+1$

2. **Convergencia Cuadrática**: El primer factor $\left(\frac{e_n}{\sqrt{R}}\right)^2$ es el **cuadrado** del error relativo anterior. Esto significa que el error relativo se eleva al cuadrado en cada iteración.

3. **Factor de Normalización**: El factor $\frac{\sqrt{R}}{2x_n}$ ajusta la convergencia. Cerca de la solución, donde $x_n \approx \sqrt{R}$, este factor es aproximadamente $\frac{1}{2}$.

### Simplificación Cerca de la Raíz

Si $x_n \approx \sqrt{R}$, entonces:
$$\frac{\sqrt{R}}{2x_n} \approx \frac{\sqrt{R}}{2\sqrt{R}} = \frac{1}{2}$$

Por lo tanto:
$$\frac{e_{n+1}}{\sqrt{R}} \approx \frac{1}{2} \left(\frac{e_n}{\sqrt{R}}\right)^2$$

Si denotamos $\delta_n = \frac{e_n}{\sqrt{R}}$ (error relativo), obtenemos:
$$\delta_{n+1} \approx \frac{1}{2} \delta_n^2$$

Esto es **CONVERGENCIA CUADRÁTICA**: el error relativo se eleva al cuadrado en cada paso.

---

## Verificación Numérica

### Configuración

- **Radicando**: $R = 10$
- **Valor exacto**: $\sqrt{10} = 3.162277660168380...$
- **Punto inicial**: $x_0 = 3.00$

### Tabla de Verificación

| n | $e_n$ (error abs) | $e_n/\sqrt{R}$ (error rel) | $(e_n/\sqrt{R})^2$ | $\sqrt{R}/(2x_n)$ | Predicción | Real | Razón |
|---|-------------------|-----|--------|----------|---------|--------|--------|
| 0 | $-1.623 \times 10^{-1}$ | $-5.132 \times 10^{-2}$ | $2.633 \times 10^{-3}$ | $0.5270$ | $1.388 \times 10^{-3}$ | $1.388 \times 10^{-3}$ | 1.0000 |
| 1 | $4.389 \times 10^{-3}$ | $1.388 \times 10^{-3}$ | $1.926 \times 10^{-6}$ | $0.4993$ | $9.618 \times 10^{-7}$ | $9.618 \times 10^{-7}$ | 1.0000 |
| 2 | $3.042 \times 10^{-6}$ | $9.618 \times 10^{-7}$ | $9.251 \times 10^{-13}$ | $0.5000$ | $4.626 \times 10^{-13}$ | $4.626 \times 10^{-13}$ | 1.0001 |
| 3 | $1.463 \times 10^{-12}$ | $4.626 \times 10^{-13}$ | $2.140 \times 10^{-25}$ | $0.5000$ | $1.070 \times 10^{-25}$ | $\approx 0$ | — |
| 4 | $\approx 0$ | $\approx 0$ | $\approx 0$ | $0.5000$ | $\approx 0$ | $\approx 0$ | — |
| 5 | $-4.441 \times 10^{-16}$ | $-1.404 \times 10^{-16}$ | $1.972 \times 10^{-32}$ | $0.5000$ | $9.861 \times 10^{-33}$ | $\approx 0$ | — |

**Observaciones**:
- Las columnas "Predicción" y "Real" coinciden perfectamente para $n = 0, 1, 2$
- La razón está muy cerca de 1.0, confirmando la fórmula
- El factor $\sqrt{R}/(2x_n)$ converge a $0.5$ conforme $x_n \to \sqrt{R}$
- A partir de $n = 3$, el error está por debajo de la precisión de máquina ($\approx 2.22 \times 10^{-16}$)

### Convergencia del Error Relativo

| n | $\delta_n = e_n/\sqrt{R}$ | $\log_{10}(\delta_n)$ | Cifras exactas |
|---|--------------------------|-----|----------|
| 0 | $-5.1317 \times 10^{-2}$ | $-1.29$ | 1 |
| 1 | $1.3879 \times 10^{-3}$ | $-2.86$ | 2 |
| 2 | $9.6183 \times 10^{-7}$ | $-6.02$ | 6 |
| 3 | $4.6259 \times 10^{-13}$ | $-12.33$ | 12 |
| 4 | $\approx 0$ | $-15.00$ | 15 |

**Patrón evidente**: Las cifras exactas **se duplican (aproximadamente)** en cada iteración, lo que es una característica de la convergencia cuadrática.

---

## Relación con la Fórmula de Error Absoluto

Tenemos dos formas equivalentes de expresar la convergencia:

### Forma 1: Error Absoluto
$$e_{n+1} = \frac{e_n^2}{2x_n}$$

### Forma 2: Error Relativo
$$\frac{e_{n+1}}{\sqrt{R}} = \left(\frac{e_n}{\sqrt{R}}\right)^2 \cdot \frac{\sqrt{R}}{2x_n}$$

### Equivalencia

Dividiendo la Forma 1 por $\sqrt{R}$:
$$\frac{e_{n+1}}{\sqrt{R}} = \frac{e_n^2/(2x_n)}{\sqrt{R}} = \frac{e_n^2}{R} \cdot \frac{\sqrt{R}}{2x_n} = \left(\frac{e_n}{\sqrt{R}}\right)^2 \cdot \frac{\sqrt{R}}{2x_n}$$

Esto es exactamente la Forma 2. Ambas expresiones son equivalentes, pero se usan en contextos diferentes:

- **Forma 1** (error absoluto): Útil para análisis de precisión absoluta y para implementación práctica
- **Forma 2** (error relativo): Útil para análisis de convergencia teórica y para problemas adimensionales

---

## Implicaciones Prácticas

### 1. Convergencia Extraordinariamente Rápida

La convergencia cuadrática significa que el número de dígitos correctos se **duplica** aproximadamente en cada iteración.

### 2. Precisión Máxima Alcanzada

Utilizando aritmética de doble precisión (épsilon de máquina $\approx 2.22 \times 10^{-16}$):
- Después de 3-4 iteraciones, se alcanza la precisión máxima
- Iteraciones adicionales no mejoran la precisión (limitada por el redondeo)

### 3. Estimación de Iteraciones Requeridas

Para una precisión de $\epsilon$:
$$n \approx \log_2\left(\frac{|\log \epsilon|}{|\log \delta_0|}\right)$$

### 4. Robustez del Método

El factor $\sqrt{R}/(2x_n)$ permanece acotado (entre 0.4 y 0.6) para aproximaciones razonables, garantizando convergencia.

---

## Conclusión

### Lo que hemos demostrado:

1. **Algebraicamente**: La fórmula del error relativo $\frac{e_{n+1}}{\sqrt{R}} = \left(\frac{e_n}{\sqrt{R}}\right)^2 \cdot \frac{\sqrt{R}}{2x_n}$ se sigue directamente del error absoluto.

2. **Numéricamente**: La verificación con $\sqrt{10}$ confirma perfectamente la teoría, con razones muy cercanas a 1.0.

3. **Conceptualmente**: El Método de Newton exhibe **convergencia cuadrática**, una propiedad rara y deseable en métodos numéricos.

4. **Equivalencia**: Las formas de error absoluto y relativo son expresiones diferentes del mismo fenómeno subyacente.

### Conclusión General sobre el Método de Newton

El Método de Newton para calcular raíces cuadradas es **extraordinariamente eficiente** debido a su convergencia cuadrática. Esto lo hace superior a otros métodos iterativos como bisección (convergencia lineal) o secante (convergencia superlineal).

---

## Referencias Teóricas

- **Convergencia Cuadrática**: Propiedad de que el error se comporta como $e_{n+1} \propto e_n^2$
- **Orden de Convergencia**: El Método de Newton tiene orden de convergencia 2 para raíces simples
- **Análisis de Error**: La teoría de perturbaciones permite estimar la propagación de errores en métodos iterativos

---

**Archivo de demostración**: `demostracion_error_relativo.m`

Ejecutar con: `octave demostracion_error_relativo.m`
