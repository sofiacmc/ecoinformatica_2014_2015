# Abro la librería y leo la tabla csv que contiene la informacion de las variables ambientales

library(Kendall)
roble<- read.csv("robles_ecoinfo.csv", sep=",")
str(roble)
head(roble)

# Voy a crear una nueva tabla que no contenga las dos primeras columnas de coordenadas x e y
roble_sin <- roble[,c(3,4:33)]

# Mi objetivo es agrupar un conjunto de observaciones en un número dado de clusters o grupos.
#El agrupamiento se basa en la idea de distancia o similitud en las observaciones.

mi_cluster <- kmeans(imagen[], 2, iter.max = 200, nstart = 3)