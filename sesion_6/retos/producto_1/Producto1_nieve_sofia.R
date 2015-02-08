# Abro mi libreria y leo el csv que contiene la informacion de la nieve, viendo su estructura
library(Kendall)
datosnieve<-read.csv("nieve_robledal.csv", sep=";")
str(datos)
head(datos)

# Importante saber en que working directoy estoy!

getwd()

# Creo dos dataframes donde se almacenaran los datos que genere con el bucle
mk2 <- data.frame()
mk_aux2 <- data.frame(nie_malla_modi_id=NA,
                      tau=NA,
                      pvalue=NA)
str(mk_aux2)
# Creo un objeto llamado pixeles para qu el bucle analice la tendencia en todos ellos. Aplico la función unique para que no coja valores repetidos. Le digo que los pixeles están en la tabla original datos y en la columna iv_malla_modi_id).

pixeles2 <- unique(datosnieve$nie_malla_modi_id)

# Establezco las condiciones del bucle:

for (k in pixeles2){ 
  # Hago un subset de datos (valores de ndvi por año para cada pixel i)
  aux2 <- datosnieve[datosnieve$nie_malla_modi_id==k,]
  
  # Hago un mann-kendall para el subset de datos e indico las columnas que tiene el dataframe, donde se almacenara la info 
  m <- MannKendall(aux2$scd) 
  
  mk_aux2$nie_malla_modi_id <- k  # identificador del pixel 
  mk_aux2$tau <-m$tau[1]                 # tau
  mk_aux2$pvalue <- m$sl[1]   # pvalue
  
  mk2 <- rbind(mk2, mk_aux2)
} 

# Represento gráficamente los valores de tau (tendencia)
plot(mk2$tau)

# Pinto el mapa
datos2 <- datosnieve[, c(2, 4:5)]
coord_pixel2 <- unique(datos2)

tendencia2 <- join(mk, coord_pixel, "iv_malla_modi_id")
library(sp)
library(rgdal)
library(classInt)
library(RColorBrewer)

## definimos las coordenadas de los puntos
coordinates(tendencia2) =~lng+lat
## definimos el sistema de coordenadas WGS84
proj4string(tendencia2)=CRS("+init=epsg:4326")

## partimos los valores de tau en 5 clases
clases <- classIntervals(tendencia2$tau, n = 5)
## obtenemos cinco colores para una paleta de colores que se llama
"Spectral"
plotclr <- rev(brewer.pal(5, "Spectral"))
## Asociamos los valores de tau a su valor correspondiente
colcode <- findColours(clases, plotclr)


plot(tendencia2, col=colcode, pch=19, cex = .6, main = "Mapa de tendencias de duración de la nieve en cada pixel")
## mostramos la leyenda
legend("topright", legend=names(attr(colcode, "table")),
       fill=attr(colcode, "palette"), bty="n")


