test_dir <- "/Users/kaplan/Dropbox/Courses-Fall-2015/Math-253/Daily-Programming"

# Day 1
moodle_dir <- "/Users/kaplan/Downloads/MATH-253-01-Thurs Sept 3-19724"
test_file <- "Day-01-Test-Statements.R"
Both <- grade_moodle(moodle_dir, test_dir, test_file)
names(Both)[2] <- "Day01"

# Day 2
moodle_dir <- "/Users/kaplan/Downloads/MATH-253-01-Tuesday September 8-19725"
test_file <- "Day-02-Test-Statements.R"
Two <- grade_moodle(moodle_dir, test_dir, test_file)
names(Two)[2] <- "Day02"
Both <- full_join(Both, Two, by = "student_names")

# Day 3
moodle_dir <- "/Users/kaplan/Downloads/MATH-253-01-Thurs Sep 10-19726"
test_file <- "Day-03-Test-Statements.R"
Two <- grade_moodle(moodle_dir, test_dir, test_file)
names(Two)[2] <- "Day03"
Both <- full_join(Both, Two, by = "student_names")

# Day 4
# No activity handed in.  See Day 5

# Day 5
moodle_dir <- "/Users/kaplan/Downloads/MATH-253-01-Thurs Sept 17-19730"
test_file <- "Day-05-Test-Statements.R"
Two <- grade_moodle(moodle_dir, test_dir, test_file)
names(Two)[2] <- "Day05"
Both <- full_join(Both, Two, by = "student_names")



# Day 6
moodle_dir <- "/Users/kaplan/Downloads/MATH-253-01-Tues September 22-19731"
test_file <- "Day-06-Test-Statements.R"
Two <- grade_moodle(moodle_dir, test_dir, test_file)
names(Two)[2] <- "Day06"
Both <- full_join(Both, Two, by = "student_names")


# Day 7
moodle_dir <- "/Users/kaplan/Downloads/MATH-253-01-Thurs Sept 24 Exponential likelihoods-19733"
test_file <- "Day-07-Test-Statements.R"
Two <- grade_moodle(moodle_dir, test_dir, test_file)
names(Two)[2] <- "Day07"
Both <- full_join(Both, Two, by = "student_names")

# Day 8
moodle_dir <- "/Users/kaplan/Downloads/MATH-253-01-Tues September 29 Taxis-19734"
test_file <- "Day-08-Test-Statements.R"
Two <- grade_moodle(moodle_dir, test_dir, test_file)
names(Two)[2] <- "Day08"
Both <- full_join(Both, Two, by = "student_names")

# Day 9
moodle_dir <- "/Users/kaplan/Downloads/MATH-253-01-Thurs Oct 1 Poker-19735"
test_file <- "Day-09-Test-Statements.R"
Two <- grade_moodle(moodle_dir, test_dir, test_file)
names(Two)[2] <- "Day09"
Both <- full_join(Both, Two, by = "student_names")

# Day 10
moodle_dir <- ""


# Day 11
moodle_dir <- "/Users/kaplan/Downloads/MATH-253-01-Thurs Oct 8 Multivariate Gaussians-28096"
test_file <- "Day-11-Test-Statements.R"
Two <- grade_moodle(moodle_dir, test_dir, test_file)
names(Two)[2] <- "Day11"
Both <- full_join(Both, Two, by = "student_names")
