#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title
#' @param data
#' @param file
#' @return
#' @author Liang Zhang
#' @export
output_xlsx <- function(data, path) {
  writexl::write_xlsx(data, path)
  path
}
