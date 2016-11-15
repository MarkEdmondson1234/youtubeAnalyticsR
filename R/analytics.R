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
#' Set \code{options(googleAuthR.scopes.selected = c(https://www.googleapis.com/auth/youtube, https://www.googleapis.com/auth/youtube.readonly, https://www.googleapis.com/auth/yt-analytics-monetary.readonly, https://www.googleapis.com/auth/yt-analytics.readonly)}
#' Then run \code{googleAuthR::gar_auth()} to authenticate.
#' See \code{\link[googleAuthR]{gar_auth}} for details.
#'
#' @param ids Identifies the YouTube channel or content owner for which you are retrieving YouTube Analytics data

#' @param start.date The start date for fetching YouTube Analytics data

#' @param end.date The end date for fetching YouTube Analytics data

#' @param metrics A comma-separated list of YouTube Analytics metrics, such as views or likes,dislikes

#' @param currency The currency to which financial metrics should be converted

#' @param dimensions A comma-separated list of YouTube Analytics dimensions, such as views or ageGroup,gender

#' @param filters A list of filters that should be applied when retrieving YouTube Analytics data

#' @param max.results The maximum number of rows to include in the response

#' @param sort A comma-separated list of dimensions or metrics that determine the sort order for YouTube Analytics data

#' @param start.index An index of the first entity to retrieve
#' @importFrom googleAuthR gar_api_generator
#' @export
yt_analytics <- function(ids,
                         start.date,
                         end.date,
                         metrics,
                         currency = NULL,
                         dimensions = NULL,
                         filters = NULL,
                         max.results = NULL,
                         sort = NULL,
                         start.index = NULL) {


  url <- "https://www.googleapis.com/youtube/analytics/v1/reports"

  pars <- list(currency = currency,
               dimensions = dimensions,
               `end-date` = end.date,
               filters = filters,
               ids = ids,
               `max-results` = max.results,
               metrics = metrics,
               sort = sort,
               `start-date` = start.date,
               `start-index` = start.index)

  pars <- rmNullObs(pars)
  # youtubeAnalytics.reports.query
  f <- gar_api_generator(url,
                         "GET",
                         pars_args = pars,
                         data_parse_function = function(x) x)

  f()


}



