# 0. Guardado .png
png("read_mean_length_max_res.png", 
    width = 6,        
    height = 6,       
    units = "in",     
    res = 600,        
    bg = "white")     

#1. cargo el .tsv
tsv <- read.table("vir_test_library_metrics.sorted.tsv", header = TRUE, sep = "\t", stringsAsFactors = FALSE)

# 2. paleta de colores
colores_naranja <- c("#D35400", "#E67E22", "#EB984E", "#F5CBA7", "#FDF2E9")

# 3. scatterplot
plot(tsv[c(2,4,6,8,10), 14], # x = pata
     tsv[c(1,3,5,7,9), 14], # y = abdomen
     xlim = c(0, 100),
     ylim = c(0, 100),
     pch = 21, 
     bg = colores_naranja, 
     cex = 2, 
     xlab = "Tamaño medio de lectura pata (pb)", 
     ylab = "Tamaño medio de lectura abdomen (pb)",
     main = "Tamaño medio de lectura (pb)")

# 4. linea diagonal de comparación
abline(0, 1, lwd=1.5, lty=2, col="gray40")

# 5. leyenda
legend("topleft",
       legend = c("AF014", "AF042", "AF047", "AF048", "AF049"),
       pt.bg = colores_naranja,
       pch = 21, 
       cex = 0.9,
       title = "Especímenes",
       bty = "n")

# guarda y cierra
dev.off()
