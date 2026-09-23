# heatmap abundancias en rpm especies cribado microbiano (desde rpm corregido)

# 0. Cargo librerías

library(dplyr)
library(tidyr)
library(ggplot2)

# 1. Transformar tabla_rpm_corregido a formato largo y clasificar especies por categorías
df_heatmap <- tabla_rpm_corregido %>%
  pivot_longer(
    cols = -Especie, 
    names_to = "Sample", 
    values_to = "RPM_corregida"
  ) %>%
  mutate(
    Categoria = case_when(
      # Contaminación
      Especie == "Homo sapiens" ~ "Contaminación",
      
      # Patógenos
      Especie %in% c("Crithidia bombi", "Vairimorpha apis", 
                     "Vairimorpha bombi", "Vairimorpha ceranae",
                     "Wolbachia pipientis") ~ "Patógenos",
      
      # Core Microbiota
      Especie %in% c("Snodgrassella alvi", "Snodgrassella communis", "Snodgrassella gandavensis",
                     "Gilliamella apicola", "Gilliamella bombicola", "Gilliamella mensalis", "Gilliamella sp",
                     "Lactobacillus bombicola", "Lactobacillus panisapium",
                     "Bifidobacterium bohemicum", "Bombiscardovia coagulans", 
                     "Schmidhempelia bombi") ~ "Core microbiota",
      
      # El resto pasa a Non-core microbiota
      TRUE ~ "Non-core microbiota"
    ),
    Categoria = factor(Categoria, levels = c("Core microbiota", "Non-core microbiota", "Patógenos", "Contaminación"))
  )

# 2. Generar el heatmap
p_heatmap <- ggplot(df_heatmap, aes(x = Sample, y = Especie, fill = RPM_corregida)) +
  geom_tile(color = "grey85", linewidth = 0.2) +
  scale_fill_gradient(
    low = "white",
    high = "#d7191c",
    trans = "log1p",
    breaks = c(0, 10, 50, 100, 150, 171.5),
    name = "RPM",
    guide = guide_colorbar(barheight = unit(7, "cm"), barwidth = unit(0.5, "cm"))
  ) +
  scale_y_discrete(limits = rev) +
  facet_grid(Categoria ~ ., scales = "free_y", space = "free_y") +
  theme_minimal(base_size = 11) +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1, face = "bold"),
    axis.text.y = element_text(face = "italic"),
    panel.grid = element_blank(),
    strip.text.y = element_text(face = "bold", size = 10, angle = 0, hjust = 0),
    strip.background = element_rect(fill = "grey92", color = NA),
    plot.title = element_text(face = "bold", size = 14, hjust = 0.5)
  ) +
  labs(
    title = "Panel microbiano (lecturas por millón)",
    x = NULL,
    y = NULL
  )

# 3. Sacar por pantalla
print(p_heatmap)

# 5. Guardar .png
ggsave(
  filename = "heatmap.png",
  plot = p_heatmap,
  dpi = 600,             # máxima resolución
  width = 10,            # ancho en pulgadas
  height = 8,            # alto en pulgadas 
  units = "in",          # unidades en pulgadas
  bg = "white"           # fondo blanco
)
