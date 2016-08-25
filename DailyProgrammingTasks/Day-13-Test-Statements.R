library(scoreActivity)
library(mosaicData)
Test_Statements <- score_set(
  check_exists(k_fold1),
  check_exists(k_fold),
  check(TRUE, "method" %in% names(formals(k_fold1))),
  check(TRUE, "data" %in% names(formals(k_fold1))),
  check(about(8, pm=3), k_fold1(), pts=2),
  check(TRUE, "For_Testing" %in% all.names(body(k_fold1))),
  check(TRUE, "predfun" %in% all.names(body(k_fold))),
  check(TRUE, "method" %in% all.names(body(k_fold))),
  check(about(24, pm=4), k_fold(wage ~ age + sex, data=mosaicData::CPS85, k=10, predfun = predict, method = lm)),
  leave_out_names = c("wage", "age", "sex", "mosaicData")
)
print_test_results(Test_Statements)
