# Curvas de rarefacción sin EX1 y escala de rojos
# 0. Cargar librerías
library(vegan)
library(ggplot2)
library(dplyr)

# 1. Extraer datos de la matriz y filtrar EX1
rare_df_clean <- rarecurve(otu_matrix, step = 50, tidy = TRUE) %>%
  filter(Site != "EX1")

# 2. Generar automáticamente una paleta tonos rojo según número de muestras
n_muestras <- length(unique(rare_df_clean$Site))
rojos_automaticos <- colorRampPalette(c("#fee0d2", "#fc4e2a", "#800026"))(n_muestras)

# 3. Generar el gráfico
p_rarefaction <- ggplot(rare_df_clean, aes(x = Sample, y = Species, group = Site, color = Site)) +
  geom_line(linewidth = 0.9, alpha = 0.85) +
  scale_color_manual(values = rojos_automaticos) +
  theme_minimal(base_size = 11) +
  theme(
    panel.grid.minor = element_blank(),
    plot.title = element_text(face = "bold", size = 14, hjust = 0.5),
    legend.title = element_text(face = "bold"),
    legend.position = "right"
  ) +
  labs(
    title = "Curvas de rarefacción (Microbiota Bombus pascuorum)",
    x = "Número de lecturas secuenciadas",
    y = "Riqueza de especies",
    color = "Muestra"
  )

print(p_rarefaction)

# 3. Guardar .png
ggsave(
  filename = "rarefaction_curves_red.png",
  plot = p_rarefaction,
  dpi = 600,            # máxima resolución
  width = 10,           # ancho en pulgadas
  height = 8,           # alto en pulgadas 
  units = "in",         # unidades en pulgadas
  bg = "white"          # fondo blanco
)
