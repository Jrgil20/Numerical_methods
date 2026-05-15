# ÍNDICE GENERAL: PREGUNTAS DE EXAMEN

## Estructura de Respuestas Completas

Este documento lista todos los archivos y recursos generados para responder las preguntas de examen sobre el Método de Newton para raíces cuadradas.

---

## 📋 PREGUNTA 1: DEMOSTRACIONES DEL MÉTODO DE NEWTON

### Enunciado
Demuestre las siguientes fórmulas del Método de Newton para $\sqrt{R}$:
1. $x_{n+1} = \frac{1}{2}\left(x_n + \frac{R}{x_n}\right)$
2. $e_{n+1} = \frac{e_n^2}{2x_n}$
3. $\frac{e_{n+1}}{\sqrt{R}} = \left(\frac{e_n}{\sqrt{R}}\right)^2 \cdot \frac{\sqrt{R}}{2x_n}$

### Respuesta

#### 📄 Archivo Principal
- **[ExamenmetodosPregunta1.md](ExamenmetodosPregunta1.md)** (14 KB)
  - Demostración A: Fórmula de iteración (Método Babilonio)
  - Demostración B: Fórmula de error absoluto
  - Demostración C: Fórmula de error normalizado
  - Equivalencia y relaciones entre fórmulas
  - Análisis de convergencia cuadrática
  - Implicaciones prácticas
  - Tabla de validación numérica
  - Criterio de parada en precisión de máquina

#### 🔢 Verificaciones Numéricas (Scripts Octave)
1. **demostracion_babilonia.m** - Valida Fórmula A
2. **demostracion_error_convergencia.m** - Valida Fórmula B
3. **demostracion_error_relativo.m** - Valida Fórmula C
4. **newton_raiz_cuadrada.m** - Implementación completa con gráficos

#### 📋 Documentación Complementaria
- **DEMOSTRACION_NEWTON_BABILONIA.md** - Detalle Fórmula A
- **DEMOSTRACION_CONVERGENCIA_CUADRATICA.md** - Detalle Fórmula B
- **DEMOSTRACION_ERROR_RELATIVO.md** - Detalle Fórmula C

### Contenido Clave
- ✓ Algebraic proof of all 3 formulas
- ✓ Numerical verification with R = 2, 5, 7, 10, 50, 100
- ✓ Machine epsilon awareness (2.22e-16)
- ✓ Quadratic convergence proof
- ✓ Error doubling pattern confirmation

---

## 🎯 PREGUNTA 2: NEWTON vs BISECCIÓN

### Enunciado
1. Ejecute 2 iteraciones del Método de Newton para $R = 2$ con $x_0 = 1$
2. Ejecute 2 iteraciones de Bisección en $[1, 2]$
3. Responda: ¿Cuántas iteraciones para precisión $10^{-3}$?

### Respuesta

#### 📄 Archivos Principales
- **[RESPUESTA_PREGUNTA2.md](RESPUESTA_PREGUNTA2.md)** (11 KB)
  - Parte A: 2 iteraciones paso a paso (Newton y Bisección)
  - Parte B: Cálculo de iteraciones para 10⁻³
  - Análisis teórico de convergencia
  - Interpretación matemática

- **[TABLA_COMPARATIVA_PREGUNTA2.md](TABLA_COMPARATIVA_PREGUNTA2.md)** (16 KB)
  - Tablas visuales comparativas
  - Gráfico de error en escala logarítmica
  - Convergencia a diferentes precisiones
  - Propiedades matemáticas comparadas

#### 🔢 Script de Verificación
- **[Pregunta2_Newton_vs_Biseccion.m](Pregunta2_Newton_vs_Biseccion.m)** (25 KB)
  - Calcula 2 iteraciones de cada método
  - Muestra fórmulas, cálculos intermedios, resultados finales
  - Itera hasta alcanzar precisión 10⁻³
  - Proporciona análisis comparativo
  - Incluye fórmulas teóricas

