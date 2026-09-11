# heatmap perfil metagenómico sin EX 1 (blanco de extracción)

#0. cargo librerías

library(dplyr)
library(ggplot2)

# 1. Filtrar el blanco EX1 y asignar categorías
df_rpm_clean <- df_rpm_real %>%
  filter(Sample != "EX1") %>% #quitar el blanco de extracción
  mutate(
    Categoria = case_when(
      # Contaminación
      OTU == "Homo sapiens" ~ "Contaminación",
      
      # Patógenos
      OTU %in% c("Crithidia bombi", "Vairimorpha apis", 
                 "Vairimorpha bombi", "Vairimorpha ceranae",
                 "Wolbachia pipientis") ~ "Patógenos",
      
      # Core Microbiota
      OTU %in% c("Snodgrassella alvi", "Snodgrassella communis", "Snodgrassella gandavensis",
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
ggplot(df_rpm_clean, aes(x = Sample, y = OTU, fill = RPM_real)) +
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
    title = "Perfil metagenómico por categoría funcional (lecturas por millón)",
    x = NULL,
    y = NULL
  )

# 3. Guardo .png

ggsave(
  filename = "heatmap_perfil_metagenomico_clean.png",
  dpi = 600,             # máxima resolución
  width = 10,            # ancho en pulgadas
  height = 8,             # alto en pulgadas 
  units = "in",          # unidades en pulgadas
  bg = "white"           # fondo blanco
)
