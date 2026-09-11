# 0. Guardado en .png max res
png("barplot_max_res_png.png", 
    width = 6,        # ancho en pulgadas 
    height = 6,       # alto en pulgadas
    units = "in",     # unidades en pulgadas
    res = 600,        # máxima resolución
    bg = "white")     # fondo blanco

#1. cargo el .tsv
tsv <- read.table("vir_test_library_metrics.sorted.tsv", header = TRUE, sep = "\t", stringsAsFactors = FALSE)

# 2 creo el barplot
nombres <- gsub("_library-1", "", tsv$id[1:10]) # gsub le quita la parte final al nombre muestra
nombres <- gsub("D$", "a", nombres) # los que terminen en D pone a de abdomen
nombres <- gsub("(\\d)$", "\\1p", nombres) #los que terminan en cifra le pone p de pata

options(scipen = 999) # desctivo la notación científica 

par(mar = c(8, 8, 4, 2)) # ajustes en los márgenes

barplot(tsv[1:10 ,2] / 1e6,
        names.arg = nombres, 
        las = 2, 
        col = rep(colores_naranja, each = 2),
        ylab = "Millones de lecturas",
        ylim = c(0, 50), # tamaño eje y
        main = "Número de lecturas crudas por muestra")

mtext("Nota: a = abdomen; p = pata", side = 1, line = 5, cex = 0.8, adj = 0.5) # nota al pie

# guarda y cierra
# dev.off()
