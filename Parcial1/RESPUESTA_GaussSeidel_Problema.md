# MÉTODO DE GAUSS-SEIDEL - SOLUCIÓN COMPLETA

## Problema

Se desea aproximar la solución del siguiente Sistema de Ecuaciones Lineales utilizando el método de Gauss-Seidel:

$$\begin{cases}
x_1 + 10x_2 + x_3 = 4 \\
5x_1 + 2x_2 + x_3 = 2 \\
x_1 + x_2 + 10x_3 = -1
\end{cases}$$

### Tareas

a. Determine si la matriz asociada al sistema es estrictamente diagonal dominante.

b. Reescriba el sistema para lograr convergencia al aplicar el método de Gauss-Seidel.

c. Realice tres iteraciones del método de Gauss-Seidel con $x^{(0)} = \begin{pmatrix} 0 \\ 0 \\ 0 \end{pmatrix}$ y muestre los resultados de cada iteración.

---

## RESPUESTA

### a) ¿ES LA MATRIZ ESTRICTAMENTE DIAGONAL DOMINANTE?

#### Definición

Una matriz $A$ es **estrictamente diagonal dominante** si para cada fila $i$:

$$|a_{ii}| > \sum_{j \neq i} |a_{ij}|$$

#### Matriz Original

$$A = \begin{pmatrix} 1 & 10 & 1 \\ 5 & 2 & 1 \\ 1 & 1 & 10 \end{pmatrix}, \quad b = \begin{pmatrix} 4 \\ 2 \\ -1 \end{pmatrix}$$

#### Análisis Fila por Fila

**Fila 1:**
- Elemento diagonal: $|a_{11}| = |1| = 1$
- Suma otros elementos: $|a_{12}| + |a_{13}| = |10| + |1| = 11$
- ¿$1 > 11$? **NO** ✗

**Fila 2:**
- Elemento diagonal: $|a_{22}| = |2| = 2$
- Suma otros elementos: $|a_{21}| + |a_{23}| = |5| + |1| = 6$
- ¿$2 > 6$? **NO** ✗

**Fila 3:**
- Elemento diagonal: $|a_{33}| = |10| = 10$
- Suma otros elementos: $|a_{31}| + |a_{32}| = |1| + |1| = 2$
- ¿$10 > 2$? **SÍ** ✓

#### Conclusión

**✗ LA MATRIZ ORIGINAL NO ES ESTRICTAMENTE DIAGONAL DOMINANTE**

No se puede garantizar convergencia del método de Gauss-Seidel en el orden original.

---

### b) REESCRIBIR EL SISTEMA PARA LOGRAR CONVERGENCIA

#### Estrategia: Reordenamiento de Filas

Para lograr diagonal dominancia, reordenamos las ecuaciones. Intentamos el orden: **Fila 2, Fila 1, Fila 3**

#### Sistema Reordenado

$$\begin{cases}
5x_1 + 2x_2 + x_3 = 2 \\
x_1 + 10x_2 + x_3 = 4 \\
x_1 + x_2 + 10x_3 = -1
\end{cases}$$

#### Nueva Matriz

$$A' = \begin{pmatrix} 5 & 2 & 1 \\ 1 & 10 & 1 \\ 1 & 1 & 10 \end{pmatrix}, \quad b' = \begin{pmatrix} 2 \\ 4 \\ -1 \end{pmatrix}$$

#### Verificación de Diagonal Dominancia

**Fila 1:**
- $|a'_{11}| = |5| = 5$ vs $|a'_{12}| + |a'_{13}| = |2| + |1| = 3$
- ¿$5 > 3$? **SÍ** ✓

**Fila 2:**
- $|a'_{22}| = |10| = 10$ vs $|a'_{21}| + |a'_{23}| = |1| + |1| = 2$
- ¿$10 > 2$? **SÍ** ✓

**Fila 3:**
- $|a'_{33}| = |10| = 10$ vs $|a'_{31}| + |a'_{32}| = |1| + |1| = 2$
- ¿$10 > 2$? **SÍ** ✓

#### Conclusión

**✓ EL SISTEMA REORDENADO ES ESTRICTAMENTE DIAGONAL DOMINANTE**

✓ El método de Gauss-Seidel CONVERGE garantizado en este nuevo orden.

---

### c) TRES ITERACIONES DEL MÉTODO DE GAUSS-SEIDEL

#### Fórmula de Gauss-Seidel

$$x_i^{(k)} = \frac{b_i - \sum_{j=1}^{i-1} a_{ij}x_j^{(k)} - \sum_{j=i+1}^{n} a_{ij}x_j^{(k-1)}}{a_{ii}}$$

**Interpretación:**
- Usa valores **actualizados** $x_j^{(k)}$ para $j < i$ (ya calculados en esta iteración)
- Usa valores **anteriores** $x_j^{(k-1)}$ para $j > i$ (de la iteración anterior)

#### Condiciones Iniciales

$$x^{(0)} = \begin{pmatrix} 0 \\ 0 \\ 0 \end{pmatrix}$$

---

#### **ITERACIÓN 1** ($k = 1$)

**Cálculo de $x_1^{(1)}$:**

$$x_1^{(1)} = \frac{b_1 - (a_{12}x_2^{(0)} + a_{13}x_3^{(0)})}{a_{11}}$$

