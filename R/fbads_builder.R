#' fbads_builder
#'
#' Download Facebook ad data
#' @param ad_account The Facebook ad account ID
#' @param token The Facebook app token, generated in the Facebook developer portal
#' @param start_date The first date you want data for
#' @param end_date The last date you want data for
#' @export

fbads_builder <- function(ad_account_id,token,start_date,end_date) {

require(jsonlite)
require(tidyverse)
require(fbRads)
require(lubridate)

init <- fbad_init(ad_account_id,token,'3.2')

date_range <- as.character(seq.Date(as_date(start_date),as_date(end_date),by='day'))

time_ranges <- ''

for (i in 1:length(date_range)) {

  new_date <- paste0("{'since':'",date_range[i],"','until':'",date_range[i],"'}")

  time_ranges <- c(time_ranges,new_date)
}

time_ranges <- time_ranges[-1]

insights_tbl <- tibble()

for (i in 1:length(time_ranges)) {

insights <- fb_insights(level='ad',
            time_range = time_ranges[i],
            fields = toJSON(c('account_name',
                                        'campaign_name',
                                        'adset_name',
                                        'ad_name',
                                        'reach',
                                        'frequency',
                                        'impressions',
                                        'clicks',
                                        'unique_clicks',
                                        'spend',
                                        'actions',
                                        'action_values'
            )
            ),
            action_attribution_windows="1d_click")

if (length(insights) == 0) {

  next

} else {

campaign_names <- insights[[1]]$campaign_name

actions <- insights[[1]]$actions

action_tbl <- tibble()

for (i in 1:length(actions)) {

  a2 <- as_tibble(actions[[i]])

  a2 <- a2 %>%
    select(-3) %>%
    filter(!action_type %in% c('page_engagement','post'))

  col_names <- a2 %>%
    pull(action_type)

  a2 <- as_tibble(t(a2)) %>%
    slice(2)

  colnames(a2) <- col_names

  a2 <- a2 %>%
    mutate(campaign_name = campaign_names[i])

  action_tbl <- bind_rows(action_tbl,a2)

}

new_action <- as_tibble(insights[[1]]) %>%
  select(-actions) %>%
  full_join(action_tbl,by='campaign_name')

insights_tbl <- bind_rows(insights_tbl,new_action)

}

}

numcols <- c('reach','frequency','impressions','clicks','unique_clicks','spend','comment','link_click','post_reaction','post_engagement')

insights_tbl <- insights_tbl %>%
  mutate_at(numcols,funs(as.numeric(.))) %>%
  mutate(ctr = clicks / impressions,
         cpc = spend / clicks)

return(insights_tbl)

}
