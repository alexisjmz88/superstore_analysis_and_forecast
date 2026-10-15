# 🛒 Análisis de tienda Superstore: rentabilidad y pronóstico de ingresos 2018

![Python](https://img.shields.io/badge/Python-3.10+-3776AB?logo=python&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-DuckDB-FFF000?logo=duckdb&logoColor=black)
![Pandas](https://img.shields.io/badge/Pandas-Análisis-150458?logo=pandas&logoColor=white)
![Statsmodels](https://img.shields.io/badge/Statsmodels-ETS%20%7C%20SARIMA-4B8BBE)
![Seaborn](https://img.shields.io/badge/Seaborn-Visualización-7DB0DD)
![Jupyter](https://img.shields.io/badge/Jupyter-Notebook-F37626?logo=jupyter&logoColor=white)
![Estado](https://img.shields.io/badge/Estado-Completado-success)

## 📌 Descripción del proyecto

Una gran cadena de supermercados busca determinar cómo fueron sus resultados durante el último año y qué es lo que mejor funciona en su negocio. El propósito es identificar **hacia qué productos, regiones, categorías y segmentos de clientes se debe dirigir la estrategia, y cuáles se deben evitar**.

Las primeras fases se desarrollan con **SQL (DuckDB)**, generando cuadros resumen y tablas consolidadas con KPIs. Después, el proyecto da un paso más allá con una fase de **pronóstico de ingresos mensuales para 2018**, comparando modelos estadísticos de series temporales (Seasonal Naïve, Holt-Winters y SARIMA).

---

## 🎯 Objetivos

- Validar y limpiar el dataset de ventas mediante SQL.
- Calcular los KPIs globales anuales y mensuales del periodo 2014–2017.
- Analizar la rentabilidad por segmento de clientes, región, categoría, subcategoría y producto.
- Emitir recomendaciones accionables para mejorar los márgenes.
- Pronosticar los ingresos mensuales de 2018 con el modelo de mejor desempeño fuera de muestra.

---

## 🔄 Flujo metodológico

**Validación y limpieza (SQL)** → **Resumen global 2014-2017 (SQL)** → **Análisis segmentado (SQL)** → **Recomendaciones** → **Pronóstico de ingresos**

| Fase | Descripción |
|------|-------------|
| 🗄️ **1. Validación y limpieza (SQL)** | Revisión de tipos de dato, conteo de nulos y de duplicados (con base en `row_id`). |
| 📅 **2. Resumen global (SQL)** | KPIs anuales y mensuales: órdenes, productos vendidos, ingresos, utilidad bruta y margen, con variación YoY. |
| 🔎 **3. Análisis segmentado (SQL)** | Resultados por segmento, región, categoría y subcategoría; productos con pérdidas y descuentos aplicados. |
| 💡 **4. Recomendaciones** | Acciones sobre productos de alta demanda con márgenes negativos. |
| 🔮 **5. Pronóstico de ingresos (Python)** | Preparación de la serie → análisis de tendencia, estacionalidad y autocorrelación → Seasonal Naïve → Holt-Winters (ETS) → SARIMA → backtesting sobre 2017 → pronóstico 2018. |

### Fase de pronóstico

| Etapa | Detalle |
|-------|---------|
| Serie objetivo | Ingreso mensual (`current_revenue`), 48 observaciones (2014–2017). El crecimiento YoY se descartó como objetivo por su inestabilidad (varios meses con variaciones superiores al 100%). |
| Propiedades | Tendencia al alza, estacionalidad anual marcada (autocorrelación en el rezago 12 de 0.85) y serie estacionaria según ADF y KPSS. |
| Esquema de evaluación | Entrenamiento 2014–2016 y prueba sobre 2017. |
| Modelos comparados | Seasonal Naïve, ETS aditivo, ETS multiplicativo y dos especificaciones SARIMA. |
| Modelo final | ETS aditivo, reentrenado con los 48 meses para pronosticar 2018. |

---

## 🗂️ Diccionario de datos

Dataset: `store_data.csv`, con **9,994 registros** y **20 columnas** de ventas del 01/01/2014 al 31/12/2017.

| Variable | Descripción |
|----------|-------------|
| `row_id` | Identificador único de cada fila. |
| `order_id` | Identificador único del pedido de cada cliente. |
| `order_date` | Fecha en que se realizó el pedido. |
| `ship_date` | Fecha de envío del producto. |
| `ship_mode` | Modalidad de envío seleccionada por el cliente. |
| `customer_id` | Identificador único de cada cliente. |
| `customer_name` | Nombre del cliente. |
| `segment` | Segmento al que pertenece el cliente. |
| `country` | País de residencia del cliente. |
| `city` | Ciudad de residencia del cliente. |
| `state` | Estado o provincia de residencia del cliente. |
| `postal_code` | Código postal del cliente. |
| `region` | Región a la que pertenece el cliente. |
| `product_id` | Identificador único del producto. |
| `category` | Categoría del producto. |
| `sub_category` | Subcategoría del producto. |
| `product_name` | Nombre del producto. |
| `sales` | Ventas generadas por el producto. |
| `quantity` | Cantidad de unidades del producto. |
| `discount` | Descuento aplicado al producto. |
| `profit` | Utilidad generada por el producto. |

> ✅ **Calidad de datos:** tipos de dato correctos, 0 nulos en las 20 columnas y 9,994 registros únicos (sin duplicados).

---

## 🔑 Resultados clave

### Situación
Entre 2014 y 2017 el negocio creció de forma sostenida: las órdenes pasaron de 969 a 1,687 y los ingresos de $484 K a $733 K, con una utilidad bruta de $93 K en 2017.

### Complicación
El margen bruto cayó **5.09%** en 2017 (de 13.43% a 12.74%). Las regiones Central y Sur tienen márgenes de 5.13% y 7.2%, la categoría Mobiliario apenas llega a 1.4% de margen, y los segmentos Corporate y Home Office han ido perdiendo margen desde 2015.

### Pregunta
¿Qué segmentos, regiones y productos se deben priorizar o corregir para mejorar la rentabilidad, y cuánto se espera vender en 2018?

### Respuesta

**Resumen anual**

| Año | Órdenes | Ingresos | Utilidad bruta | Margen | Ingresos YoY |
|-----|--------:|---------:|---------------:|-------:|-------------:|
| 2014 | 969 | $484,247.50 | $49,543.97 | 10.23% | — |
| 2015 | 1,038 | $470,532.51 | $61,618.60 | 13.10% | -2.83% |
| 2016 | 1,315 | $609,205.60 | $81,795.17 | 13.43% | 29.47% |
| 2017 | 1,687 | $733,215.26 | $93,439.27 | 12.74% | 20.36% |

**Hallazgos del análisis segmentado (2017)**

- **Segmento:** Consumer es el que más ingresos y utilidad genera, y el único con márgenes en alza continua (9.14% → 13.73%). Corporate (11.07%) y Home Office (13.22%) caen desde su máximo de 2015.
- **Región:** West (17.51%) y East (15.6%) lideran con un salto importante en 2017. Central (5.13%) y South (7.2%) cierran por debajo de su promedio de 4 años (7.92% y 11.93%).
- **Categoría:** Technology (18.65%) y Office Supplies (16.15%) son las más rentables. Office Supplies superó por primera vez a Furniture en ingresos en 2017, mientras que Furniture se mantiene con márgenes mínimos (1.4%).
- **Subcategorías con pérdidas:** Tables (-13.37%), Bookcases (-1.94%), Supplies (-5.95%) y Machines (-6.59%).
- **Productos con pérdidas:** 33 en Tables, 22 en Bookcases, 8 en Machines y 4 en Supplies. En Supplies, un solo producto concentra el 73.68% de los ingresos de la subcategoría y pierde cerca de 10%; en Machines, dos productos suman más del 30% de los ingresos con una pérdida de -48% cada uno.
- **Descuentos:** no explican por sí solos los márgenes negativos, por lo que el problema apunta a la estrategia de precios y costos de productos de alta demanda.

**Recomendaciones**

1. Mantener temporalmente los productos de alta demanda con márgenes negativos y someterlos a una revisión de precios y estructura de costos, ya que su descontinuación implicaría una pérdida significativa de ventas. Determinar si el problema es costo unitario elevado o precio insuficiente, y actuar con ajustes de precio, renegociación de costos o mejoras operativas.
2. Evaluar individualmente los productos que sigan con rentabilidad negativa tras estas medidas: conservarlos por su contribución estratégica, reducir su participación o descontinuarlos.

**Pronóstico de ingresos**

| Modelo | MAE | RMSE | MAPE |
|--------|----:|-----:|-----:|
| **ETS aditivo** ✅ | **11,453.63** | **12,541.40** | 22.59% |
| ETS multiplicativo | 12,431.80 | 16,384.39 | **20.77%** |
| SARIMA(1,0,1)(1,0,1)₁₂ | 15,058.70 | 17,913.13 | 34.22% |
| Seasonal Naïve | 15,467.89 | 18,985.70 | 24.52% |
| SARIMA(1,0,1)(0,0,1)₁₂ | 61,410.18 | 63,272.01 | 123.52% |

- El **ETS aditivo** obtuvo los menores errores absolutos y se seleccionó como modelo final. Los modelos SARIMA, pese a dejar residuos sin autocorrelación (Ljung-Box), no superaron a los ETS fuera de muestra.
- **Ingresos pronosticados 2018: $914,968.06**, un crecimiento de **24.79%** frente a 2017, con patrón estacional similar al de años previos: inicio de año bajo y máximos en septiembre, noviembre y diciembre.

---

## 🛠️ Tecnologías utilizadas

| Categoría | Herramientas |
|-----------|--------------|
| Lenguajes | SQL (DuckDB), Python |
| Manipulación de datos | `pandas`, `numpy` |
| Visualización | `matplotlib`, `seaborn` |
| Series temporales | `statsmodels` (ADF, KPSS, ACF/PACF, Holt-Winters, SARIMAX, Ljung-Box) |
| Métricas | `scikit-learn` (MAE, RMSE) |
| Entorno | Jupyter Notebook |

---

## 📁 Estructura del repositorio

```
📦 nombre-del-repositorio
├── 📂 data
│   ├── store_data.csv
│   ├── 2014-2017_summary.csv
│   └── 2014-2017_summary(monthly).csv
├── 📂 sql
│   └── nombre_del_script.sql
├── 📂 notebooks
│   └── superstore_analysis_and_forecast.ipynb
├── 📄 README.md
└── 📄 LICENSE
```

---

## ▶️ Cómo reproducir el análisis

1. Clona el repositorio:
   ```bash
   git clone https://github.com/tu-usuario/nombre-del-repositorio.git
   ```
2. Instala las dependencias:
   ```bash
   pip install duckdb pandas numpy matplotlib seaborn statsmodels scikit-learn
   ```
3. Ejecuta el script de `sql/` sobre `store_data.csv` para generar las tablas resumen (o utiliza directamente los CSV de `data/`).
4. Abre y ejecuta `notebooks/superstore_analysis_and_forecast.ipynb`.

---

## ⚠️ Consideraciones

- El pronóstico se basa en solo 48 observaciones mensuales, por lo que los resultados deben interpretarse con cautela.
- El modelo tiene dificultades para anticipar cambios en el segundo y tercer trimestre fuera de muestra.
- La utilidad corresponde a la **utilidad bruta** reportada en el dataset.

---

## 📄 Licencia

Este proyecto se distribuye bajo la licencia **MIT**. Consulta el archivo [LICENSE](LICENSE) para más detalles.
