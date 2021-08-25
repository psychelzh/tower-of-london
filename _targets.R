library(targets)
library(tarchetypes)
purrr::walk(fs::dir_ls("R"), source)
tar_option_set(packages = c("tidyverse", "igraph"))
list(
  tar_file(file_config, "config/tower_of_london.csv"),
  tar_target(config, read_csv(file_config, col_types = cols())),
  tar_target(graph, create_graph(config)),
  tar_target(item_bank, create_bank(graph)),
  tar_file(file_item_bank, output_xlsx(item_bank, "results/item_bank.xlsx")),
  tar_qs(items_used, select_items(item_bank)),
  tar_file(file_items_used, output_xlsx(items_used, "results/items_used.xlsx"))
)
