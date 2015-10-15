require(scoreActivity)
Test_Statements <- score_set(
  check_exists(vals),
  check(TRUE, min(vals) >= 0),
  check(TRUE, test200 < -20),
  check_exists(LL_exp),
  check(about(sum(log(dexp(vals,rate=1/200)))), LL_exp(rate=1/200), pts=2),
  check(TRUE, max(rates) >= 1/80),
  check_exists(exp_results),
  check(TRUE, "objective" %in% names(exp_results) ),
  check(TRUE, "maximum" %in% names(exp_results))
)
print_test_results(Test_Statements)
