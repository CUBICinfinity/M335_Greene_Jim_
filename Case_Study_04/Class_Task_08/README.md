=====
Vectors

   purr package is in tidyverse
   
   typeof(vector)
   
   length(vector)
   
   is.finite() is.infinite()  is.nan()
   
   

   --
   
   NA            # logical
#> [1] NA
NA_integer_   # integer
#> [1] NA
NA_real_      # double
#> [1] NA
NA_character_ # character
#> [1] NA

--

near(x, y, tol =  (tolerance))
near(sqrt(2) ^ 2, 2)

use col_types with as.<type>()

atomic vectors != lists

   is_* is better
   
   
  also, is_scalar_* is a thing
  
  runif() means random uniform
  
  tidyverse cycling of vectors must be explicit: tibble(x = 1:4, y = rep(1:2, 2))
  
  c(x = 1, y = 2, z = 4)
#> x y z 
#> 1 2 4
Or after the fact with purrr::set_names():

set_names(1:3, c("a", "b", "c"))

--

if x is 2d, x[1, ] selects the first row and all the columns, and x[, -1] selects all rows and all columns except the first.

--

str() structure, not"string"


USE $ to avoid "" in extracting from lists
a$a is = to a[["a"]]


attr(x, "greeting") <- "Hi!"
attr(x, "farewell") <- "Bye!"
attributes(x)
#> $greeting
#> [1] "Hi!"
#> 
#> $farewell
#> [1] "Bye!"

methods("as") have fun

getS3method("as.Date", "numeric")


lubridate::as_date_time()
if you hit a POSIXlt

=========
Pipes

in magrittr package

" I think you should reach for another tool when:

Your pipes are longer than (say) ten steps. In that case, create intermediate objects with meaningful names. That will make debugging easier, because you can more easily check the intermediate results, and it makes it easier to understand your code, because the variable names can help communicate intent.

You have multiple inputs or outputs. If there isn’t one primary object being transformed, but two or more objects being combined together, don’t use the pipe.

You are starting to think about a directed graph with a complex dependency structure. Pipes are fundamentally linear and expressing complex relationships with them will typically yield confusing code."

chapter conatins some more functions