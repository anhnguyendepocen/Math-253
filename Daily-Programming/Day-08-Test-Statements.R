require(scoreActivity)
Test_Statements <- score_set(
  check_exists(My_data),
  check(TRUE, max(My_data$x) <= 70),
  check_exists(LL_line),
  check(TRUE, LL_line(c(m=3,b=5,sigma=2)) > LL_line(c(m=2,b=1,sigma=10)), pts=3),
  check_exists(Taxi_trips),
  check_exists(taxi_likelihood),
  check_exists(best),
  check(TRUE, "par" %in% names(best)),
  leave_out_names = "x"
)
print_test_results(Test_Statements)