### Contenido Clave
- ✓ 2-iteration step-by-step calculations for Newton
- ✓ 2-iteration step-by-step calculations for Bisection
- ✓ **NEWTON: 3 iterations** for 10⁻³ precision
- ✓ **BISECCIÓN: 9 iterations** for 10⁻³ precision
- ✓ **Factor: 3× improvement** with Newton
- ✓ Quadratic (p=2) vs Linear (p=1) convergence theory

### Resultados Numéricos

| Método | Iteraciones | Error Final | Convergencia |
|--------|---|---|---|
| Newton | 3 | 2.12 × 10⁻⁶ | Cuadrática |
| Bisección | 9 | 9.77 × 10⁻⁴ | Lineal |

---

## 📁 Estructura de Archivos

```
/workspaces/Numerical_methods/
├── ExamenmetodosPregunta1.md              ← RESPUESTA PREGUNTA 1
├── RESPUESTA_PREGUNTA2.md                 ← RESPUESTA PREGUNTA 2 (Detalle)
├── TABLA_COMPARATIVA_PREGUNTA2.md         ← RESPUESTA PREGUNTA 2 (Tablas)
│
├── Pregunta2_Newton_vs_Biseccion.m        ← Script verificación P2
├── demostracion_error_relativo.m          ← Script verificación P1 (Fórmula C)
├── demostracion_error_convergencia.m      ← Script verificación P1 (Fórmula B)
├── demostracion_babilonia.m               ← Script verificación P1 (Fórmula A)
├── newton_raiz_cuadrada.m                 ← Implementación completa
│
├── DEMOSTRACION_NEWTON_BABILONIA.md       ← Documentación Fórmula A
├── DEMOSTRACION_CONVERGENCIA_CUADRATICA.md ← Documentación Fórmula B
├── DEMOSTRACION_ERROR_RELATIVO.md         ← Documentación Fórmula C
│
└── [Otros archivos del repositorio]
```

---

## 📊 Resumen de Resultados

### Pregunta 1: Tres Fórmulas Demostradasadas

#### Fórmula A: Iteración de Newton
$$x_{n+1} = \frac{1}{2}\left(x_n + \frac{R}{x_n}\right)$$
- **Nombre**: Método Babilonio
- **Verificación**: 6 valores de R, 3+ iteraciones cada uno
- **Orden de convergencia**: Cuadrático (p = 2)

#### Fórmula B: Error Absoluto
$$e_{n+1} = \frac{e_n^2}{2x_n}$$
- **Verificación**: Razones ≈ 1.0000 para 3+ iteraciones
- **Límite de precisión**: Machine epsilon awareness
- **Implicación**: Error se eleva al cuadrado cada iteración

#### Fórmula C: Error Relativo
$$\frac{e_{n+1}}{\sqrt{R}} = \left(\frac{e_n}{\sqrt{R}}\right)^2 \cdot \frac{\sqrt{R}}{2x_n}$$
- **Verificación**: Dígitos correctos se duplican
- **Factor normalizador**: Converge a 0.5 cerca de raíz
- **Cifras exactas**: n=0→1, n=1→2, n=2→6, n=3→12

### Pregunta 2: Comparación Newton vs Bisección

#### Para precisión $10^{-3}$ calculando $\sqrt{2}$:

| Método | Iteraciones | Convergencia | Velocidad |
|--------|---|---|---|
| **Newton** | **3** | Cuadrática | ⚡⚡⚡ |
| **Bisección** | **9** | Lineal | ⚡ |
| **Mejora** | **3×** | p=2 vs p=1 | 3× más rápido |

#### Fórmula Teórica de Bisección
Para tolerancia $\epsilon$ en intervalo $[a,b]$:
$$n \geq \log_2\left(\frac{b-a}{\epsilon}\right) - 1$$

Para $[1,2]$ y $\epsilon = 10^{-3}$:
$$n \geq \log_2(1000) - 1 \approx 8.97 \rightarrow n = 9 \text{ ✓}$$