$$= \frac{2 - (2 \cdot 0 + 1 \cdot 0)}{5} = \frac{2}{5} = 0.400000$$

**Cálculo de $x_2^{(1)}$:**

$$x_2^{(1)} = \frac{b_2 - (a_{21}x_1^{(1)} + a_{23}x_3^{(0)})}{a_{22}}$$

$$= \frac{4 - (1 \cdot 0.4 + 1 \cdot 0)}{10} = \frac{3.6}{10} = 0.360000$$

**Cálculo de $x_3^{(1)}$:**

$$x_3^{(1)} = \frac{b_3 - (a_{31}x_1^{(1)} + a_{32}x_2^{(1)})}{a_{33}}$$

$$= \frac{-1 - (1 \cdot 0.4 + 1 \cdot 0.36)}{10} = \frac{-1.76}{10} = -0.176000$$

**Resultado:**
$$x^{(1)} = \begin{pmatrix} 0.400000 \\ 0.360000 \\ -0.176000 \end{pmatrix}$$

---

#### **ITERACIÓN 2** ($k = 2$)

**Cálculo de $x_1^{(2)}$:**

$$x_1^{(2)} = \frac{2 - (2 \cdot 0.36 + 1 \cdot (-0.176))}{5} = \frac{2 - 0.544}{5} = \frac{1.456}{5} = 0.291200$$

**Cálculo de $x_2^{(2)}$:**

$$x_2^{(2)} = \frac{4 - (1 \cdot 0.2912 + 1 \cdot (-0.176))}{10} = \frac{4 - 0.1152}{10} = \frac{3.8848}{10} = 0.388480$$

**Cálculo de $x_3^{(2)}$:**

$$x_3^{(2)} = \frac{-1 - (1 \cdot 0.2912 + 1 \cdot 0.38848)}{10} = \frac{-1.67968}{10} = -0.167968$$

**Resultado:**
$$x^{(2)} = \begin{pmatrix} 0.291200 \\ 0.388480 \\ -0.167968 \end{pmatrix}$$

---

#### **ITERACIÓN 3** ($k = 3$)

**Cálculo de $x_1^{(3)}$:**

$$x_1^{(3)} = \frac{2 - (2 \cdot 0.388480 + 1 \cdot (-0.167968))}{5} = \frac{1.391008}{5} = 0.278202$$

**Cálculo de $x_2^{(3)}$:**

$$x_2^{(3)} = \frac{4 - (1 \cdot 0.278202 + 1 \cdot (-0.167968))}{10} = \frac{3.889766}{10} = 0.388977$$

**Cálculo de $x_3^{(3)}$:**

$$x_3^{(3)} = \frac{-1 - (1 \cdot 0.278202 + 1 \cdot 0.388977)}{10} = \frac{-1.667178}{10} = -0.166718$$

**Resultado:**
$$x^{(3)} = \begin{pmatrix} 0.278202 \\ 0.388977 \\ -0.166718 \end{pmatrix}$$

---

#### Tabla Resumen de las 3 Iteraciones

| $k$ | $x_1^{(k)}$ | $x_2^{(k)}$ | $x_3^{(k)}$ |
|---|---|---|---|
| 0 | 0.000000 | 0.000000 | 0.000000 |
| 1 | 0.400000 | 0.360000 | -0.176000 |
| 2 | 0.291200 | 0.388480 | -0.167968 |
| 3 | 0.278202 | 0.388977 | -0.166718 |

---

## ANÁLISIS DE CONVERGENCIA

### Radio Espectral

Para garantizar convergencia, se calcula la matriz de iteración $M = (D - L)^{-1}U$:

$$M = \begin{pmatrix} 0 & -0.4000 & -0.2000 \\ 0 & 0.0400 & -0.0800 \\ 0 & 0.0360 & 0.0280 \end{pmatrix}$$

**Autovalores de $M$:**
- $\lambda_1 = 0$
- $\lambda_2 = 0.034$
- $\lambda_3 = 0.034$

**Radio espectral:** $\rho(M) = \max|\lambda_i| = 0.063246$

### Conclusión de Convergencia

$$\rho(M) = 0.063246 < 1 \quad \Rightarrow \quad \text{✓ Método CONVERGE garantizado}$$

La convergencia es rápida porque el radio espectral es muy pequeño (cercano a 0).

---

## CONCLUSIÓN FINAL

| Pregunta | Respuesta |
|----------|-----------|
| **a) ¿Diagonal dominante?** | ✗ **NO** en el orden original |
| **b) Sistema reordenado** | ✓ **SÍ**: Reordenar como Fila 2, Fila 1, Fila 3 |
| **c) Resultados 3 iteraciones** | Ver tabla anterior; $\rho(M) = 0.0632 < 1$ → CONVERGE |

El método de Gauss-Seidel **converge rápidamente** al sistema reordenado con condición inicial:

$$x^{(0)} = \begin{pmatrix} 0 \\ 0 \\ 0 \end{pmatrix}$$

---

## Archivo de Verificación

**Script Octave**: `GaussSeidel_Problema_Completo.m`

Ejecutar con:
```bash
octave GaussSeidel_Problema_Completo.m
```

Genera toda la verificación automática y muestra los cálculos detallados de cada iteración.
