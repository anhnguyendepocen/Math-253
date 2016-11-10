library(scoreActivity)
library(mosaicData)
Test_Statements <- score_set(
  check_exists(compare_ols_ridge),
  check_exists(GenCont),
  check_exists(Shrink_results),
  check(TRUE, "responses" %in% names(formals(compare_ols_ridge))),
  check(TRUE, "predictors" %in% names(formals(compare_ols_ridge))),
  check(TRUE, "lambda" %in% names(formals(compare_ols_ridge))),
  check(TRUE, "ols_in" %in% names(Shrink_results)),
  check(TRUE, "ridge_out" %in% names(Shrink_results)),
  check(about(1, pm = .01), Shrink_results[["lambda"]]),
  check(about(3.5, pm = 1.5), Shrink_results[["ols_out"]])
)
print_test_results(Test_Statements)
