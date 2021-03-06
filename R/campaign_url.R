#' campaign_url
#'
#' Format your URL with UTM tracking codes
#' @param url The URL you want to adorn
#' @param source The source of the campaign, typically would be something like 'facebook' or 'adwords'
#' @param medium The medium of the campaign, i.e. what type of campaign this is, usually would be something like 'cpc' or 'paid_social' (optional)
#' @param campaign_name The name of your campaign (optional)
#' @export

campaign_url <- function(url,source,medium,campaign_name=NULL) {

  require(purrr)

final_url <- paste(url,'/?utm_source=',source,'&utm_medium=',medium,sep='')


if (is_empty(campaign_name)== FALSE) {

  final_url <- paste(final_url,'&utm_campaign=',campaign_name,sep='')

  }

return(final_url)

}
