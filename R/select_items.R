#' Select Items
#'
#' The selected all starts from configuration identifier ending with 1. Tasks
#' are selected from those with minimal moves from 3 to 7, and 4 tasks for each
#' type of move.
#'
#' @title
#' @param item_bank
#' @return
#' @author Liang Zhang
#' @export
select_items <- function(item_bank) {
  set.seed(1)
  item_bank |>
    filter(min_move %in% 3:7, from %% 10 == 1, type1 != 0) |>
    group_nest(min_move, type_id) |>
    group_by(min_move) |>
    slice_sample(n = 4) |>
    ungroup() |>
    mutate(data = map(data, slice_sample, n = 1)) |>
    unnest(data)
}
