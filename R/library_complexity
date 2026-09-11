# 0. Guardado .png
png("library_complexity_col_max_res.png", 
    width = 6,        # ancho 
    height = 6,       # alto 
    units = "in",     # unidades en pulgadas
    res = 600,        # resolución
    bg = "white")     # fondo

# 1. Cargo el .tsv
tsv <- read.table("vir_test_library_metrics.sorted.tsv", header = TRUE, sep = "\t", stringsAsFactors = FALSE)

# 2. Paleta de colores VIU
colores_naranja <- c("#D35400", "#E67E22", "#EB984E", "#F5CBA7", "#FDF2E9")

# 3. Hago el plot con los datos
plot(tsv[c(2,4,6,8,10), 11], # Eje X: Pata
     tsv[c(1,3,5,7,9), 11],  # Eje Y: Abdomen
     xlim = c(0, 100),       # Límites de los ejes
     ylim = c(0, 100),
     pch = 21,               # Círculos con borde
     bg = colores_naranja,   # Colores de los puntos
     cex = 2,                # Tamaño de los puntos
     xlab = "Complejidad librerías pata (%)", 
     ylab = "Complejidad librerías abdomen (%)",
     main = "Complejidad en las librerías (%)")

# 4. Línea discontinua de comparación
abline(0, 1, lwd = 1.5, lty = 2, col = "gray40")

# 5. Leyenda con los nombres de los individuos y colores paleta naranja
legend("topleft", 
       legend = c("AF014", "AF042", "AF047", "AF048", "AF049"), 
       pt.bg = colores_naranja, 
       pch = 21, 
       title = "Especímenes",
       bty = "n",             # Leyenda sin bordes
       cex = 0.9)

# 6. Cierra y guarda el archivo
dev.off()
