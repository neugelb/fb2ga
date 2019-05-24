#' fb_ads_ga_format
#'
#' Format your FB ads data for upload to GA
#' @param fb_ads_df The data frame of advertisting data from Facebook
#' @param utm_medium The medium of the campaign, this should match the values you set in your UTM codes in the URLs in the Facebook ads
#' @param utm_source The source of the campaign, this should match the values you set in your UTM codes in the URLs in the Facebook ads
#' @export

fb_ads_ga_format <- function(fb_ads_df,utm_medium,utm_source) {

require(tidyverse)

df <- fb_ads_df %>%
  mutate(medium = utm_medium,
         source = utm_source) %>%
  rename(date = date_start,
         campaign = campaign_name,
         adCost = spend,
         adClicks = clicks) %>%
  select(date,medium,source,adClicks,adCost,impressions,campaign) %>%
  mutate(date = str_replace_all(date,'-',''))

fbcols <- names(df)
fbcols2 <- paste('ga:',fbcols,sep='')

colnames(df) <- fbcols2

return(df)

}
