require(scoreActivity)
Test_Statements <- score_set(
  check(TRUE, "package:mosaicData" %in% search()),
  check_exists(bin_counts),
  check(1, length(nbins)),
  check(nbins+1, length(evenly_spaced)),
  check(TRUE, all(abs(diff(diff(evenly_spaced))) < .1)),
  check(nbins, length(bin_counts)),
  check_exists(hist_basics),
  check(TRUE, all(c("xL", "xR", "count") %in% names(hist_basics)), pts=2),
  check_exists(make_one_bar)
)
print_test_results(Test_Statements)
