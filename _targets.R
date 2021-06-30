library(targets)
library(tarchetypes)
purrr::walk(fs::dir_ls("R"), source)
tar_option_set(packages = c("tidyverse", "igraph"))
list(
  tar_file(file_config, "config/tower_of_london.csv"),
  tar_target(config, read_csv(file_config, col_types = cols())),
  tar_target(graph, create_graph(config)),
  tar_target(item_bank, create_bank(graph)),
  tar_file(
    file_items, {
      filename <- "result/items.xlsx"
      writexl::write_xlsx(item_bank, filename)
      filename
    }
  )
)
