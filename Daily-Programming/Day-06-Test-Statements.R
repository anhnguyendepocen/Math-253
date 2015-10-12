require(scoreActivity)
Test_Statements <- score_set(
  check_exists(myHistogram),
  check(TRUE, "fill" %in% names(formals(myHistogram))),
  check(TRUE, "dnorm" %in% all.names(body(myHistogram))),
  check_exists(plotdensity),
  check(TRUE, "v" %in% all.names(body(plotdensity))),
  check(TRUE, is.data.frame(plotdensity(1:100))),
  check(TRUE, all(c("x", "density") %in% names(plotdensity(1:100))), pts=2),
  check(TRUE, "invisible" %in% all.names(body(plotdensity))),
  check(TRUE, "xlim" %in% names(formals(plotdensity)))
)
print_test_results(Test_Statements)
