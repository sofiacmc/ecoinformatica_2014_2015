#Algoritmo que multiplique 5 numeros introducidos por el usuario
#Establezco las condiciones iniciales
resultado <- 1
contador <- 1

# Hago el bucle
while ( contador < 6 ){
  print( "Escribe un numero: " )
  numeroIntroducido = scan(,what=numeric(),1)
  resultado <- resultado * numeroIntroducido
  contador <- contador + 1
  if ( contador == 6 ) {
    print( "Resultado final: " )
    print( resultado )
  }
}
