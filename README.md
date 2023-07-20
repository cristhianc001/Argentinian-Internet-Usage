# Analisis del estado y evolución del internet fijo de Argentina

![Portada](https://raw.githubusercontent.com/cristhianc001/argentinian-telecommunications-analysis/main/img/portada.png)  

Cualquier consulta u observación es bienvenida en mi perfil de Github o en [LinkedIn](https://www.linkedin.com/in/cristhiancastro/)

# Tabla de Contenido

- [1. Introducción](#1-introduccion)
- [2. Estructura](#2-estructura)
- [3. Procedimiento](#3-procedimiento)
  - [A. Extracción de Datos](#a-extracción-de-datos)
  - [B. Transformación y Limpieza](#b-transformación-y-limpieza)
  - [C. Analisis Exploratorio de Datos](#c-analisis-exploratorio-de-datos)
  - [D. Motor de Base de Datos](#d-motor-de-base-de-datos)
  - [E. Construcción de dashboards](#e-construcción-de-dashboards)
- [4. Documentación](#4-documentación)
- [5. Herramientas Usadas](#5-herramientas-usadas)
- [6. Contacto](#6-contacto)


## 1. Introducción
El presente repositorio contiene el analisis de datos del internet fijo de Argentina entre 2014 y 2022, teniendo en cuenta variables como accesos, valocidad de baja y cobertura a nivel nacional y regional. El proyecto va desde la extracción de datos consultando una API gubernamental, pasando por una limpieza y analisis exploratorio de los datos, hasta la elaboración de una base de datos y de dashboards para comunicar los hallazgos encontrados.

## 2. Estructura

- [`raw_data`](/raw_data.zip): Los datos sin procesar usados en este proyecto se tomaron directamente de la API gubernamental, pero si hay problemas de red en el servidor, hay una copia de seguridad en el archivo `raw_data.zip` en la raíz de este repositorio.
- [`processed_data/`](processed_data/): contiene los datos transformados y limpios en formato CSV.
- [`notebooks/`](notebooks/): Incluye notebooks de Python para limpieza de datos, EDA y visualización. También hay un script de python que importa los datos de la API directamente.
- [`sql/`](sql/): Scripts de SQL de limpiezas menores, creación de dimensiones y relación de tablas.
- [`img/`](img/): Incluye imágenes utilizadas en el readme.
- [`visualizations/`](visualizations/): Incluye graficos de Python, dashboards y archivos de Power BI para visualización de datos.

## 3. Procedimiento

### [A. Extracción de Datos](notebooks/1.%20Data_Extraction.ipynb)
Los datos usados en este analisis fueron extraidos del [Ente Nacional de Comunicaciones](https://datosabiertos.enacom.gob.ar/dashboards/20000/acceso-a-internet/) correspondientes al area de Acceso a Internet. Para esto, se consultó la documentación de la API para hallar la dirección de los [datasets](https://api.datosabiertos.enacom.gob.ar/api/v2/datasets/?auth_key=AUTH_KEY) que se accede despues de solicitar una [llave de autenticación](https://datosabiertos.enacom.gob.ar/developers/). La información disponible en el servidor esta en tres presentanciones: datasets, los cuales son archivos de excel donde pueden existar mas de una tabla por archivo; datastreams, que son archivos csv que contienen una tabla por archivo. Estos datastream son desgloses de los dataset. Por ultimo, visualizaciones, como su nombre lo indica, son representaciones visuales de los datastream.

![Dataset, datastreams y visualizaciones](https://raw.githubusercontent.com/cristhianc001/argentinian-telecommunications-analysis/main/img/ejemplo-dataset-api.png)
*El link del dataset esta subrayado en azul, los datastream en rojo y las visualizaciones en amarillo*

Como los datastreams ya estaban en .csv, se usaron estos como objetivo de extracción en lugar de los datasets que estan formato .xlsx
![API de datastream](https://raw.githubusercontent.com/cristhianc001/argentinian-telecommunications-analysis/main/img/ejemplo-datastream-api.png)
*Dirección de API usada para extraer datos de datastreams*

El glosario de terminos que aparecen en las tablas se puede consultar en este [enlace](https://www.estadisticaciudad.gob.ar/eyc/publicaciones/anuario_2005/Cd_Cap13/dyc13.htm#:~:text=Dial%2DUp%3A%20son%20conexiones%20que,servicio%20de%20acceso%20a%20Internet).

### [B. Transformación y Limpieza](notebooks/2.%20Data_Wrangling.ipynb)
La mayoria de los archivos extraidos de la API tenian una buena integridad, por lo tanto se realizaron pocas operaciones sobre los dataframes. Las mayores transformaciones involucraron union (merge) de tablas para resumir el numero de archivos y 'despivotear' (melt) columnas en filas. Tambien se borraron las comas (entre otros caracteres especiales) de las todas las cifras donde estaban presentes para que no hayan problemas de interpretación de miles, millares y punto decimales. 

### [C. Analisis Exploratorio de Datos](notebooks/3.%20Exploratory_Data_Analysis.ipynb)
Una vez comprobada la integridad de los datos y definidos los archivos, se realizó un analisis exploratorio de datos para investigar graficamente el comportamiento de la variables del dataset. Se encontraron hallazgos como el progreso continuo de accesos en las provincias, excepto en la Ciudad Federal, que registra un ligero estancamiento:

![Grafico de EDA](https://raw.githubusercontent.com/cristhianc001/argentinian-telecommunications-analysis/main/visualizations/barplot-central-accesos.png)
*Accesos por año en las provincas de la region central*

Este ligero estancamiento se explica por la gran cobertura de la ciudad en terminos de internet fijo, puede decirse que ha llegado a un techo.

![Grafico de EDA](https://raw.githubusercontent.com/cristhianc001/argentinian-telecommunications-analysis/main/visualizations/lineas-central-accesos-100.png)
*Accesos por cada 100 hogares en las provincas de la region central*

Este comportamiento tambien se observa al comparar las proporciones de los accesos. La proporcion de accesos de la Capital Federal disminuye con el tiempo, pero no es porque los accesos disminuyan, es porque los accesos se mantienen casi constantes mientras crecen en el resto del pais.

![Grafico de EDA](https://raw.githubusercontent.com/cristhianc001/argentinian-telecommunications-analysis/main/visualizations/pie-accesos-provincia.png)

Otro comportamiento resaltable es de la provincia de San Luis. Los accesos de esta provincia se dispararon en el 2017, la razon de esto puede deberse a programas de inversion publicos o privado o a un cambio en la metodologia de medición.

![Grafico de EDA](https://raw.githubusercontent.com/cristhianc001/argentinian-telecommunications-analysis/main/visualizations/barplot-cuyo-accesos.png)

La velocidad de bajada promedio tambien tiene una tendencia particular en San Luis, es la unica provincia donde baja en los ultimos periodos medidos.

![Grafico de EDA](https://raw.githubusercontent.com/cristhianc001/argentinian-telecommunications-analysis/main/visualizations/lineas-velocidad-media-cuyo.png)

En el contexto nacional, se presenta una bajada significativa en el rango de velocidad de 1 - 6 Mbps y una subida de +30 Mbps, esto potenciado por la presencia mayor de la fibra optica en el pais.

![Grafico de EDA](https://raw.githubusercontent.com/cristhianc001/argentinian-telecommunications-analysis/main/visualizations/barras-apiladas-velocidad.png)

En terminos de accesos totales, el comportamiento teniendo en cuenta los trimestres es el esperado: conforme transucurren los trimestres, cada vez aumentan mas los accesos pues el ultimo trimestre recoge los resultados de los anteriores. Hay excepciones que se perciben en el segundo grafico de lineas, donde se notan disminuciones de accesos en algunos trimestres, la mas notoria en el ultimo trimestre del 2019.

![Grafico de EDA](https://raw.githubusercontent.com/cristhianc001/argentinian-telecommunications-analysis/main/visualizations/linea-accesos-nacional.png)


![Grafico de EDA](https://raw.githubusercontent.com/cristhianc001/argentinian-telecommunications-analysis/main/visualizations/mapa-accesos-2022.png)
*Mapa de Accesos con Matplotlib*

![Grafico de EDA](https://raw.githubusercontent.com/cristhianc001/argentinian-telecommunications-analysis/main/visualizations/mapa-plotly.png)
*Mapa de Accesos por cada 100 hogares con Plotly*

El analisis mas completo para las variables de velocidad, accesos y cobertura en todas las provincias puede encontrarse en el notebook dedidaco al EDA.

### [D. Motor de Base de Datos](sql/)
Los archivos .csv fueron importados a una base de datos para que sean usados por Power BI mas adelante. El motor usado fue MySQL 8.0.28 al cual se le introdujeron las tablas por medio del wizard de Workbench.

![Dashboard Power BI](https://raw.githubusercontent.com/cristhianc001/argentinian-telecommunications-analysis/main/img/wizard-mysql.png)
*Wizard de MySQL Workbench*

La codificación UTF-8 de MySQL no pudo reconocer tildes, por lo tanto, ademas de la creación de una tabla dimensional de provincias, se le realizó una pequeña limpieza antes de usar esos datos en Power BI.


### [E. Construcción de dashboards](visualizations/)
Una vez lista la base de datos, se utilizó Power BI y su conexión con MySQL para realizar la toma de tablas de dicha base y la elaboración de dashboards que faciliten la lectura y analisis de los datos.

![Conexión Power BI](https://raw.githubusercontent.com/cristhianc001/argentinian-telecommunications-analysis/main/img/powerbi-mysql.png)
*Conexión a una base de datos local desde Power BI*

![Conexión Power BI](https://raw.githubusercontent.com/cristhianc001/argentinian-telecommunications-analysis/main/img/powerbi-mysql2.png)
*Usuario y Password de la base de datos local*

Para complementar el analisis, también se importaron directamente a Power BI los archivos .csv de la población de Argentina y de los accesos de internet movil a través de los años, ademas de una tabla dimensional de provincias con información de latitud y longitud para realizar mapas de cobertura. 

Los datos disponibles no disponen de fecha especificas, los atributos de tiempo corresponden a año y trimestre, para facilitar el uso de filtros, se creara una columna "fechaSimulada" en cada tabla con año y trimestre y luego se enlaza con una tabla dimensional de calendario.


    FechaSimulada = DATE([Año], 3 * ([Trimestre] - 1 ) + 1, 1)

![Modelo Power BI](https://raw.githubusercontent.com/cristhianc001/argentinian-telecommunications-analysis/main/img/modelo-power-bi.png)
*Modelo relacional en Power BI*

Los dashboards realizados con este modelo se muestran a continuación:

![Modelo Power BI](https://raw.githubusercontent.com/cristhianc001/argentinian-telecommunications-analysis/main/visualizations/dashboard-accesos.png)
*Dashboard de Accesos y Cobertura*


![Dashboard Power BI](https://raw.githubusercontent.com/cristhianc001/argentinian-telecommunications-analysis/main/visualizations/dashboard-conexion.png)
*Dashboard de Tipos de Conexion*


![Dashboard Power BI](https://raw.githubusercontent.com/cristhianc001/argentinian-telecommunications-analysis/main/visualizations/dashboard-velocidad.png)
*Dashboard de Velocidad*

El archivo .pbix esta en la carpeta de [visualizations](visualizations/) si se requiero un vistazo mas profundo,

## 4. Documentación
- [API Georef](https://datos.gob.ar/dataset/jgm-servicio-normalizacion-datos-geograficos/archivo/jgm_8.1)
- [CAPAS SIG](https://www.ign.gob.ar/NuestrasActividades/InformacionGeoespacial/CapasSIG)
- [Población, total - Argentina](https://datos.bancomundial.org/indicator/SP.POP.TOTL?locations=AR)
- [Definiciones y conceptos](https://www.estadisticaciudad.gob.ar/eyc/publicaciones/anuario_2005/Cd_Cap13/dyc13.htm#:~:text=Dial-Up:%20son%20conexiones%20que,servicio%20de%20acceso%20a%20Internet)
- [Datos Abiertos de ENACOM](https://datosabiertos.enacom.gob.ar/home)
- [Junar - Documentación de API v2](https://junar.github.io/docs/es/)
- [En la Argentina ya hay más de 7 millones de accesos fijos a internet](https://www.infobae.com/economia/2017/06/13/en-la-argentina-ya-hay-mas-de-7-millones-de-accesos-fijos-a-internet/)
- [El 11,9 % de las conexiones a internet en Argentina son por fibra óptica](https://www.infobae.com/tecno/2020/07/14/el-119-de-las-conexiones-a-internet-en-argentina-son-por-fibra-optica/)

## 5. Herramientas usadas
- [Pandas](https://pandas.pydata.org/docs/), [requests](https://requests.readthedocs.io/en/latest/) fueron las librerias usadas para la extracción y limpieza de datos.
- [Matplotlib](https://matplotlib.org/stable/index.html), [Seaborn](https://seaborn.pydata.org/), [Plotly](https://plotly.com/python/getting-started/) fueron las librerias usadas para la visualización de datos.
- [Power BI](https://powerbi.microsoft.com/es-es/) como herramienta de creación de dashboards.
- [MySQL](https://www.mysql.com/) como motor de bases de datos.
- [Visual Studio Code](https://code.visualstudio.com/) es el editor de código usado en este proyecto.

## 6. Contacto
- [LinkedIn](https://www.linkedin.com/in/cristhiancastro/)