library(scoreActivity)
Test_Statements <- score_set(
  check_exists(n_cases),
  check_exists(n_predictors),
  check(TRUE, "package:e1071" %in% search(), pts = 8),
  leave_out_names = c("wage", "age", "sex", "mosaicData")
)
print_test_results(Test_Statements)
