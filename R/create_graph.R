#' Create graph
#'
#' @title
#' @param config
create_graph <- function(config) {
  config |>
    filter(connected == 1) |>
    select(-connected) |>
    graph_from_data_frame(directed = FALSE)
}
