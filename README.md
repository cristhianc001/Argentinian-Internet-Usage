# Analisis del estado y evolución del internet fijo de Argentina

![Portada](https://raw.githubusercontent.com/cristhianc001/argentinian-telecommunications-analysis/main/img/portada.png)  

## Introducción

## Estructura

- [`raw_data`](/raw_data.zip): Los datos sin procesar usados en este proyecto se tomaron directamente de la API gubernamental, pero si hay problemas de red en el servidor, hay una copia de seguridad en el archivo `raw_data.zip` en la raíz de este repositorio.
- [`processed_data/`](processed_data/): contiene los datos transformados y limpios en formato CSV.
- [`notebooks/`](notebooks/): Incluye notebooks de Python para limpieza de datos, EDA y visualización. También hay un script de python que importa los datos de la API directamente.
- [`img/`](img/): Incluye imágenes utilizadas en el readme.
- [`visualizations/`](visualizations/): Incluye graficos de Python, dashboards y archivos de Power BI para visualización de datos.

## Procedimiento

### [1. Extracción de Datos](notebooks/1.%20Data_Extraction.ipynb)
Los datos usados en este analisis fueron extraidos del [Ente Nacional de Comunicaciones](https://datosabiertos.enacom.gob.ar/dashboards/20000/acceso-a-internet/) correspondientes al area de Acceso a Internet. Para esto, se consultó la documentación de la API para hallar la dirección de los [datasets](https://api.datosabiertos.enacom.gob.ar/api/v2/datasets/?auth_key=AUTH_KEY) que se accede despues de solicitar una [llave de autenticación](https://datosabiertos.enacom.gob.ar/developers/). La información disponible en el servidor esta en tres presentanciones: datasets, los cuales son archivos de excel donde pueden existar mas de una tabla por archivo; datastreams, que son archivos csv que contienen una tabla por archivo. Estos datastream son desgloses de los dataset. Por ultimo, visualizaciones, como su nombre lo indica, son representaciones visuales de los datastream.

![Dataset, datastreams y visualizaciones](https://raw.githubusercontent.com/cristhianc001/argentinian-telecommunications-analysis/main/img/ejemplo-dataset-api.png)
*El link del dataset esta subrayado en azul, los datastream en rojo y las visualizaciones en amarillo*

Como los datastreams ya estaban en .csv, se usaron estos como objetivo de extracción en lugar de los datasets que estan formato .xlsx
![API de datastream](https://raw.githubusercontent.com/cristhianc001/argentinian-telecommunications-analysis/main/img/ejemplo-datastream-api.png)
*Dirección de API usada para extraer datos de datastreams*

El glosario de terminos que aparecen en las tablas se puede consultar en este [enlace](https://www.estadisticaciudad.gob.ar/eyc/publicaciones/anuario_2005/Cd_Cap13/dyc13.htm#:~:text=Dial%2DUp%3A%20son%20conexiones%20que,servicio%20de%20acceso%20a%20Internet).

### [2. Transformación y Limpieza](notebooks/2.%20Data_Wrangling.ipynb)
La mayoria de los archivos extraidos de la API tenian una buena integridad, por lo tanto se realizaron pocas operaciones sobre los dataframes. Las mayores transformaciones involucraron union (merge) de tablas para resumir el numero de archivos y 'despivotear' (melt) columnas en filas. Tambien se borraron las comas (entre otros caracteres especiales) de las todas las cifras donde estaban presentes para que no hayan problemas de interpretación de miles, millares y punto decimales. 

### [3. Analisis Exploratorio](notebooks/3.%20Exploratory_Data_Analysis.ipynb)
Una vez comprobada la integridad de los datos y definidos los archivos, se realizó un analisis exploratorio de datos para investigar graficamente el comportamiento de la variables del dataset. 

![Grafico de EDA](https://raw.githubusercontent.com/cristhianc001/argentinian-telecommunications-analysis/main/visualizations/barplot-patagonia-accesos.png)
*Accesos por año en las provincas de la region de la Patagonia*

### [4. Construcción de dashboards](visualizations/)
Despues del EDA, se utilizó Power BI para realizar dashboards que faciliten la lectura y analisis de los datos. A continuación uno de los dashboards creados con esta herramienta.

![Dashboard Power BI](https://raw.githubusercontent.com/cristhianc001/movie-recommendation-system/main/img/wordcloud.png)
*Dashboard Power BI*


# Documentación Extra
- [Datos Abiertos de ENACOM](https://datosabiertos.enacom.gob.ar/home)
- [Junar - Documentación de API v2](https://junar.github.io/docs/es/)
- [En la Argentina ya hay más de 7 millones de accesos fijos a internet](https://www.infobae.com/economia/2017/06/13/en-la-argentina-ya-hay-mas-de-7-millones-de-accesos-fijos-a-internet/)
- [El 11,9 % de las conexiones a internet en Argentina son por fibra óptica](https://www.infobae.com/tecno/2020/07/14/el-119-de-las-conexiones-a-internet-en-argentina-son-por-fibra-optica/)

# Herramientas usadas
- [Pandas](https://pandas.pydata.org/docs/), [requests](https://requests.readthedocs.io/en/latest/) fueron las librerias usadas para la extracción y limpieza de datos.
- [Matplotlib](https://matplotlib.org/stable/index.html), [Seaborn](https://seaborn.pydata.org/) fueron las librerias usadas para la visualización de datos.
- [Power BI](https://powerbi.microsoft.com/es-es/) fue la herramiento de creación de dashboard usada.
- [Visual Studio Code](https://code.visualstudio.com/) es el editor de código usado en este proyecto.