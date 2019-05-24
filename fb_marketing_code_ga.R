library(fb2ga)

#get fb data

fb_ads <- fbads_builder(ad_account_id,fb_token,start_date,end_date)

#format for upload

fb_ads2 <- fb_ads_ga_format(fb_ads,medium,source)

#upload

fb_ads_ga_upload(fb_ads2,property_id,dataset_name)
