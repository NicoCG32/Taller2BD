# Taller 2 - Base de Datos

**Taller desarrollado por**:
- Gabriel Astudillo
- Pablo Guzmán

**Docente**: Camilo Véliz

**Ayudante**: Victoría Quiroga

Proyecto academico de Base de Datos basado en el caso de la mision Artemis III.
El taller consiste en llevar a SQL el Modelo Relacional construido en la
entrega anterior, poblar la base de datos y resolver los requerimientos pedidos
mediante consultas, procedimientos, triggers y permisos de usuarios.

El motor objetivo del proyecto es PostgreSQL.

## Estructura del proyecto

```text
Taller 2 - Base de Datos/
├── docs/
│   └── Documentación del Modelo Entidad-Relación y Modelo Relacional.
│
├── ref/
│   └── Enunciados originales correspondientes al Taller 1 y Taller 2.
│
└── sql/
    ├── 1. tablas.sql
    │   └── Script de creación de tablas, claves y restricciones.
    │
    ├── 1.5. poblacion.sql
    │   └── Script de población genérica de tablas para testeo.
    │
    ├── 2. consultas.sql
    │   └── Consultas SQL requeridas para el Taller 2.
    │
    ├── 3. procedimientos.sql
    │   └── Procedimientos almacenados implementados en la base de datos.
    │
    ├── 4. triggers.sql
    │   └── Triggers utilizados para validación y control automático.
    │
    └── 5. gestion.sql
        └── Scripts de gestión, administración y mantenimiento.
```

## Orden de ejecucion

En una base de datos PostgreSQL real, copiar y pegar los scripts en este orden:

1. `sql/1. tablas.sql`: crea las tablas, claves primarias, claves foraneas y
   restricciones basicas del modelo.
2. `sql/1.5. poblacion.sql`: Poblar las tablas con datos de prueba suficientes para cumplir el enunciado.
3. `sql/2. consultas.sql`: ejecuta las consultas solicitadas.
4. `sql/3. procedimientos.sql`: crea los procedimientos almacenados.
5. `sql/4. triggers.sql`: crea los triggers y las funciones asociadas.
6. `sql/5. gestion.sql`: crea usuarios, roles y permisos.

_- Taller Universitario, UCN Coquimbo 2026 -_