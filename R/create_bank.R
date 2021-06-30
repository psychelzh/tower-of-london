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
      pattern_id1 = (from %/% 10 - to %/% 10) %% 6,
      pattern_id2 = paste0(from %% 10, to %% 10),
      pattern_id = paste(pattern_id1, pattern_id2, sep = "_"),
      time = level * 10,
      stay = (level * 100 + time * 10) * 0.8,
      promotion = (level * 100 + time * 10) * 0.9
    ) |>
    group_by(level) |>
    mutate(type = dense_rank(pattern_id)) |>
    ungroup() |>
    select(from, to, level, type, time, stay, promotion) |>
    arrange(level, type)
}
