# Curvas de rarefacción con abdómenes corregidos y sin EX1
# 0. Cargar librerías
library(phyloseq)
library(vegan)
library(ggplot2)
library(dplyr)

# 1. Extraer la matriz de conteos de ps_corregido (muestras en filas para vegan)
otu_matrix <- t(as(otu_table(ps_corregido), "matrix"))

# 2. Calcular las curvas de rarefacción
rare_df_clean <- rarecurve(otu_matrix, step = 50, tidy = TRUE)

# 3. Generar paleta de rojos según el número de muestras
n_muestras <- length(unique(rare_df_clean$Site))
rojos_automaticos <- colorRampPalette(c("#fee0d2", "#fc4e2a", "#800026"))(n_muestras)

# 4. Generar el gráfico
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
    title = "Curvas de rarefacción (Panel microbiano Bombus pascuorum)",
    x = "Número de lecturas secuenciadas",
    y = "Riqueza de especies",
    color = "Muestra"
  )

print(p_rarefaction)

# 5. Guardar .png
ggsave(
  filename = "curvas_rarefaccion.png",
  plot = p_rarefaction,
  dpi = 600,             # máxima resolución
  width = 10,            # ancho en pulgadas
  height = 8,            # alto en pulgadas 
  units = "in",          # unidades en pulgadas
  bg = "white"           # fondo blanco
)
