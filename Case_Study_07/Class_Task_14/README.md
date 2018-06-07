unlist() flattens vector into one line (vector)
OR
purrr::flatten_dbl() to get an error if they aren't doubles

paste(output, collapse = "")

"You might be generating a big data frame. Instead of sequentially rbind()ing in each iteration, save the output in a list, then use dplyr::bind_rows(output) to combine the output into a single data frame."

Takeaway: use complex result objects that you can combine at the end to speed things up.


map(data, function) makes a list.
map_lgl() makes a logical vector.
map_int() makes an integer vector.
map_dbl() makes a double vector.
map_chr()

you can add arguments for the functions as other arguments:
map_dbl(df, mean, trim = 0.5)


> str_locate_all("happy923jdms49happy230", "happy")
[[1]]
     start end
[1,]     1   5
[2,]    15  19

> stri_stats_latex("This is just some text. And 7+9=16")
    CharsWord CharsCmdEnvir    CharsWhite         Words 
           25             0             9             6 
         Cmds        Envirs 
            0             0

