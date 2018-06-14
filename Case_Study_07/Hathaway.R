#' ---
#' output: 
#'   html_document:
#'     code_folding: hide
#'     keep_md: true
#' ---

#+ echo=FALSE
knitr::opts_chunk$set(echo = TRUE, message = FALSE)


#' # Case Study Counting the Savior
#' My code to tackle the distance between Savior names. My commenting structure allows me to build a notebook from this script ([see articles from r script](http://rmarkdown.rstudio.com/articles_report_from_r_script.html))
#' 

#' ## Libraries to load
#' 
library(pacman)
#devtools::install_github("thomasp85/patchwork")
p_load(tidyverse, stringi, patchwork, rio, ggrepel)
#library(zoo) # for function `na.locf()` however there is a tidyverse option http://tidyr.tidyverse.org/reference/fill.html



#' ## Notes and Setup
#' 
#' Find the average number of words between savior names in the book of mormon
#' Provide a few visualizations of savior name occurances accross books in the book of mormon.

#' Could do the following sequence
#' 1. Find longest savior name
#' 2. str_locate_all and add count column for word
#' 3. str_replace_all with "xfound[#}" where number is the savior name number from the list.
#' 4. repeat 1-3 with next savior name
#' 
#' 
#' ## Code
#' 

scriptures <- import("http://scriptures.nephi.org/downloads/lds-scriptures.csv.zip") %>% as.tibble()
bmnames <- import("https://byuistats.github.io/M335/data/BoM_SaviorNames.rds")

#' Create data for each book
bm <- scriptures %>% filter(volume_short_title == "BoM")
nt <- scriptures %>% filter(volume_short_title == "NT")

#' need to loop through largest to smallest savior names
bmnames <- bmnames %>% arrange(desc(nchar))

#' I added a column to have a key for each name
bmnames$word_label <- 1:nrow(bmnames)
#' I am going to alter text in this column.  I want to keep the original text in a seperate column
bm$scripture_sub <- bm$scripture_text


#' 
#' 
#' ## The simplest solution (using a for loop)
#' 
#' This solution uses a loop over the names.  It does not keep track of book, chapter, or verse where the split occurs. Need to make sure to only search for [full words](https://www.regular-expressions.info/wordboundaries.html)
#' 
#+ echo=FALSE
bm_text <- str_c(bm$scripture_text, collapse = " ")

for (i in seq_along(bmnames$name)){
  
  sname <- str_c("\\b",bmnames$name[i], "\\b")
  replace_name <- paste0("xfound_",i)
  #  bm_text %>% str_locate_all(sname)
  bm_text <- bm_text %>% str_replace_all(sname, replace_name)
  #  print(i)
} 

bm_count <- bm_text %>% str_split("xfound_[0-9]{1,3}") %>% .[[1]] %>% str_count()

#' 
#' Since the counts are in order over the Book of Mormon I can do a time series plot.
#' 
#' 

bm_plot1 <- tibble(count = bm_count, order = 1:length(bm_count))

p1 <- bm_plot1 %>%
  ggplot(aes(x = order, y = count)) +
  geom_point() +
  geom_smooth() + 
  theme_bw() + 
  labs(x = "Order of Savior name reference in Book of Mormon", y = "Number of words\nbefore reference")


p2 <- p1 + coord_cartesian(ylim = c(0, 1500))

p1 + p2 + plot_layout(ncol = 1, heights = c(1,2))

#'  
#' ## The detailed solution
#'  
#'  In my graphic I wanted to label the books and chapters and other relavent information.  The code below builds to a larger data set that allows me to answer additional quesitons like;
#'  
#'  - How many words are between a reference to a specific name of the savior?
#'  - Which book has the highest average?
#'  - What verses and chapters contain the longest stretch of words with no reference?
#'  
#'     
#' ### The Loop
#'     
#' 
#' For each name 
#' 1. find out how many times it occurs in each verse
#' 2. Add the counts of per verse as a column
#' 3. Replace the name with a key to the specific name

#' So I end up with a column for each savior name key that has a count for each verse.  Then I create two new columns after the for loop finishes.  I include a print(i) statement to get a picture of how fast it is going.

#' - `count_name` is the number of times a Savior name reference is used in a verse.
#' - `cum_name` is the cumulative number of Savior name references that have been used by that versed.


#+ echo=FALSE
for (i in seq_along(bmnames$name)){
  
  sname <- bmnames$name[i] 
  replace_name <- paste0("xfound_",i)
  
  bm_locs <- bm$scripture_sub %>% 
    str_locate_all(sname) %>% 
    lapply(function(x) nrow(x)) %>%
    unlist()
  
  bm[,paste0("name_", i)] <- bm_locs
  
  bm$scripture_sub <- bm$scripture_sub %>% str_replace_all(sname, replace_name)
  #  print(i)
} 

bm$count_name <- apply(bm[,colnames(bm) %in% paste0("name_", 1:111)],1, sum)
bm$cum_name <- cumsum(bm$count_name)

#' The data now has 114 new columns added to the original scripture data.


#' 
#' ### The name verses
#' 
#' This next chunk of code creates a subset of the original BOM where only verses with savior names are kept. I used duplicated but count_name == 0 could have worked as well. Note the final mutate function that maps cum_name to order.  I am going to use order to merge to the split data.

bm_merge <- filter(bm, !duplicated(cum_name)) %>% 
  select(cum_name, book_id, chapter_id, verse_id, book_title, chapter_number, verse_number, verse_title, verse_short_title ) %>% 
  mutate(order = cum_name)


