library(dplyr)
library(tidyr)
library(ggplot2)
# 0. orden muestras columnas
orden_muestras <- c(
  "AF014", "AF014D",
  "AF042", "AF042D",
  "AF047", "AF047D",
  "AF048", "AF048D",
  "AF049", "AF049D",
  "EX1"
)

# 1. Partimos del dataframe desglosado 
df_rpm_real <- psmelt(ps) %>%
  mutate(
    # 'Abundance' contiene aquí los conteos brutos (las 13 lecturas)
    # Calculamos RPM reales dividiendo entre las lecturas totales de secuenciación
    RPM_real = (Abundance / raw_reads_pairs) * 1e6
  )
# 2. Generar la matriz con las RPM reales (especies en filas, muestras en columnas)
matriz_rpm_real <- df_rpm_real %>%
  select(OTU, Sample, RPM_real) %>%
  pivot_wider(names_from = Sample, values_from = RPM_real)
# 3. gráfico de abundancia lecturas/millon
ggplot(df_rpm_real, aes(x = Sample, y = RPM_real, fill = OTU)) +
  geom_bar(stat = "identity", position = "stack") +
  theme_minimal(base_size = 12) +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1),
    legend.position = "right",
    legend.text = element_text(size = 8)
  ) +
  labs(
    title = "Abundancia real de especies por millón de lecturas secuenciadas",
    x = "Muestra",
    y = "RPM Reales (sobre total secuenciado)",
    fill = "Especie"
  )
