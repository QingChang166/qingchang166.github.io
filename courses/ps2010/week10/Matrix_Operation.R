# set up a matrix

a1 <- c(3, 2, 8)
a2 <- c(6, 3, 2)
a3 <- c(5, 2, 4)


A <-as.matrix(rbind(a1, a2, a3))

# For matrix A, do transpose

trans_A <- t(A)


print(A)
print(trans_A)


# For matrix A, do matrix inverse

inverse_A <- solve(A)


print(A)
print(inverse_A)


# the determine of A

det_A <- det(A)
