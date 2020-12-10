# Useful Codes

nums <- rnorm(1000)
z <- rep(NA, 1000)
x <- sample(c(nums, z), 40)

# Returns a vector with all the NAs removed
y <- x[!is.na(x)]

# Extracts the positive values
x[!is.na(x) & x > 0]

rep(c(2, 3, 4), times = 2, each = 2, length.out = 10)
#[1] 2 2 3 3 4 4 2 2 3 3