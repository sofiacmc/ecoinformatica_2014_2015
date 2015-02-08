# Abro la librería y leo la tabla csv que contiene la informacion de las variables ambientales
# Mi objetivo es agrupar un conjunto de observaciones en un número dado de clusters o grupos.
#El agrupamiento se basa en la idea de distancia o similitud en las observaciones.
# Estudio mis datos de robles_ecoinfo.csv

robles<-read.csv("robles_ecoinfo.csv", header = T, sep = ",", dec=".")

# Creo un subset de datos: no quiero que me coja las dos primeras columnas x e y para el cluster, ya que corresponden a las coordenadas.
variables<- subset(robles, select=-c(x,y))

#Defino el número de clusters en los que quiero agrupar mis pixeles y el número máximo de iteraciones que quiero.
n_cluster<-3
cluster<-kmeans(variables,n_cluster, iter.max=200, nstart=3)
# Selecciono el primer elemento de la lista cluster, asi como el elemento size  
cluster[[1]]
cluster$size
# Creo "resultado", que es un subset de robles y las columnas de coordenadas.
resultado<-subset(robles,select=c(x,y))
head(resultado)
# Mediante un cbind,combino el subset anterior con los valores de cluster asignados a cada pixel.
resultado<-cbind(resultado, cluster[[1]])
head(resultado)
str(resultado)

# Ya tengo mi dataframe con 3 variables. Doy nombre a la tercera columna de mi dataframe resultado mediante la funcion colnames
colnames(resultado)[3]<-"cluster"
head(resultado)

## Recuerdo que estoy trabajando con 3 clusters
n_cluster <- 3 

library(sp)
library(rgdal)
library(classInt)
library(RColorBrewer)

## definimos las coordenadas de los puntos
coordinates(resultado) =~x+y
## definimos el sistema de coordenadas WGS84
proj4string(resultado)=CRS("+init=epsg:23030")

## obtenemos n_cluster colores para una paleta de colores que se llama "Spectral", para cada cluster creado
plotclr <- rev(brewer.pal(n_cluster, "Spectral"))

## plot, asignando el color en función del cluster al que pertenece
plot(resultado, col=plotclr[resultado$cluster], pch=19, cex = .6, main = "Mapa de grupos de roble")






