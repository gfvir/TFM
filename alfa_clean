# indice de diversidad alfa, richness, shannon, sin EX1

# 0. cargo librerías

library(phyloseq)
library(ggplot2)

# 1. Filtrar el blanco de extracción (EX1) del objeto phyloseq (ps)
ps_clean <- subset_samples(ps, sample_names(ps) != "EX1")

# 2. Crear la variable asignando las etiquetas sobre el objeto filtrado
sample_data(ps_clean)$Grupo_Muestra <- ifelse(
  grepl("D$", sample_names(ps_clean)), 
  "Abdomen", 
  "Pata"
)

# 3. Representar alfa diversidad con ps_clean
plot_richness(ps_clean, measures = c("Observed", "Shannon")) +
  geom_point(aes(color = Grupo_Muestra), size = 3.5, alpha = 0.9) +
  scale_color_manual(
    values = c("Abdomen" = "#d7191c", "Pata" = "#ff7f00"),
    name = "Tipo de muestra"
  ) +
  # cambio el nombre de "Observed" a "Riqueza (S)" 
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

# 3. Guardo .png

ggsave(
  filename = "shannon_alfa_clean.png",
  dpi = 600,             # máxima resolución
  width = 10,            # ancho en pulgadas
  height = 8,             # alto en pulgadas 
  units = "in",          # unidades en pulgadas
  bg = "white"           # fondo blanco
)
