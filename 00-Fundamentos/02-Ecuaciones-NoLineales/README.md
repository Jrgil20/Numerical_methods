# Ecuaciones No Lineales — Búsqueda de Raíces

Métodos para hallar raíces de f(x) = 0 (donde f es una función no lineal).

## 📋 Scripts

| Archivo | Método | Derivada | Convergencia | Descripción |
|---------|--------|----------|--------------|-----------|
| `biseccion-2.m` | Bisección | No | Lineal | Siempre converge si hay cambio de signo |
| `newton-2.m` | Newton-Raphson | Sí | Cuadrática | Muy rápido, puede fallar |
| `newton_raiz.m` | Newton especializado | Sí | Cuadrática | Caso: hallar √R |
| `secante-2.m` | Secante | No | Superlineal | Como Newton pero sin derivada |

## 🎯 Comparación rápida

| Método | Requiere | Pros | Contras | Mejor para |
|--------|----------|------|---------|-----------|
| **Bisección** | Intervalo [a,b] | Robusto, siempre converge | Lento | Verificar existencia, principiantes |
| **Newton** | x₀, f(x), f'(x) | Muy rápido | Puede divergir, f' costosa | Raíces simples cercanas |
| **Secante** | x₀, x₁, f(x) | No necesita derivada | Lentitud media | Newton sin derivada |

## 📊 Orden de convergencia

```
Bisección:   O(h) — lineal, 1 dígito por ~3 iteraciones
Secante:     O(h^1.618) — superlineal
Newton:      O(h²) — cuadrática, dígitos se duplican cada iteración
```

## 🚀 Inicio rápido

### Bisección (sin derivada, seguro)

```octave
octave biseccion-2.m
```

### Newton (rápido, requiere derivada)

```octave
octave newton-2.m
```

### Secante (sin derivada, rápido)

```octave
octave secante-2.m
```

## 💡 ¿Cuál elegir?

1. **Si no tienes derivada → Bisección o Secante**
2. **Si tienes derivada exacta → Newton (más rápido)**
3. **Si Newton falla → Intenta Bisección primero, luego Secante**

## 🔗 Relación con otros temas

- Estos métodos se usan dentro de **Parcial1** para resolver ecuaciones específicas.
- Para sistemas de ecuaciones lineales, ve a [01-Sistemas-Lineales/](../01-Sistemas-Lineales/)

---

**Siguiente:** [03-Interpolacion/](../03-Interpolacion/)
