#limpio la memoria
rm( list=ls() )  #Borro todos los objetos
gc()   #Garbage Collection

limpiar_temps()

code_name <- '1_ISA_ipcf_it1.R'
subtopico <- 'SALING'
output_name <- 'ISA_ipcf_it1.csv'
id_fuente <- 173
fuente_raw1 <- sprintf("R%sC0",id_fuente)

df_output <- readxl::read_excel(argendataR::get_raw_path(fuente_raw1)) 

df_anterior <- argendataR::descargar_output(nombre = output_name, subtopico = subtopico, entrega_subtopico = "primera_entrega")

#-- Controlar Output ----

comparacion <- argendataR::comparar_outputs(
  df_output,
  df_anterior,
  pk = c('year','semestre'),
  drop_joined_df = F
)

print(comparacion)


df_output %>%
  argendataR::write_output(
    output_name = output_name,
    aclaraciones = "Ingreso familiar per cápita, 2003-2024",
    subtopico = subtopico,
    fuentes = c(fuente_raw1),
    analista = "",
    pk =  c('year','semestre'),
    control = comparacion, 
    es_serie_tiempo = T,
    columna_indice_tiempo = c('year','semestre'),
    nivel_agregacion ='pais',
    etiquetas_indicadores = list('ipcf_index' = 'Índice evolución ingreso per cápita familiar (2003-II = 100)'),
    unidades = list('ipcf_index' = 'unidades')
  )
