# Abro la librería y leo la tabla csv que contiene la informacion de las variables ambientales
# Mi objetivo es agrupar un conjunto de observaciones en un número dado de clusters o grupos.
#El agrupamiento se basa en la idea de distancia o similitud en las observaciones.
# Abro y miro mis datos de robles_ecoinfo.csv

robles<-read.csv("robles_ecoinfo.csv", header = T, sep = ",", dec=".")

# Le digo que no quiero que me coja las dos primeras columnas x e y para mi cluster.
variables<- subset(robles, select=-c(x,y))

#Defino el número de clusters (o grupos) que quiero hacer de los píxeles
n_cluster<-3
cluster<-kmeans(variables,n_cluster, iter.max=200, nstart=3)
cluster[[1]]
cluster$size
resultado<-subset(robles,select=c(x,y))
head(resultado)
resultado<-cbind(resultado, cluster[[1]])
head(resultado)
str(resultado)

colnames(resultado)[3]<-"cluster"
head(resultado)


## OJO: esta variable debería de estar en vuestro script
## variable con el número de cluster con el que estamos probando
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






