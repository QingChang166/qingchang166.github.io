

# we want to know Inequality_i = \beta_0 + \beta_1 Democracy + \beta_2 Trade + \beta_3 FDI + \epsilon_i

# run regression using lm()


m1 <- lm(inequality ~ trade + fdi + democracy, data= example_data)


summary(m1)

################################################
#### Now, we begin to calculate OLS manually ####
################################################

#

# First, OLS estimates


X <- as.matrix(cbind(1, example_data[ , 2:4])) # Don't forget 1, the intercept column!!!!

colnames(X)[1] <- "Intercept"

Y <- as.matrix(example_data$inequality)


beta_hat = solve(t(X)%*%X)%*%t(X)%*%Y

round(beta_hat, digits=5)


# Second, calculate standard errors


## To do this, we need first calculate residuals


res <- as.matrix(Y - (X %*% beta_hat))

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

confidence_interval
## Residual standard error

res_V <-  1/(n-k) * as.numeric(t(res)%*%res)

res_SE <- sqrt(res_V)

res_SE
## R square

total_variance <- sum((Y-mean(Y))^2)

unexplained_variance <- as.numeric(t(res)%*%res)

unexplained_variance_percent <- unexplained_variance/total_variance

R_square <- 1 - unexplained_variance_percent

R_square

## Adjusted R square

R_square_adjust <-  1 - (1 - R_square)*(n-1)/(n-k)

R_square_adjust
## F statistic

explained_variance <-  total_variance - unexplained_variance

F_statistic <- (explained_variance/(k-1))/(unexplained_variance/(n-k))

F_statistic

F_p_value <- pf(F_statistic, k-1, n-k, lower.tail = F)

F_p_value

# Notice!!!!: statistical software uses "p-value: < 2.2e-16" automatically
# for very small numbers. That's why our F_p_value differ from what R report.
