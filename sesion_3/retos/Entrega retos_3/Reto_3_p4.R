# Dado el conjunto de datos ndvi.zip (podeis descargar de http://www.iecolab.es/ecoinfo/sesion_3.zip)
#Cada imagen raster se tomó un día, a una hora y minutos concretos
#Queremos hacer un script que muestre la evolución del NDVI medio para las horas del día

#Me aseguro de que estoy en el wd correcto.
getwd()
setwd("/home/sofiacm/ecoinformatica_2014_2015/sesion_3")
# Instalo algunos paquetes y cargo las librerías necesarias para trabajar con las imagenes raster.

install.packages(c('sp'), dep=T)

library(raster)
library("sp")
# Creo un vector con todas las horas que indican las imágenes.
hora <- c(12,13,14,15)
# Indicamos que ese vector contiene los valores de ndvi.
valores_ndvi <- c()
# Ejecuto el bucle que me permitirá calcular la evolución del ndvi por horas.
for (k in hora){
  # leo todas las imagenes por horas
  imagen_horas <- list.files(path="./ndvi", full.names=TRUE, recursive=TRUE, 
                             pattern=paste("_", k ,"..\\.jpg\\.asc$", sep=""))
  
  # Apilo las imagenes 
  stack_imagenes <-stack(imagen_horas)
  
  # A partir del stack, calculo la media de todos los pixeles de la imagen
  media_pixel <- mean(stack_imagenes)
  
  # Calculo la media por hora 
  media_hora <- mean(media_pixel[])
  
  # Creo una matriz para almacenar los valores de ndvi, para ello aplico un rbind 
  valores_ndvi <- rbind(valores_ndvi, mean(media_pixel[]))
}


  # Represento gráficamente la evolución del ndvi medio para la franja horaria de 12 a 15 horas.
plot(valores_ndvi, xlab='Horas', x = seq(12,15), ylab='Media NDVI', pch=19, col='red', main='Evolución del ndvi medio para una franja horaria')

