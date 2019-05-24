#' tidycols
#'
#' An easy function for cleaning up column names
#' @param df Your data frame
#' @export

tidycols <- function(df) {
  require(snakecase)

  dfnames <- colnames(df)

  dfnames <- to_snake_case(dfnames,sep_out = "_")

  dfnames <- tolower(gsub(" ","_",dfnames))

  dfnames <- gsub(".","_",dfnames,fixed=TRUE)

  dfnames <- gsub("/","_per_",dfnames,fixed=TRUE)

  colnames(df) <- dfnames

  return(df)
}
