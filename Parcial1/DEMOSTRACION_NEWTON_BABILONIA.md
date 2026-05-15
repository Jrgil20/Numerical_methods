# Demostración: Método de Newton para la Raíz Cuadrada

## Problema Planteado

Suponga que el método de Newton es aplicado para hallar la raíz cuadrada de un número $R > 0$. Suponiendo $x_0 \neq 0$, muestre que:

$$x_{n+1} = \frac{1}{2}\left(x_n + \frac{R}{x_n}\right)$$

---

## Demostración Algebraica

### Paso 1: Plantear la ecuación

Para encontrar $\sqrt{R}$ donde $R > 0$, debemos resolver la ecuación:
$$f(x) = x^2 - R = 0$$

### Paso 2: Calcular la derivada

$$f'(x) = 2x$$

### Paso 3: Aplicar la fórmula de Newton-Raphson

La fórmula general del método de Newton es:
$$x_{n+1} = x_n - \frac{f(x_n)}{f'(x_n)}$$

Sustituyendo nuestras funciones:
$$x_{n+1} = x_n - \frac{x_n^2 - R}{2x_n}$$

### Paso 4: Simplificar algebraicamente

Separamos las fracciones:
$$x_{n+1} = x_n - \frac{x_n^2}{2x_n} + \frac{R}{2x_n}$$

Simplificamos $\frac{x_n^2}{2x_n} = \frac{x_n}{2}$:
$$x_{n+1} = x_n - \frac{x_n}{2} + \frac{R}{2x_n}$$

Combinamos los términos con $x_n$:
$$x_{n+1} = \frac{x_n}{2} + \frac{R}{2x_n}$$

Factorizamos $\frac{1}{2}$:
$$\boxed{x_{n+1} = \frac{1}{2}\left(x_n + \frac{R}{x_n}\right)}$$

---

## Verificación Numérica

### Ejemplo 1: Hallar $\sqrt{25}$

Usando la fórmula iterativa con $x_0 = 5.5$:

| Iteración | $x_n$ | $f(x_n) = x_n^2 - 25$ | $f'(x_n) = 2x_n$ | $x_{n+1}$ | Error |
|---|---|---|---|---|---|
| 0 | 5.5000000000 | 5.2500000000 | 11.0000000000 | 5.0227272727 | 4.77e-01 |
| 1 | 5.0227272727 | 0.2277892562 | 10.0454545455 | 5.0000514192 | 2.27e-02 |
| 2 | 5.0000514192 | 0.0005141943 | 10.0001028383 | 5.0000000003 | 5.14e-05 |
| 3 | 5.0000000003 | 0.0000000026 | 10.0000000005 | 5.0000000000 | 2.64e-10 |

**Resultado:** $\sqrt{25} \approx 5.000000000000000$ (4 iteraciones)

### Ejemplo 2: Hallar $\sqrt{2}$

| Iteración | Fórmula Newton | Fórmula Babilonia | Diferencia |
|---|---|---|---|
| 0 | 1.500000000000 | 1.500000000000 | 0.000e+00 |
| 1 | 1.416666666667 | 1.416666666667 | 2.220e-16 |
| 2 | 1.414215686275 | 1.414215686275 | 2.220e-16 |
| 3 | 1.414213562375 | 1.414213562375 | 0.000e+00 |
| 4 | 1.414213562373 | 1.414213562373 | 2.220e-16 |

**Resultado:** $\sqrt{2} \approx 1.414213562373095$ (5 iteraciones)

---

## Resumen de Resultados

La siguiente tabla verifica la equivalencia de ambas fórmulas para varios valores de $R$:

| $R$ | Punto inicial | Iteraciones | Resultado | Error |
|---|---|---|---|---|
| 2 | 1.00 | 5 | 1.414213562373095 | 0.000e+00 |
| 5 | 2.50 | 4 | 2.236067977499790 | 0.000e+00 |
| 7 | 3.50 | 4 | 2.645751311064693 | 1.026e-13 |
| 10 | 5.00 | 5 | 3.162277660168380 | 0.000e+00 |
| 50 | 25.00 | 6 | 7.071067811865476 | 8.882e-16 |
| 100 | 50.00 | 7 | 10.000000000000000 | 0.000e+00 |

---

## Propiedades Importantes

### 1. **Convergencia Cuadrática**

El Método de Newton para raíces cuadradas presenta **convergencia cuadrática**, lo que significa que el número de dígitos significativos correctos se duplica aproximadamente en cada iteración.

Ejemplo con $\sqrt{2}$:

| Iteración | $x_n$ | Cifras correctas |
|---|---|---|
| 0 | 1.50000000000000 | 1 |
| 1 | 1.41666666666667 | 3 |
| 2 | 1.41421568627451 | 6 |
| 3 | 1.41421356237469 | 12 |
| 4 | 1.41421356237309 | 16 |
| 5 | 1.41421356237309 | 16 |

### 2. **Equivalencia Completa**

Tanto la fórmula de Newton como la fórmula de Babilonia producen **exactamente los mismos iterados numéricos**. Las diferencias observadas son únicamente errores de redondeo del computador.

### 3. **Método de Babilonia**

La fórmula $x_{n+1} = \frac{1}{2}\left(x_n + \frac{R}{x_n}\right)$ es conocida como el **Método de Babilonia** o **Método Babilónico**, y es uno de los algoritmos más antiguos y eficientes para calcular raíces cuadradas. Se presume que fue utilizado por los antiguos babilonios hace más de 3000 años.

---

## Conclusión

✅ **Hemos demostrado algebraicamente y verificado numéricamente que:**

> El método de Newton aplicado al problema de encontrar $\sqrt{R}$ produce la fórmula iterativa:
> $$x_{n+1} = \frac{1}{2}\left(x_n + \frac{R}{x_n}\right)$$

Esta fórmula:
- Converge cuadráticamente
- Es numéricamente estable para $x_0 \neq 0$
- Es equivalente a la fórmula clásica de Newton-Raphson
- Ha sido utilizada desde la antigüedad para calcular raíces cuadradas

---

## Archivos de Implementación

- **`newton_raiz_cuadrada.m`**: Implementación completa del método de Newton para raíz cuadrada con visualización gráfica
- **`demostracion_babilonia.m`**: Script que demuestra algebraicamente y verifica numéricamente la equivalencia entre Newton y Babilonia

**Instrucciones para ejecutar:**
```bash
octave --quiet newton_raiz_cuadrada.m
octave --quiet demostracion_babilonia.m
```
