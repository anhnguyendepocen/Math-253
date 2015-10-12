require(scoreActivity)
Test_Statements <- score_set(
  check(TRUE, "package:mosaic" %in% search()),
  check(TRUE, is.character(task2)),
  check(TRUE, grepl("^Today is",task2) && grepl("201.$", task2)),
  check(TRUE, all(task3a %in% names(mosaicData::Galton))),
  check(nrow(mosaicData::Galton), task3b),
  check(about(mean(mosaicData::Galton$height)), task3c),
  check(TRUE, all(dim(task4) == c(2,3))),
  check(TRUE, max(task5x) <= 1 && min(task5x) >= 0),
  check(TRUE, max(task5y) <= 1 && min(task5y) >= 0),
  check(about(pi, pm=.5), task5pi),
  leave_out_names = c("mosaicData", "height")
)
print_test_results(Test_Statements)
