require(scoreActivity)
Test_Statements <- score_set(
  check(TRUE, "package:ISLR" %in% search()),
  check(TRUE, "Yield" %in% names(College)),
  check_exists(test_indices),
  check_exists(train_indices),
  check(TRUE, all(names(College) %in% names(Train_data))),
  check_exists(MSE_test),
  check(TRUE, MSE_train > 0),
  check(TRUE, inherits(Yield_mod1, "lm")),
  check_exists(fhat_train),
  check_exists(fhat_test)
)
print_test_results(Test_Statements)
