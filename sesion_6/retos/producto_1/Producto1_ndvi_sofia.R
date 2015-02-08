# Establezco mi working directory e inicio la libreria kendall.
library(Kendall)
datos<- read.csv("ndvi_robledal.csv", sep=";")
str(datos)
head(datos)
# Creo varios data frame en los que almacenar la información que genere el bucle(evitamos que se sobrescriba). En mk_aux tan sólo se almacenará la última vuelta del bucle.
mk <- data.frame()
mk_aux <- data.frame(iv_malla_modi_id=NA,
                     tau=NA,
                     pvalue=NA)
# Creo un objeto llamado pixeles para qu el bucle analice la tendencia en todos ellos. Aplico la función unique para que no coja valores repetidos. Le digo que los pixeles están en la tabla original datos y en la columna iv_malla_modi_id).
pixeles <- unique(datos$iv_malla_modi_id)
# Establezco las condiciones del bucle:
for (k in pixeles){ 
  # Hago un subset de datos (valores de ndvi por año para cada pixel i)
  aux <- datos[datos$iv_malla_modi_id==k,]
  
  # Hago un mann-kendall para el subset de datos e indico las columnas que tiene el dataframe, donde se almacenara la info 
  m <- MannKendall(aux$ndvi_i) 
  
  mk_aux$iv_malla_modi_id <- k # identificador del pixel 
  mk_aux$tau <-m$tau[1]# tau
  mk_aux$pvalue <- m$sl[1] # pvalue
  
  mk <- rbind(mk, mk_aux)
} 

# Procedo a pintar el mapa 
library(plyr)
datos1 <- datos[,c(1,4:5)]
coord_pixel <- unique(datos1)

tendencia <- join(mk, coord_pixel, "iv_malla_modi_id")
library(sp)
library(rgdal)
library(classInt)
library(RColorBrewer)

## definimos las coordenadas de los puntos
coordinates(tendencia) =~lng+lat
## definimos el sistema de coordenadas WGS84
proj4string(tendencia)=CRS("+init=epsg:4326")

## partimos los valores de tau en 5 clases
clases <- classIntervals(tendencia$tau, n = 5)
## obtenemos cinco colores para una paleta de colores que se llama
"Spectral"
plotclr <- rev(brewer.pal(5, "Spectral"))
## Asociamos los valores de tau a su valor correspondiente
colcode <- findColours(clases, plotclr)


plot(tendencia, col=colcode, pch=19, cex = .6, main = "Mapa de tendencias de NDVI en robledales de Sierra Nevada")
## mostramos la leyenda
legend("topright", legend=names(attr(colcode, "table")),
       fill=attr(colcode, "palette"), bty="n")

###### Otra forma de pintar el mapa

cosa$significativa <- ifelse(cosa$pvalue < 0.05, 1, 2)
## plot sin tener en cuenta
plot(cosa, col=colcode, pch=c(19, 20)[as.numeric(cosa$significativa)],
     cex = .6, main = "Mapa de tendencias")
## mostramos la leyenda
legend("topright", legend=names(attr(colcode, "table")),
       fill=attr(colcode, "palette"), bty="n")
