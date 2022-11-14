library(tidyverse)

 x1 <- rnorm(100, 0,1)
 
 x2 <- rnorm(100, 0,1)
 
 x3 <- rnorm(100, 0,1)
 
 error <-  rnorm(100, 0, 0.25)

 y <- 0.3*x1 + 0.5*x2 + 0.8*x3 + error
 
 
 data <- data.frame(x1, x2, x3, y)
 
 # run regression using lm()

 
 m1 <- lm(y ~ x1 + x2 + x3, data= data)

 
 summary(m1)

 ################################################
#### Now, we begin to calculate OLS manually ####
################################################ 
 
 
# First, OLS estimates 
 
 
 X <- as.matrix(cbind(1, x1, x2, x3)) # Don't forget 1, the intercept column!!!!
 
 colnames(X)[1] <- "Intercept" 
 
 Y <- as.matrix(y)
 
 
 beta_hat = solve(t(X)%*%X)%*%t(X)%*%Y
 
 round(beta_hat, digits=5)

 
 # Second, calculate standard errors
 
 
 ## To do this, we need first calculate residuals
 
 
 res <- as.matrix(y - (X %*% beta_hat))

 summary(res)
 
 ## Define degree of freedom
 
 n = nrow(X)
 
 k = ncol(X)

 ## Calculate Variance-Covariance Matrix
 VCV = 1/(n-k) * as.numeric(t(res)%*%res) * solve(t(X)%*%X)

 ## Standard errors of the estimated coefficients
 SE = sqrt(diag(VCV))  
 
 SE

 
 ## t value for OLS estimate 
 
 t_value <- round(beta_hat/SE, digits = 5) 

 t_value
 
 ## Calculate p-value
 
 p_value <- 2*pt( abs(t_value), df = n-k, lower.tail = F)
 
 p_value

 ## Construct confidence interval 
 
 confint(m1)
 
 
 lower_CI <- beta_hat - qt(0.025, df = n-k, lower.tail = F)*SE
 
 upper_CI <- beta_hat + qt(0.025, df = n-k, lower.tail = F )*SE
 
 
 confidence_interval <- cbind(lower_CI, upper_CI)

 ## Residual standard error
 
 res_V <-  1/(n-k) * as.numeric(t(res)%*%res)

 res_SE <- sqrt(res_V)
 
 ## R square 
 
 total_variance <- sum((y-mean(y))^2)
 
 unexplained_variance <- as.numeric(t(res)%*%res)
 
 unexplained_variance_percent <- unexplained_variance/total_variance
 
 R_square <- 1 - unexplained_variance_percent

 R_square
 
 ## Adjusted R square
 
 R_square_adjust <-  1 - (1 - R_square)*(n-1)/(n-k)
 
 
## F statistic
 
explained_variance <-  total_variance - unexplained_variance
 
F_statistic <- (explained_variance/(k-1))/(unexplained_variance/(n-k))
 
F_p_value <- pf(F_statistic, k-1, n-k, lower.tail = F)

# Notice!!!!: statistical software uses "p-value: < 2.2e-16" automatically 
# for very small numbers. That's why our F_p_value differ from what R report.
 