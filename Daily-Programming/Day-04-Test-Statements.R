require(scoreActivity)
Test_Statements <- score_set(
  check_exists(x1),
  check_exists(y1),
  check(TRUE, diff(range(x1)) == diff(range(y1))),
  check(5, length(x2)),
  check_exists(x3),
  check(about(50, pm=1), mean(x3)),
  check(about(60, pm=1), mean(y3)),
  check(about(40), diff(range(x3))),
  check_exists(x4),
  check_exists(y4)
)
print_test_results(Test_Statements)