#' 
#' ### The splitting
#' 
#' The process to get the distances between savior name references.
#' 
#'  A. `str_c(collapse = " ")` the sentences into one long phrase and then str_split by "xfound[0-9]+"
#'  B. str_extract by same split to put the name at the end of the split phrase
#'  C. Apply word count to each split element

#' The full text of the book of mormon with with the substituted names
all_text <- str_c(bm$scripture_sub, collapse = " ")

#' The split text chunks
name_broke <- str_split(all_text, "xfound_[0-9]{1,3}")[[1]]
#' The keys for each split.  The key is the number id that maps back to the names data set.
names_label <- str_extract_all(all_text, "xfound_[0-9]{1,3}")[[1]]
names_label <- c(as.numeric(str_replace(names_label, "xfound_", "")), 9999)


# I have one more word after application than I did before.  Need to think about this.
#stri_stats_latex(all_text)
#length(names_label) + stri_stats_latex(name_broke)[["Words"]]


#' The Recombine into Tidy Data
#' 
#' Now create a data frame that has the order the name happened, the name key, and the text.
bm_split <- tibble(order = 1:length(names_label), word_label = parse_integer(names_label), scripture_text = name_broke)

#' This next line combines the names table into our bm_split dataset.
bm_split <- left_join(bm_split, bmnames) %>% 
  select(order, word_label, name, nchar, words, reference, Book, chapter_verse, scripture_text)

#' The next object goes line by line and counts the number of words in each split.
counts_split <- bm_split %>% 
  group_by(order) %>% 
  summarise(words_between = stri_stats_latex(scripture_text)["Words"]) %>%
  ungroup()

#' My previous summarise dropped information that I want in bm_split, so I am merging bm_split info back in.
bm_split <- left_join(counts_split, bm_split)

#' Here is the big line that creates the final data set. It is doing a few things.  I think I have the logic correct
#' 1. I rename a few columns about the first view.  Maybe I don't even need to keep these.
#' 2. Now the bm_merge left join will connect the verse reference to the verse were the split word occured.
#' 3. We will have some issues with verses with two references in the same verse so the `fill()` functions fills in the blanks.
#'     a. Sinse I have a cum count for each verse then if a line is missing information from the bm_merge data it should be replaced with the line that follows.  This only works due to how I formatted bm_merge and that we have order.
#'


bm_split <- bm_split %>% 
  rename(reference_first = reference, book_first = Book, chapter_verse_first = chapter_verse) %>% 
  left_join(bm_merge) %>% 
  fill(verse_short_title, verse_title, verse_number, chapter_number, book_title, .direction = "up")

# bm_split <- bm_split %>% 
#   rename(reference_first = reference, book_first = Book, chapter_verse_first = chapter_verse) %>% 
#   left_join(bm_merge) %>% 
#   mutate(verse_short_title = na.locf(verse_short_title, fromLast = TRUE, na.rm = FALSE),
#                                  verse_title = na.locf(verse_title, fromLast = TRUE, na.rm = FALSE),
#                                  verse_number = na.locf(verse_number, fromLast = TRUE, na.rm = FALSE),
#                                  chapter_number = na.locf(chapter_number, fromLast = TRUE, na.rm = FALSE),
#                                  book_title = na.locf(book_title, fromLast = TRUE, na.rm = FALSE)
#   )

#' The average.
mean(bm_split$words_between)

#' 
#' ### The Visualizations
#' 
#' This data set will allow me to draw the lines marking each book.
bm_counts_book <- bm %>% 
  group_by(book_id, book_title) %>% 
  summarise(word_count = stri_stats_latex(scripture_text)["Words"], cum_name = sum(count_name)) %>% ungroup() %>%
  mutate(cum_word_count = cumsum(word_count),
         cum_name_count = cumsum(cum_name))

#' We have a classic case of heavy right skew.  We will need to figure out how to show the big differences and the the predominate small distance patterns.  I have elected to show to graphs in my visualization.

base_plot <- bm_split %>% 
  ggplot(aes(x = order, y = words_between)) + 
  geom_point() + 
  geom_smooth(alpha = .1) + 
  geom_vline(data = bm_counts_book, aes(xintercept = cum_name_count), color = "skyblue", size = 1.1, lty = 2) +
  theme_bw()

full_plot <- base_plot + 
  labs(x = "", y = "Number of Words Between use of Savior Name") + 
  geom_label(data = filter(bm_counts_book, book_title %in% c("1 Nephi", "2 Nephi", "Mosiah", "Alma", "Helaman", "3 Nephi", "Ether", "Moroni")), 
             aes(x = cum_name_count, label = book_title), y = 3000) + 
  geom_hline(yintercept = 150, color = "darkgrey", size = .8) +
  geom_text_repel(data = filter(bm_split, words_between > 1200), aes(label = verse_short_title), size = 3)

zoom_plot <- base_plot + 
  coord_cartesian(ylim = c(0,150)) + 
  geom_hline(yintercept = 150, color = "darkgrey", size = .8) +
  labs(x = "Chronilogical Occurence of Savior Name", y = "Words Between") +
  geom_hline(yintercept = 40.5*1.7, color = "darkblue")

#+ fig.width=14, fig.height=7
full_plot + zoom_plot + plot_layout(ncol = 1, heights = c(3,2))



# jpeg(file = "wordcount_saviornames.jpg", width = 14, height = 7, units = "in", res = 150)
# full_plot + zoom_plot + plot_layout(ncol = 1, heights = c(3,2))
# dev.off()

#' * Need to do it for the new testament
#' * Make int interactive and have each dot open a link to the verses on LDS.org
#' * Check that really short names are not being found in longer words that aren't names.
#' * I know that . Father Lehi will count in mine.
 
