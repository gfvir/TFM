# Diversidad beta, sin EX1

#0. Cargo librerías

library(phyloseq)
library(ggplot2)
library(ggrepel) # para evitar que las etiquetas se solapen

# 1. Generar el gráfico base de la PCoA sin EX1
p <- plot_ordination(ps_clean, ord_bray_clean) +
  geom_point(aes(color = Grupo_Muestra, shape = Grupo_Muestra), size = 4, alpha = 0.85) +
  # Añadir los nombres de cada muestra
  geom_text_repel(
    aes(label = sample_names(ps_clean)),
    size = 3.5,
    box.padding = 0.35,
    point.padding = 0.5,
    max.overlaps = Inf
  ) +
  scale_color_manual(
    values = c("Abdomen" = "#d7191c", "Pata" = "#ff7f00"),
    name = "Tipo de muestra"
  ) +
  scale_shape_manual(
    values = c("Abdomen" = 16, "Pata" = 17),
    name = "Tipo de muestra"
  ) +
  theme_minimal(base_size = 11) +
  theme(
    axis.text.x = element_text(face = "bold"),
    axis.text.y = element_text(face = "bold"),
    panel.grid.minor = element_blank(),
    legend.position = "bottom",
    legend.title = element_text(face = "bold"),
    plot.title = element_text(face = "bold", size = 14, hjust = 0.5)
  ) +
  labs(
    title = "Diversidad beta. PCoA (Distancia de Bray-Curtis)",
    x = paste0("PCoA 1 (", round(ord_bray_clean$values$Relative_eig[1] * 100, 1), "%)"),
    y = paste0("PCoA 2 (", round(ord_bray_clean$values$Relative_eig[2] * 100, 1), "%)")
  )
print(p)

# 2. Guardo .png

ggsave(
  filename = "bray_curtis_beta.png",
  dpi = 600,             # máxima resolución
  width = 10,            # ancho en pulgadas
  height = 8,             # alto en pulgadas 
  units = "in",          # unidades en pulgadas
  bg = "white"           # fondo blanco
)
