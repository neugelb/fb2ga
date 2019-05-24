#' fb_ads_ga_upload
#'
#' Upload your data to GA
#' @param fb_df The formatted data frame of advertisting data from Facebook, ready to upload
#' @param ga_property_id Your web property ID from Facebook; it should be formatted something like 'UA-'
#' @param dataset_name The name of your dataset
#' @export

fb_ads_ga_upload <- function(fb_df,ga_property_id,dataset_name) {

  require(googleAnalyticsR)
  require(tidyverse)

  ga_auth()

  account <- ga_account_list() %>%
    tidycols() %>%
    filter(web_property_id == ga_property_id)

  prop_id <- account %>%
    pull(web_property_id)

  account_id <- account %>%
    pull(account_id)

  dataset_id <- ga_custom_datasource(account_id,prop_id) %>%
    filter(name == dataset_name) %>%
    pull(id)

  message <- ga_custom_upload_file(account_id,prop_id,dataset_id,fb_df)

  print(message)

}
