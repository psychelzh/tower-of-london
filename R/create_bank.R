#' Create item bank
#'
#' @title
#' @param graph
create_bank <- function(graph) {
  graph |>
    distances() |>
    as_tibble(rownames = "from") |>
    pivot_longer(-from, names_to = "to", values_to = "level") |>
    mutate(across(c(from, to), parse_number)) |>
    filter(from != to) |>
    mutate(
      type1_raw = (from %/% 10 - to %/% 10) %% 6,
      type1 = if_else(type1_raw > 3, 6 - type1_raw, type1_raw),
      type2 = paste0(from %% 10, to %% 10),
      type = paste(type1, type2, sep = "_"),
      time = level * 10
    ) |>
    group_by(level) |>
    mutate(type_id = dense_rank(type)) |>
    ungroup() |>
    arrange(level, type_id, type)
}
