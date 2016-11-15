context("Authentication")

test_that("Can authentication", {

  auth <- yt_auth()

  expect_s3_class(auth, "Token")

})

context("Reports")

test_that("Can get a basic report", {

  ya <- yt_analytics("channel==MINE", start.date = "2016-09-01", end.date = "2016-10-01", metrics = "views")

  expect_equal(ya$kind, "youtubeAnalytics#resultTable")
})
