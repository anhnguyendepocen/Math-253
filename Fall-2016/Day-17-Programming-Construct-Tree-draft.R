# Split points

Write a function `running_mean()` : GIVE 1:11 as the example. Hint: `cumsum()`
```{r}
running_mean <- function(x) {
  cumsum(x)/(1:length(x))
}
```

Write a function `best_split_cont(x, y)`: Test with 
```{r eval=FALSE}
vals <- sample(1:10)
best_regress_split_cont(vals, vals)
```

```{r echo = params$show_answers}
best_regress_split_cont <- function(x, y) {
  n <- length(x)
  inds <- order(x)
  xx <- x[inds]
  yy <- y[inds] - mean(y)
  meansL <- running_mean(yy)
  meansR <- rev(running_mean(rev(yy)))
  left_end <- 1:(n-1)
  SS <- left_end * meansL[left_end]^2 + (n-left_end)*meansR[left_end+1]^2
  x_unique_inds <- which( ! duplicated(xx, fromLast = TRUE))
  SS_unique <- SS[x_unique_inds]
  best <- which.max(SS_unique)
  list(x = xx[x_unique_inds][best + 1], score = SS_unique[best])
}
```

```{r echo = params$show_answers}
best_regress_split_categorical <- function(x, y) {
  levels <- unique(x <- as.character(x))
  # handle 1 or 2 groups
  y <- y - mean(y)
  if (length(levels) == 1) return(list(x = levels, score = 0))
  if (length(levels) == 2) {
    return(list(x = levels[1], 
                score = sum(mosaic::mean(y ~ x)^2 * table(x))))
  }
  # more than 2 groups
  # is there a single group we can split off?
  best_score <- 0
  best_level <- levels[1] # anything goes if they are all the same
  for (k in 1:length(levels)) {
    right <- mean(y[x != levels[k]])
    left <- mean(y[x == levels[k]])
    SS <- sum(x!=levels[k]) * right^2 +
      sum(x==levels[k]) * left^2
    if (best_score < SS) {
      best_score <- SS
      best_level <- levels[k]
    }
  }
  return(list(x=best_level, score = best_score))
}
```

```{r}
choose_best_var_cont <- function(res_name, pnames, data) {
  best_score <- -Inf
  best_var <- NULL
  best_criterion <- NULL
  y <- data[[res_name]]
  for (var in pnames) {
    if (inherits(data[[var]], "numeric")) {
      res <- best_regress_split_cont(data[[var]], y)
      split_criterion <- paste0(var, " < ", res$x)
    } else {
      res <- best_regress_split_categorical(data[[var]], y)
      split_criterion <- paste0(var, " == '", res$x, "'")
    }
    if (res$score > best_score) {
      best_score <- res$score
      best_var <- var
      best_criterion <- split_criterion
    }
  }
  
  return(list(score=best_score, 
              var=best_var, 
              split_fun = parse(text = best_criterion)))
}
```

```{r}
fit_tree_helper <- function(response, predictors, data) {
  if (nrow(data) < 5) return(list(val = mean(data[[response]]),
                                  sd = ifelse(nrow(data) < 2, 0, sd(data[[response]])),
                                  n = nrow(data)))
  else {
    # find the best variable for splitting
    res <- choose_best_var_cont(response, predictors, data = data)
    res$val=mean(data[[response]])
    res$sd = sd(data[[response]])
    res$n = nrow(data)
    for_left <- with(data, eval(res$split_fun))
    if( sum(for_left) == 0 ) stop("shouldn't get here.")
    Left_data <- subset(data, for_left)
    Right_data <- subset(data, ! for_left)
    left <- fit_tree_helper(response, predictors, Left_data)
    right <- fit_tree_helper(response, predictors, Right_data)
    pooled_sd <- sqrt(left$sd^2/left$n + right$sd^2 / right$n)
    res$t <- (left$val - right$val) /  pooled_sd
    if( abs(res$t) > qt(.975, res$n - 2)) {
      res$left <- left
      res$right <- right
    }
    
  }
  return(res)
} 
```

```{r}
fit_tree <- function(formula, data = parent.frame()) {
  response <- as.character(formula[[2]])
  predictors <- all.vars(formula[[3]])
  fit_tree_helper(response, predictors, data = data)
}
```

```{r echo=FALSE, eval=params$show_answers, results="asis"}
cat("# Test statments")
```


```{r echo=params$show_answers, eval=params$show_answers}
source("Day-17-Test-Statements.R", local = TRUE)
```
