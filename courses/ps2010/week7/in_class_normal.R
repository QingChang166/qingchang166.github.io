# To random draw from a standard normal distribution

x <- rnorm(1)

# To calculate probability density, we use

pd <- dnorm(x)

# To calculate the cumulative density or probability

p <- pnorm(x)

# Find the value of x corresponding to a specified probability

x <- qnorm(0.6, 2, 1.5)

# Example 1

1 - pnorm(1.24)
