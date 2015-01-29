## cargamos las librerias
library(raster)

## leemos los datos
datos <- read.csv("ndvi_robledal.csv", sep = ";")

## obtenemos solo los datos del 2000
datos_ano <- datos[datos$ano == 2000, ]

## clasificamos los valores en función de si están en un rango o en otro
