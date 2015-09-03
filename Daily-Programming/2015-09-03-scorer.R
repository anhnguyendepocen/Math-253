# package this into a function that takes the statements as arguments.


solution <- new.env()
source("2015-09-03-solution.R", local = solution)

# Should be the student's file
source("2015-09-03-solution.R") 

matches <- function(task_name, point_value = 1) {
  # handle no quotes gracefully  
  task_name <- as.character(substitute(task_name))
  
  if(exists(task_name) && 
     get(task_name) == get(task_name, env = solution) )
    return(point_value)
  else return(0)
}
# =================
in_range <- function(task_name, low, high, point_value=1) {
  # handle no quotes gracefully  
  task_name <- as.character(substitute(task_name))
  
  if (exists(task_name)) {
    val <- get(task_name)
    if( val >= low && val <= high) return(point_value)
  } 
  return(0)
}
# =================
is_similar <- function(task_name, ..., point_value=1) {
  # ... are the boolean criteria for being similar
  # the object is referred to as 'val' in the criteria
  # handle no quotes gracefully  
  task_name <- as.character(substitute(task_name))
  

  if (exists(task_name)) val <- get(task_name)
  else return(0)
  
  dots <- lazyeval::lazy_dots(...)
  for (k in length(dots)) {
    if ( ! eval(dots[[k]]$expr)) return(0) # fails if any fails
  }
  
  return(point_value)
}
# =================
score <- 0

if(exists("Galton", envir=student)) score <- score + 1
for (task in c("task2", "task3a", "task3b", "task3c", 
               "task4", "task5x", "task5y")) {
  score <- score + matches("task2")
}

score <- score + in_range(task5pi, 
                          low = pi - 0.6, 
                          high = pi + 0.6)

score <- score + is_similar("task5x", 
                            max(val) <= 1, 
                            min(val) >= 0, 
                            length(val)==1000)
