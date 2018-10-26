#' Retrieve your YouTube Analytics reports.
#'
#'
#' @seealso \href{http://developers.google.com/youtube/analytics/}{Google Documentation}
#'
#' @details
#' Authentication scopes used by this function are:
#' \itemize{
#'   \item https://www.googleapis.com/auth/youtube
#' \item https://www.googleapis.com/auth/youtube.readonly
#' \item https://www.googleapis.com/auth/yt-analytics-monetary.readonly
#' \item https://www.googleapis.com/auth/yt-analytics.readonly
#' }
#'
#' Look up possible metrics and dimensions here:
#' \href{https://developers.google.com/youtube/analytics/v1/channel_reports#video-reports}{metric and dimension reference}
#'
#'
#' @param id Identifies the YouTube channel or content owner for which you are retrieving YouTube Analytics data
#' @param type channel or contentOwner
#' @param start.date The start date for fetching YouTube Analytics data
#' @param end.date The end date for fetching YouTube Analytics data

#' @param metrics A character vector of YouTube metrics, such as \code{c("views","likes","dislikes")}

#' @param currency The currency to which financial metrics should be converted

#' @param dimensions A comma-separated list of YouTube Analytics dimensions, such as views or ageGroup,gender

#' @param filters A list of filters that should be applied when retrieving YouTube Analytics data

#' @param max.results The maximum number of rows to include in the response

#' @param sort A comma-separated list of dimensions or metrics that determine the sort order for YouTube Analytics data

#' @param start.index An index of the first entity to retrieve
#'
#'
#' @importFrom googleAuthR gar_api_generator
#' @export
yt_analytics <- function(id,
                         type = c("channel","contentOwner"),
                         start.date,
                         end.date,
                         metrics,
                         currency = NULL,
                         dimensions = NULL,
                         filters = NULL,
                         max.results = NULL,
                         sort = NULL,
                         start.index = NULL) {

  type <-  match.arg(type)

  start.date <- as.character(as.Date(start.date))
  end.date <- as.character(as.Date(end.date))

  url <- "https://youtubeanalytics.googleapis.com/v2/reports"

  pars <- list(currency = currency,
               dimensions = dimensions,
               endDate = end.date,
               filters = filters,
               ids = paste0(type,"==", id),
               maxResults = max.results,
               metrics = paste(metrics, collapse = ","),
               sort = sort,
               startDate = start.date,
               startIndex = start.index)

  pars <- rmNullObs(pars)
  # youtubeAnalytics.reports.query
  f <- gar_api_generator(url,
                         "GET",
                         pars_args = pars,
                         data_parse_function = analytics_parse)

  f()


}


analytics_parse <- function(x){

  stopifnot(x$kind == "youtubeAnalytics#resultTable")

  if(!is.null(x$rows)){
    out <- as.data.frame(x$rows, stringsAsFactors = FALSE)
    names(out) <- x$columnHeaders$name

    metrics <- x$columnHeaders$name[x$columnHeaders$columnType == "METRIC"]
    dims <- x$columnHeaders$name[x$columnHeaders$columnType != "METRIC"]
    metric_df <- as.data.frame(lapply(out[,metrics, drop = FALSE], as.numeric))
    dimension_df <- out[,dims, drop = FALSE]

    binded <- cbind(dimension_df, metric_df)
    if("day" %in% names(binded)){
      binded$day <- as.Date(binded$day)
      binded <- binded[order(binded$day),]
    }

  } else {
    message("No data found")
    binded <- NULL
  }

  binded

}

