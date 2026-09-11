# 0. Guardado en .png
png("adn_endogeno_max_res.png", 
    width = 6,        # ancho
    height = 6,       # alto
    units = "in",     # unidades en pulgadas
    res = 600,        # resolución
    bg = "white")     # fondo

#1. cargo el .tsv
tsv <- read.table("vir_test_library_metrics.sorted.tsv", header = TRUE, sep = "\t", stringsAsFactors = FALSE)

#2. paleta de colores naranja viu 5 individuos
colores_naranja <- c("#D35400", "#E67E22", "#EB984E", "#F5CBA7", "#FDF2E9")

#3. hago el plot con los datos
plot(tsv[c(2,4,6,8,10), 9], # eje X, pata
     tsv[c(1,3,5,7,9), 9], # eje y, abdomen
     xlim = c(0, 100), # limites de los ejes
     ylim = c(0, 100),
     pch = 21, # circulos con bordes
     bg = colores_naranja, # colores de los puntos
     cex = 2, # tamaño de los puntos
     xlab = "Extracción pata (%)", #labels
     ylab = "Extracción abdomen (%)",
     main = "ADN endógeno (MQ = 25) (%)")

# 4. Añado linea diagonal de comparación
abline(0, 1, lwd=1.5, lty=2, col="gray40") # crea una linea que comienza en x,y = 0 con intercepto 1 y ancho 1.5

#linea gris discontinua

# 5. añado la leyenda
legend("topleft", 
       legend = c("AF014", "AF042", "AF047", "AF048", "AF049"), # nombres de los puntos
       pt.bg = colores_naranja, # asociacion nombres colores
       pch = 21, # puntos con borde
       title = "Especímenes",
       bty = "n", # leyenda sin borde
       cex = 0.9) # tamaño de la leyenda

# 6. cierra el archivo y guarda el trabajo
dev.off() 
