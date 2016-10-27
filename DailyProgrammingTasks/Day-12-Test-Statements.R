library(scoreActivity)
Test_Statements <- score_set(
  check_exists(Red),
  check_exists(Green),
  check_exists(Blue),
  check(TRUE, all(names(Red) %in% c("x", "y", "class"))),
  check(TRUE, all(abs(apply(red, FUN=mean, MARGIN=2)-red_mean) < .5)),
  check(TRUE, all(table(Same_sigma$class) == c(n_cases, n_cases))),
  check_exists(mod_LDA_one),
  check_exists(mod_QDA_two),
  check_exists(test_QDA_one),
  check_exists(test_LDA_two),
  leave_out_names = c("")
)
print_test_results(Test_Statements)
