## Producto 1

Caracterización del funcionamiento del ecosistema y de las variables ambientales que lo condicionan. Gracias a la gran cantidad de información procedente de sensores remotos, es posible conocer la evolución temporal de variables como la cobertura de nieve, índice de vegetación o temperatura del suelo en los distintos tipos de ecosistemas diana. En concreto evaluaremos la tendencia en la cobertura de nieve para los robledales de Sierra Nevada. Se trata de caracterizar la tendencia en la duración de la nieve para cada píxel ocupado por robledal y año hidrológico. El producto final será un mapa que muestre las tendencias en la duración de la nieve para cada píxel en toda la serie temporal (2000-2012).


### Qué datos tenemos??

1. ndvi_robledal.csv

Serie temporal del NDVI para el robledal con las siguientes columnas:

- iv_malla_modi_id: identificador único del píxel
- ano: año
- ndvi_i: valor de NDVI anual
- lng: Longitud
- lat: Latitud

2. nieve_robledal.csv 

Serie temporal de la Nieve para el robledal con las siguientes columnas:

- nie_malla_modi_id: identificador único del píxel
- ano: año
- scd: duración de la nieve (número de días que el píxel está cubierto de nieve)
- lng: Longitud
- lat: Latitud

