require(scoreActivity)
Test_Statements <- score_set(
  check_exists(Auto),
  check(TRUE, is.character(auto_file_name)),
  check_exists(task3),
  check(TRUE, "package:ISLR" %in% search()),
  check(5, nrow(task5top)),
  check(3, ncol(task5top)),
  check(5, nrow(task5bottom)),
  check(3, ncol(task5bottom)),
  check(TRUE, task5top[5,3] == Auto[5,3]),
  check(TRUE, task5bottom[5,3] == Auto[nrow(Auto),ncol(Auto)])
)
print_test_results(Test_Statements)
