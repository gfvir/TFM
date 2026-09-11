library(phyloseq)
library(tidyverse)

# 1. Cargar y limpiar datos
archivos_csv <- list.files(pattern = "_filterBAM.csv$")

datos_raw <- archivos_csv %>%
  lapply(function(archivo) {
    read_delim(
      archivo, 
      delim = ";", 
      show_col_types = FALSE,
      col_types = cols(.default = col_character()),
      na = c("", "NA", "NA_character_", "null", "NULL", "-", "None", "nan")
    )
  }) %>%
  bind_rows() %>%
  mutate(
    # columnas de texto
    across(c(ID, species, reference), as.character),
    
    # todas las columnas numéricas
    across(
      c(n_reads, read_length_mean, read_aligned_length, mapping_quality,
        read_length_std, gc_content, read_aln_score, edit_distances, 
        read_ani_mean, read_ani_std, read_ani_median, mean_covered_bases, 
        coverage_mean, coverage_covered_mean, breadth, exp_breadth, 
        site_density, entropy),
      ~ parse_number(., locale = locale(decimal_mark = ","))
    )
  )

# 2. Crear tabla de abundancias (otu_table)
otu_df <- datos_raw %>%
  select(ID, species, n_reads) %>%
  # Agrupar por si hay especies repetidas en la misma muestra para sumar sus lecturas
  group_by(species, ID) %>%
  summarise(n_reads = sum(n_reads, na.rm = TRUE), .groups = "drop") %>%
  # pivotar a formato ancho
  pivot_wider(names_from = ID, values_from = n_reads, values_fill = 0) %>%
  tibble::column_to_rownames("species")

# 3. Objeto otu_table para phyloseq
OTU <- otu_table(as.matrix(otu_df), taxa_are_rows = TRUE)

# 4. tax table
tax_df <- datos_raw %>%
  distinct(species) %>%
  mutate(
    Genus = word(species,1),
    Species = species
  ) %>%
  select(Genus, Species) %>%
  tibble::column_to_rownames("Species")

TAX <- tax_table(as.matrix(tax_df))

# 5. Metadatos 
# leer el archivo TSV de metadatos
tsv <- read.table(
  "vir_test_library_metrics.sorted.tsv", 
  header = TRUE, 
  sep = "\t", 
  stringsAsFactors = FALSE
)

# preparar el dataframe para phyloseq
sample_df <- tsv %>%
  rename(ID = id) %>%
  mutate(ID = gsub("_library-1", "", ID)) %>% # Elimina el sufijo
  tibble::column_to_rownames("ID")

# crear el objeto sample_data
SAM <- sample_data(sample_df)

# 6. Objeto phyloseq
ps <- phyloseq(OTU, TAX, SAM)
