# 0. Guardado .png 
png("mapped_raw_ratio_max_res.png", 
    width = 7,        
    height = 7,      
    units = "in",     
    res = 600,       
    bg = "white")     

#1. cargo el .tsv
tsv <- read.table("vir_test_library_metrics.sorted.tsv", header = TRUE, sep = "\t", stringsAsFactors = FALSE)

# 2. paleta de colores
colores_naranja <- c("#D35400", "#E67E22", "#EB984E", "#F5CBA7", "#FDF2E9")
especimenes <- c("AF014", "AF042", "AF047", "AF048", "AF049")

# 3. cálculo de ratios

ratio_pata <- (tsv[c(2,4,6,8,10), 6] / tsv[c(2,4,6,8,10), 2]) * 100 # eje x
ratio_abdomen <- (tsv[c(1,3,5,7,9), 6] / tsv[c(1,3,5,7,9), 2]) * 100 # eje y

# 4. creamos el scatterplot

plot(ratio_pata,
     ratio_abdomen,
     xlim = c(0, 100),
     ylim = c(0, 100),
     pch = 21, 
     cex = 2, 
     bg = colores_naranja, 
     xlab = "Ratio mapped/raw pata (%)", 
     ylab = "Ratio mapped/raw abdomen (%)",
     main = "Eficiencia de alineamiento ADN endógeno: pata vs. abdomen")

# linea diagonal
abline(0, 1, lwd=1.5, lty=2, col="gray40")

#leyenda

legend("topleft", 
       legend = especimenes, 
       pt.bg = colores_naranja, 
       pch = 21, 
       title = "Especímenes", 
       bty = "n", 
       cex = 0.9)


# guarda y cierra
dev.off()
