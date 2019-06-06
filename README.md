# fb2ga
Tools for easily transferring FB advertising data to Google Analytics

With the accompanying article, this package contains a couple of useful functions for pulling advertising data from Facebook, formatting it, then uploading it as an additional data set to Google Analytics, minimizing the amount of manual work you have to do, and increasing your ability to understand the performance of your Facebook marketing campaigns.

**Install this package in R**

To install this package, you will need Devtools. If you don't already have Devtools, run this:

```r
install.packages('devtools')

```

Then to install this package, run the following command:

```r
library(devtools)

install_github('neugelb/fb2ga')
```

**Create a campaign URL**

Here's a quick and easy way to decorate a campaign URL with the appropriate UTM codes:

```r

source <- 'facebook'
medium <- 'cpc'
campaign_name <- 'test_campaign_1'

url <- campaign_url('https://yoursite.de', source, medium, campaign_name)

#"https://yoursite.de/?utm_source=facebook&utm_medium=cpc&utm_campaign=test_campaign_1"
```

**Get your Facebook Ads data**

Here would be an example if you wanted to get the Facebook ads data for March 2019

```r

ad_account <- 'YOUR ACCOUNT HERE'
fb_token <- 'YOUR FB TOKEN HERE'
start <- '2019-03-01'
end <- '2019-03-31'

fb_ads <- fbads_builder(ad_account_id,fb_token,start,end)
```

**Format your data for upload**

Next you need to format your data for upload to GA, like this:

```r
#make sure that medium and source are the same as the values originally set in your marketing campaign

fb_ads2 <- fb_ads_ga_format(fb_ads,medium,source)
```

**Upload to Google Analytics**

The last step!

```r

#if you don't remember your dataset ID, just the name:
fb_ads_ga_upload(fb_ads2,property_id,dataset_id=NULL,dataset_name='FB Cost Data')

#if you have your dataset ID

datasetid <- 'Your Dataset ID from GA'

fb_ads_ga_upload(fb_ads2,property_id,dataset_id=datasetid)
```

Interested in help with your data? Get in youch at randall@neugelb.com