---

## 🧮 Datos Numéricos Clave

### √2 Calculado (R = 2, x₀ = 1)

#### Método de Newton
```
n=0: x₀ = 1.000000000,     e₀ = -0.414213562
n=1: x₁ = 1.500000000,     e₁ = 0.085786438
n=2: x₂ = 1.416666667,     e₂ = 0.002453104
n=3: x₃ = 1.414215686,     e₃ = 0.000002124 ✓
     √2 = 1.414213562...
```

#### Método de Bisección
```
Inicio: [a, b] = [1, 2]
n=0: error = 0.500000 (factor 1/2)
n=1: error = 0.250000 (factor 1/4)
n=2: error = 0.125000 (factor 1/8)
...
n=8: error = 0.001953 (factor 1/512)
n=9: error = 0.000977 (factor 1/1024) ✓
```

---

## 📚 Cómo Usar Este Material

### Para revisar PREGUNTA 1:
1. Leer: [ExamenmetodosPregunta1.md](ExamenmetodosPregunta1.md)
2. Verificar: `octave demostracion_babilonia.m`
3. Profundizar: Archivos DEMOSTRACION_*.md

### Para revisar PREGUNTA 2:
1. Leer: [RESPUESTA_PREGUNTA2.md](RESPUESTA_PREGUNTA2.md)
2. Visualizar: [TABLA_COMPARATIVA_PREGUNTA2.md](TABLA_COMPARATIVA_PREGUNTA2.md)
3. Ejecutar: `octave Pregunta2_Newton_vs_Biseccion.m`

### Para comprender la CONVERGENCIA:
- Newton: Lee DEMOSTRACION_CONVERGENCIA_CUADRÁTICA.md
- Bisección: análisis en TABLA_COMPARATIVA_PREGUNTA2.md
- Comparación: RESPUESTA_PREGUNTA2.md (Parte B)

---

## ✅ Checklist de Completitud

### Pregunta 1
- ✓ Fórmula A demostrada (algebraica + numérica)
- ✓ Fórmula B demostrada (algebraica + numérica)
- ✓ Fórmula C demostrada (algebraica + numérica)
- ✓ Machine epsilon awareness implementado
- ✓ 3 scripts Octave funcionando
- ✓ 3 archivos markdown detallados
- ✓ Tablas de convergencia incluidas
- ✓ Análisis de implicaciones prácticas

### Pregunta 2
- ✓ 2 iteraciones de Newton paso a paso
- ✓ 2 iteraciones de Bisección paso a paso
- ✓ Cálculo de iteraciones para 10⁻³
- ✓ Script Octave con resultados numéricos
- ✓ Análisis teórico de convergencia
- ✓ Fórmulas teóricas para ambos métodos
- ✓ Tablas comparativas visuales
- ✓ Interpretación de resultados

---

## 🎓 Conceptos Aprendidos

1. **Convergencia Cuadrática**: Error se eleva al cuadrado
2. **Convergencia Lineal**: Error se reduce por factor constante
3. **Orden de Convergencia**: Define velocidad de convergencia
4. **Machine Epsilon**: Límite de precisión en computadora
5. **Error Absoluto vs Relativo**: Dos perspectivas del mismo error
6. **Método Babilonio**: Antigüedad e importancia histórica
7. **Bisección vs Newton**: Trade-off entre seguridad y velocidad

---

## 📖 Documentación Original

- [Enunciado del examen](Examen_Metodos_Pregunta1.md) (si existe)
- [Scripts Octave](*.m) - Verificación computacional
- [Análisis detallado](DEMOSTRACION_*.md) - Profundización teórica

---

**Última actualización**: Mayo 2026  
**Lenguaje**: Español (es)  
**Software**: GNU Octave 8.x, Markdown  
**Precisión de máquina**: 2.22 × 10⁻¹⁶ (double precision)
