# Interpolación — Estimación polinomial

Métodos para construir un polinomio que pase por puntos dados.

## 📋 Scripts

| Archivo | Método | Descripción |
|---------|--------|-----------|
| `lagrange_interpolacion.m` | Lagrange | Bases de Lagrange, construcción directa |

## 💡 Métodos de interpolación

### Lagrange
Construye polinomio mediante las **bases de Lagrange**:

```
P(x) = Σ yᵢ · Lᵢ(x)

donde Lᵢ(x) = Π_{j≠i} (x - xⱼ)/(xᵢ - xⱼ)
```

**Pros:**
- Simétrico, fácil de entender
- No requiere resolver sistema

**Contras:**
- Recalcula todo si agregan puntos
- Código más largo

### Newton (en Parcial2-Adonais)
Usa **diferencias divididas**:

```
P(x) = f[x₀] + f[x₀,x₁](x-x₀) + ...
```

**Pros:**
- Eficiente: agregar puntos es O(n)
- Código corto

**Contras:**
- Menos intuitivo

## 🚀 Uso

```octave
octave lagrange_interpolacion.m
```

## 📚 Relación con Parcial 2

- **Newton (interpolación):** [04-Parcial2-Adonais/t1_interpolacion_newton.m](../../../04-Parcial2-Adonais/t1_interpolacion_newton.m)
- **Lagrange (interpolación):** [04-Parcial2-Adonais/t1_interpolacion_lagrange.m](../../../04-Parcial2-Adonais/t1_interpolacion_lagrange.m)
- **Spline (trazadores):** [04-Parcial2-Adonais/t2_spline_cubico.m](../../../04-Parcial2-Adonais/t2_spline_cubico.m)

---

**Siguiente:** [05-EDO/](../05-EDO/)
