# descargar fuente raw desde drive

descargar_fuente_raw(id_fuente = 36, dir = "data/_FUENTES/raw/")



# hoja 1 - OyD Precios ctes -----------------------------------------------


# carga

data <- readxl::read_excel("data/_FUENTES/raw/cuentas-nacionales-fundacion-norte-y-sur.xlsx",
                           sheet = 1, skip = 1)

# rename anio

data <- data %>% 
  rename(anio  = Año)

# armo diccionario de nombres de variables limpios
diccionario_vars <- data[1:4,-1] %>% 
  select(-where(function(x) all(is.na(x)))) %>% 
  filter(!if_all(everything(), is.na)) %>% 
  pivot_longer(everything()) %>% 
  mutate(name_fixed = str_replace_all(name, "\\.{2}\\d{1,2}", NA_character_)) %>% 
  fill(name_fixed)

# pivot longer los datos
data <- data[-c(1:4),] %>% 
  pivot_longer(cols = -anio,
               names_to = "indicador", values_to = "valor")

# le matcheo los nombres limpios de variabels
data <- left_join(data, diccionario_vars, by = c("indicador" = "name"))

# excluyo filas vacias
data <- data %>% 
  filter(!is.na(name_fixed)) %>% 
  select(anio, name_fixed, value, valor)

# agrego columna de pertenencia geografica
data <- data %>% 
  mutate(iso3 = "ARG")

# seleccion y rename de columnas
data <- data %>% 
  select(anio, iso3, indicador = name_fixed, unidad = value, valor)

# valores a numerico
data <- data %>% 
  mutate(valor = as.numeric(valor))

# exlcusion de filas vacias por pivoteo o foramto del excel
data <- data %>% 
  filter(!is.na(valor))

# guardar como csv
write_csv_fundar(data,
                 file = "data/_FUENTES/clean/oferta-demanda-pctes-fnys.csv")  

# carga en sheet fuentes clean
# agregar_fuente_clean(id_fuente_raw = 36,path_clean = "oferta-demanda-pctes-fnys.csv",
#                      nombre = "Oferta y Demanda precios ctes - Cuentas Nacionales",
#                      script = "limpieza_cn_fundacion_norteysur.R")

actualizar_fuente_clean(id_fuente_clean = 4)


# PBI en US$ --------------------------------------------------------------


# carga

data <- readxl::read_excel("data/_FUENTES/raw/cuentas-nacionales-fundacion-norte-y-sur.xlsx",
                           sheet = "PBI en US$", skip = 1)

# rename anio

data <- data %>% 
  rename(anio  = Año)

# armo diccionario de nombres de variables limpios
diccionario_vars <- data[1:4,-1] %>% 
  select(-where(function(x) all(is.na(x)))) %>% 
  filter(!if_all(everything(), is.na)) %>% 
  pivot_longer(everything()) %>% 
  mutate(name_fixed = str_replace_all(name, "\\.{2}\\d{1,2}", NA_character_)) %>% 
  fill(name_fixed)

# pivot longer los datos
data <- data[-c(1:4),] %>% 
  pivot_longer(cols = -anio,
               names_to = "indicador", values_to = "valor")

# le matcheo los nombres limpios de variabels
data <- left_join(data, diccionario_vars, by = c("indicador" = "name"))

# excluyo filas vacias
data <- data %>% 
  filter(!is.na(name_fixed)) %>% 
  select(anio, name_fixed, value, valor)

# agrego columna de pertenencia geografica
data <- data %>% 
  mutate(iso3 = "ARG")

# seleccion y rename de columnas
data <- data %>% 
  select(anio, iso3, indicador = name_fixed, unidad = value, valor)

# valores a numerico
data <- data %>% 
  mutate(valor = as.numeric(valor))

# exlcusion de filas vacias por pivoteo o foramto del excel
data <- data %>% 
  filter(!is.na(valor))

# guardar como csv
write_csv_fundar(data,
                 file = "data/_FUENTES/clean/pbi-pbipc-fyns.csv")  

# carga en sheet fuentes clean
# agregar_fuente_clean(id_fuente_raw = 36,path_clean = "pbi-pbipc-fyns.csv",
#                      nombre = "PBI y PBI per capita - Cuentas Nacionales",
#                      script = "limpieza_cn_fundacion_norteysur.R")

actualizar_fuente_clean(id_fuente_clean = 9)

