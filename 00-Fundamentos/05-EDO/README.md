# EDO — Ecuaciones Diferenciales Ordinarias

Métodos para resolver problemas de valor inicial (PVI):

```
y' = f(t, y),   y(t₀) = y₀
```

## 📋 Scripts

| Archivo | Método | Orden | Descripción |
|---------|--------|-------|-----------|
| `edo_ejemplos.m` | Ejemplo general | — | Casos de prueba |
| `Runge-Kutta.m` | RK4 | 4º | Método de Runge-Kutta de 4º orden |

## 📊 Métodos implementados (en Parcial2-Adonais)

| Método | Fórmula | Error | Velocidad |
|--------|---------|-------|-----------|
| **Euler** | y_{n+1} = y_n + h·f(t_n,y_n) | O(h) | Lenta |
| **Heun** | Predictor-corrector | O(h²) | Media |
| **RK4** | 4 pendientes (k1..k4) | O(h⁴) | **Excelente** |

## 🚀 Uso

```octave
% Scripts de esta carpeta
octave Runge-Kutta.m
octave edo_ejemplos.m

% Para estudio integral (paso a paso)
cd ../../04-Parcial2-Adonais
octave t6_euler
octave t6_euler_mejorado_rk4
```

## 💡 Cuándo usar cada método

1. **Euler** → Cálculo rápido, baja precisión
2. **Heun** → Equilibrio precisión/velocidad
3. **RK4** → Máxima precisión (recomendado)

## 📚 Relación con Parcial 2

- [t6_euler.m](../../../04-Parcial2-Adonais/t6_euler.m) — Método de Euler
- [t6_euler_mejorado_rk4.m](../../../04-Parcial2-Adonais/t6_euler_mejorado_rk4.m) — Heun + RK4

---

**Nota:** Esta carpeta tiene ejemplos. Para aprender paso a paso, ve a `04-Parcial2-Adonais/`.
