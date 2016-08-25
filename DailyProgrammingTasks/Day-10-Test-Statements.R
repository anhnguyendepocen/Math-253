library(scoreActivity)
Test_Statements <- score_set(
  check_exists(Default),
  check_exists(logistic),
  check(about(0.5), logistic(0)),
  check(about(0.8807, pm=0.01), logistic(2)),
  check(about(88724.25),
        linear_combine(data = Default, coef = c(intercept=1, income=2))[1]),
  check(TRUE, gives_error(linear_combine(data=Default, coef=c(intercept=1, whoopee = 2)))),
  check(TRUE, is.function(LL_logistic)),
  check(about(-2425.7), LL_logistic(data=Default, coefs = c(intercept = 1, income=-.0001), outcome = Default$default == "Yes")),
  check_exists(best_coefs),
  check(TRUE, "par" %in% names(best_coefs)),
  leave_out_names = "default"
)
print_test_results(Test_Statements)
