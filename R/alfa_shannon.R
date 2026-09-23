# Índice de diversidad alfa (Riqueza y Shannon) basado en ps_corregido

# 0. Cargar librerías
library(phyloseq)
library(ggplot2)

# 1. Crear la variable asignando las etiquetas sobre ps_corregido
sample_data(ps_corregido)$Grupo_Muestra <- ifelse(
  grepl("D$", sample_names(ps_corregido)), 
  "Abdomen", 
  "Pata"
)

# 2. Representar diversidad alfa con ps_corregido
p_alfa <- plot_richness(ps_corregido, measures = c("Observed", "Shannon")) +
  geom_point(aes(color = Grupo_Muestra), size = 3.5, alpha = 0.9) +
  scale_color_manual(
    values = c("Abdomen" = "#d7191c", "Pata" = "#ff7f00"),
    name = "Tipo de muestra"
  ) +
  # Cambio el nombre de "Observed" a "Riqueza (S)" 
  facet_wrap(
    ~variable, 
    scales = "free_y", 
    labeller = as_labeller(c("Observed" = "Riqueza (S)", "Shannon" = "Shannon"))
  ) +
  theme_minimal(base_size = 11) +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1, face = "bold"),
    panel.grid.minor = element_blank(),
    strip.text = element_text(face = "bold", size = 11),
    strip.background = element_rect(fill = "grey92", color = NA),
    legend.position = "bottom",
    plot.title = element_text(face = "bold", size = 14, hjust = 0.5)
  ) +
  labs(
    title = "Diversidad alfa según tipo de muestra",
    x = NULL,
    y = "Valor del Índice"
  )

print(p_alfa)

# 3. Guardar .png

ggsave(
  filename = "alfa_shannon.png",
  plot = p_alfa,
  dpi = 600,            
  width = 10,             # Ancho en pulgadas
  height = 8,             # Alto en pulgadas
  units = "in",
  bg = "white"            # fondo blanco
)
