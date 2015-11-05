library(scoreActivity)
library(mosaicData)
Test_Statements <- score_set(
  check_exists(X),
  check_exists(X_corr),
  check(about(1, pm=.2), sd(X_rand[])),
  check(TRUE, sd(Y_real) > sd(Y_pure)),
  check(TRUE, length(beta_hat_pure) %in% 191:192),
  check(TRUE, inherits(lasso_mod, "cv.glmnet") ),
  check(TRUE, sum(abs(beta_lasso) < 0.001) < 175),
  check(TRUE, n99 < 30),
  check(TRUE, n99_rand > 120),
  check(TRUE, n99_corr < 35),
  leave_out_names = c()
)
print_test_results(Test_Statements)
