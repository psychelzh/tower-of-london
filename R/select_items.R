#' Select Items
#'
#' The selected all starts from configuration identifier ending with 5 (or say,
#' flat type). Tasks are selected from those with minimal moves from 4 to 7, and
#' 5 tasks for each type of move.
#'
#' @title
#' @param item_bank
#' @return
#' @author Liang Zhang
#' @export
select_items <- function(item_bank) {
  set.seed(1)
  item_bank |>
    filter(min_move %in% 4:7, from %% 10 == 5) |>
    group_nest(min_move, type) |>
    group_by(min_move) |>
    group_modify(
      ~ .x |>
        slice_sample(n = 4) |>
        transmute(
          tasks = map_chr(
            data,
            ~ .x |>
              mutate(task = str_glue("{from}-{to}")) |>
              pluck("task") |>
              str_c(collapse = ";")
          )
        )
    ) |>
    ungroup()
}
