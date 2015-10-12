library(scoreActivity)
Test_Statements <- score_set(
  check_exists(A_inv),
  check_exists(W),
  check_exists(A_chol),
  check(TRUE, all(abs(diag(2) - A %*% A_inv) < .00001)),
  check(about(-0.7, pm=.0001), A[1,2]),
  check(TRUE, all(abs((t(A_chol) %*% A_chol - A)) < .01)),
  check(TRUE, nrow(X) == 10 && ncol(X) == 2),
  check(TRUE, all(abs(apply(W, FUN=mean, MARGIN=2)) < .02)),
  check(TRUE, all(abs(W_cov - t(W) %*% W / nrow(W)) < .01)),
  check(TRUE, all(abs(Y - W %*% A_chol) < 0.01)),
  leave_out_names = "default"
)
print_test_results(Test_Statements)
