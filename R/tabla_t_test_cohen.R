# 1. Función que hace el t-test, calcula la d de Cohen y extrae todo en una fila
extraer_resultados_t <- function(col_leg, col_abd, nombre_metrica) {
  # Ejecutar el t-test pareado
  test <- t.test(col_leg, col_abd, paired = TRUE)
  
  # Tamaño del efecto (d de Cohen pareada)
  diferencias <- col_leg - col_abd
  cohen_d <- mean(diferencias) / sd(diferencias)
  
  # Una sola fila (data.frame) con todas las columnas estructuradas
  data.frame(
    Metrica = nombre_metrica,
    media_leg = mean(col_leg),
    media_abd = mean(col_abd),
    dif_media = test$estimate[[1]],
    t = test$statistic[[1]],
    grados_libertad = test$parameter[[1]],
    p_valor = test$p.value,
    IC_95_inf = test$conf.int[1],
    IC_95_sup = test$conf.int[2],
    d_Cohen = cohen_d,
    stringsAsFactors = FALSE
  )
}

# 2. Cargar info alineamiento
align_leg <- (paired_tsv$mapped_reads_leg / paired_tsv$raw_reads_pairs_leg) * 100
align_abd <- (paired_tsv$mapped_reads_abd / paired_tsv$raw_reads_pairs_abd) * 100

# 3. Ejecutar la función y unir las filas rbind
tabla_resultados <- rbind(
  extraer_resultados_t(paired_tsv$mapped_reads_leg / 1e6, paired_tsv$mapped_reads_abd / 1e6, "Lecturas mapeadas (millones)"),
  extraer_resultados_t(align_leg, align_abd, "Eficiencia del alineamiento (%)"),
  extraer_resultados_t(paired_tsv$endogenous_DNA_leg, paired_tsv$endogenous_DNA_abd, "ADN endogeno (%)"),
  extraer_resultados_t(paired_tsv$library_complexity_leg, paired_tsv$library_complexity_abd, "Complejidad de la libreria (%)"),
  extraer_resultados_t(paired_tsv$mean_read_length_leg, paired_tsv$mean_read_length_abd, "Longitud media de lectura (pb)")
)

# 4. redondear resultados
tabla_resultados[, 2:4]  <- round(tabla_resultados[, 2:4], 2)  # Medias y diferencias
tabla_resultados[, 5]    <- round(tabla_resultados[, 5], 3)    # t-estadístico
tabla_resultados[, 7]    <- round(tabla_resultados[, 7], 5)    # p-valor
tabla_resultados[, 8:10] <- round(tabla_resultados[, 8:10], 2) # Intervalos de confianza y Cohen d

# 5. Ver la tabla
View(tabla_resultados)

# 6. guardar la tabla

write.csv2(tabla_resultados, "tabla_resultados_t_test.csv", row.names = FALSE)
