#' Create item bank
#'
#' @title
#' @param graph
create_bank <- function(graph) {
  nodes <- names(V(graph))
  expand_grid(from = nodes, to = nodes) |>
    mutate(
      min_move = map2_dbl(from, to, distances, graph = graph),
      path_type = map2_chr(
        from, to,
        ~ graph |>
          all_shortest_paths(.x, .y) |>
          pluck("res") |>
          parse_path_type()
      )
    ) |>
    group_by(min_move) |>
    mutate(type = dense_rank(path_type), .keep = "unused") |>
    ungroup() |>
    mutate(across(c(from, to), parse_number))
}

parse_path_type <- function(paths) {
  path_parsed <- map_chr(
    paths,
    ~ str_c(parse_number(names(.x)) %% 10, collapse = "-")
  )
  str_c(sort(path_parsed), collapse = "_")
}
