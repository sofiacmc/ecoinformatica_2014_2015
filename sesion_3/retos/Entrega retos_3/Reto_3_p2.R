#Algoritmo que dado un umbral por el usuario, dados 10 números por el usuario, cuente cuántos de esos números supera el umbral indicado.
# Establezco los valores  
valor<-scan(n=10)
suma <- 0
u <- 10

# Creo el bucle y ejecuto
for(valor in valor[1:10]){
  if(valor>u){
    suma <- suma+1
  }
}
print(suma)
