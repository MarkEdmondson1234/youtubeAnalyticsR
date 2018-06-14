.onAttach <- function(libname, pkgname){

  attempt <- try(googleAuthR::gar_attach_auto_auth(c("https://www.googleapis.com/auth/youtube",
                                                     "https://www.googleapis.com/auth/youtube.readonly",
                                                     "https://www.googleapis.com/auth/yt-analytics-monetary.readonly",
                                                     "https://www.googleapis.com/auth/yt-analytics.readonly"),
                                                   environment_var = "YT_AUTH_FILE"))
  if(inherits(attempt, "try-error")){
    warning("Tried to auto-authenticate but failed.")
  }


  invisible()

}
