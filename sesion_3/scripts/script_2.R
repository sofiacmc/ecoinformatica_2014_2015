## leemos el csv de internet
## calculamos la temperatura máxima de las máximas registradas
## mostramos la temperatura máxima
## calculamos la temperatura mínima de las máximas
## mostramos la temperatura mínima
## mostramos un gráfico con la distribución de la temperatura mínima


temperatura_max <- max(temperaturas$tmax)
temperatura_min <- min(temperaturas$tmax)
print(temperatura_max)
temperaturas <- read.table("http://www.iecolab.es/ecoinfo/temperatura.csv", header = TRUE, sep= ",")
plot(x$tmin)
print(paste("La temperatura minima de las temperaturas máximas es:",temperatura_min))
