import pandas as pd
import requests

with open('../auth_key.txt', 'r') as file: # open and read the document in this path
    auth_key = file.read().strip() # store the document in this variable

def get_dataframe(api_dataset):
    response = requests.get(api_dataset) # send a request to a API adress
    if response.status_code == 200: # 200 means successful response
        api_dataset = response.json() # store the output in a variable
        api_dataset = pd.DataFrame(api_dataset["result"], columns=api_dataset["result"][0]) # the columns are in the first row
        api_dataset = api_dataset[1:].reset_index(drop=True) # drop the first row
        return api_dataset
    else:
        return ("Request Error:", response.status_code)
    
## GATHERING THE DATA FROM GOVERNMENTAL API
    
total_nacional_accesos_internet_fijo_por_tecnologia_df = get_dataframe("http://api.datosabiertos.enacom.gob.ar/api/v2/datastreams/TOTAL-NACIO-DE-ACCES-A/data.ajson/?auth_key={}".format(auth_key))

acceso_internet_fijo_por_tecnologia_provincia_df = get_dataframe("http://api.datosabiertos.enacom.gob.ar/api/v2/datastreams/ACCES-A-INTER-FIJO-POR/data.ajson/?auth_key={}".format(auth_key))

accesos_internet_fijo_por_tecnología_localidad_df = get_dataframe("http://api.datosabiertos.enacom.gob.ar/api/v2/datastreams/ACCES-A-INTER-FIJO-62463/data.ajson/?auth_key={}".format(auth_key))

accesos_internet_fijo_por_velocidad_localidad_df = get_dataframe("http://api.datosabiertos.enacom.gob.ar/api/v2/datastreams/ACCES-A-INTER-FIJO-16249/data.ajson/?auth_key={}".format(auth_key))

accesos_internet_fijo_por_velocidad_bajada_provincia_df = get_dataframe("http://api.datosabiertos.enacom.gob.ar/api/v2/datastreams/ACCES-A-INTER-FIJO-97624/data.ajson/?auth_key={}".format(auth_key))

total_nacional_accesos_internet_fijo_por_banda_ancha_banda_angosta_df = get_dataframe("http://api.datosabiertos.enacom.gob.ar/api/v2/datastreams/TOTAL-NACIO-DE-ACCES-48866/data.ajson/?auth_key={}".format(auth_key))

accesos_banda_ancha_banda_angosta_por_provincia_df = get_dataframe("http://api.datosabiertos.enacom.gob.ar/api/v2/datastreams/BANDA-ANCHA-Y-BANDA-ANGOS/data.ajson/?auth_key={}".format(auth_key))

acceso_internet_fijo_por_rangos_velocidad_bajada_provincia_df = get_dataframe("http://api.datosabiertos.enacom.gob.ar/api/v2/datastreams/ACCES-A-INTER-FIJO-23248/data.ajson/?auth_key={}".format(auth_key))

total_nacional_accesos_internet_fijo_por_velocidad_bajada_df = get_dataframe("http://api.datosabiertos.enacom.gob.ar/api/v2/datastreams/TOTAL-NACIO-DE-ACCES-32663/data.ajson/?auth_key={}".format(auth_key))

listado_localidades_conectividad_internet_df = get_dataframe("http://api.datosabiertos.enacom.gob.ar/api/v2/datastreams/LISTA-DE-LOCAL-CON-CONEC/data.ajson/?auth_key={}".format(auth_key))

conectividad_al_servicio_de_internet_df = get_dataframe("http://api.datosabiertos.enacom.gob.ar/api/v2/datastreams/CONEC-AL-SERVI-DE-INTER/data.ajson/?auth_key={}".format(auth_key))

penetracion_internet_fijo_por_provincia_cada_100_habitantes_df = get_dataframe("http://api.datosabiertos.enacom.gob.ar/api/v2/datastreams/PENET-DEL-INTER-FIJO-POR/data.ajson/?auth_key={}".format(auth_key))

penetracion_internet_fijo_por_provincia_cada_100_hogares_df = get_dataframe( "http://api.datosabiertos.enacom.gob.ar/api/v2/datastreams/PENET-DEL-INTER-FIJO-51614/data.ajson/?auth_key={}".format(auth_key))

penetracion_nacional_internet_fijo_df = get_dataframe("http://api.datosabiertos.enacom.gob.ar/api/v2/datastreams/PENET-NACIO-DEL-INTER-FIJO/data.ajson/?auth_key={}".format(auth_key))

velocidad_media_bajada_internet_nacional_df = get_dataframe("http://api.datosabiertos.enacom.gob.ar/api/v2/datastreams/VELOC-PROME-DE-BAJAD-51733/data.ajson/?auth_key={}".format(auth_key))

velocidad_media_bajada_internet_por_provincia_df = get_dataframe("http://api.datosabiertos.enacom.gob.ar/api/v2/datastreams/VELOC-PROME-DE-BAJAD-DE/data.ajson/?auth_key={}".format(auth_key))

ingresos_por_operación_servicio_internet_fijo_df = get_dataframe("http://api.datosabiertos.enacom.gob.ar/api/v2/datastreams/INGRE-POR-LA-OPERA-DEL/data.ajson/?auth_key={}".format(auth_key))

indicadores_macroeconomicos_df = get_dataframe("http://api.datosabiertos.enacom.gob.ar/api/v2/datastreams/INDIC-MACRO/data.ajson/?auth_key={}".format(auth_key))