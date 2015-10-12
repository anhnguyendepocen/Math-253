require(scoreActivity)
Test_Statements <- score_set(
  check(TRUE, is.function(ranks)),
  check(TRUE, is.function(suits)),
  check(TRUE, is_pair(c(21,22,33,41,52))),
  check(FALSE, is_pair(c(21,31,41,51,62))),
  check(TRUE, is_flush(c(21,31,41,51,71))),
  check(TRUE, is_full_house(c(21,22,31,32,33))),
  check(FALSE, is_full_house(c(21,22,31,32,42))),
  check(TRUE, is_straight(c(21,31,42,52,62))),
  check(FALSE, is_straight_flush(c(21,31,42,52,62))),
  check(TRUE, is_straight_flush(c(21,31,41,51,61)))
)
print_test_results(Test_Statements)
