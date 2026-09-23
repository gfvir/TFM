# Diversidad beta. Bray - Curtis. Con abdomen corregido y sin EX1

# 0. Cargar librerías
library(phyloseq)
library(ggplot2)
library(ggrepel)
library(vegan)

# 1. Transformar ps_corregido a RPM reales (usando raw_reads_pairs)
ps_rpm_corregido <- ps_corregido

otu_table(ps_rpm_corregido) <- otu_table(
  sweep(as(otu_table(ps_corregido), "matrix"), 
        if (taxa_are_rows(ps_corregido)) 2 else 1, 
        sample_data(ps_corregido)$raw_reads_pairs, 
        "/") * 1e6, 
  taxa_are_rows = taxa_are_rows(ps_corregido)
)

# 2. Calcular la ordenación por PCoA usando la distancia de Bray-Curtis
ord_bray_corregido <- ordinate(ps_rpm_corregido, method = "PCoA", distance = "bray")

# 3. Generar el gráfico de PCoA etiquetado
p <- plot_ordination(ps_rpm_corregido, ord_bray_corregido) +
  geom_point(aes(color = Grupo_Muestra, shape = Grupo_Muestra), size = 4, alpha = 0.85) +
  # Añadir los nombres de cada muestra con ggrepel
  geom_text_repel(
    aes(label = sample_names(ps_rpm_corregido)),
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
    x = paste0("PCoA 1 (", round(ord_bray_corregido$values$Relative_eig[1] * 100, 1), "%)"),
    y = paste0("PCoA 2 (", round(ord_bray_corregido$values$Relative_eig[2] * 100, 1), "%)")
  )

# 4. Mostrar gráfico
print(p)

# 5. Guardar .png
ggsave(
  filename = "bray_curtis.png",
  plot = p,
  dpi = 600,             # máxima resolución
  width = 10,            # ancho en pulgadas
  height = 8,            # alto en pulgadas 
  units = "in",          # unidades en pulgadas
  bg = "white"           # fondo blanco
)
