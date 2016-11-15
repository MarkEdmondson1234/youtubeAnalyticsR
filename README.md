# youtubeAnalyticsR
![](https://www.google.com/images/icons/product/youtube-32.png)
YouTube Analytics API R library

Retrieves your YouTube Analytics data.
This is an R package autogenerated via [googleAuthR](http://code.markedmondson.me/googleAuthR)'s Discovery API builder. 
The Google Documentation for this API is [here](http://developers.google.com/youtube/analytics/).

## Setup

1. Get a Google Project
2. Activate the YouTube API in your google project.
3. Get the OAuth2 client ID and secret (see GoogleAuthR readme for details)
4. Set options `options(googleAuthR.client_id = XXX)` and `options(googleAuthR.client_secret = XXX)`
5. Load the library
6. Run `yt_auth()` and authenticate with your user
7. Run `yt_analytics()` to get data

Work in progress, any requests please file a Github issue. 

```r
options(googleAuthR.client_id = XXX)
options(googleAuthR.client_secret = XXX)

library(youtubeAnalyticsR)

## authenticate with a user who has access to the YouTube channel you want to analyse
yt_auth()

## get the unique ID of your YouTube Channel
## Dimensions and metrics are here: https://developers.google.com/youtube/analytics/v1/channel_reports#video-reports
ya <- yt_analytics("UCvcKAjtJAzVr0vgLNR5w7Fg", 
                  start.date = "2016-09-01", end.date = "2016-10-01", 
                  metrics = "views,comments,likes,dislikes", dimensions = "day")
ya
#          day views comments likes dislikes
#1  2016-09-23    49        0     1        0
#2  2016-09-26    91        1     0        0
#3  2016-09-13    10        0     3        0
#4  2016-09-18    42        0     3        0
#5  2016-09-30    10        1     1        0
```
