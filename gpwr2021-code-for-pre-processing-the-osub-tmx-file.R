# load the tidyverse R package used in the process.
library(tidyverse)

# If you haven't installed the tidyverse, install it first in R by running this code: install.packages("tidyverse").
# To learn more about what tidyverse is, go to its official webpage at https://www.tidyverse.org/

# check the current directory/folder that we are working with
getwd()
# [1] "/Users/Primahadi/Documents/research/2020-11-03-PARALLEL-CORPUS-PUPS" <- my working directory/folder. 
# The output files from this process will be saved in this current directory/folder in our computer (the directory will be different in each computer for each user of this script)

# load into R the Eng-Idn OpenSubtitles corpus in .tmx format
tmx <- readr::read_lines(file = "~/Downloads/en-id-OpenSubtitles.tmx")
# The code in line 13 above shows that I put the corpus file in my "Downloads" directory/folder.
# Make sure you know where is the folder path/directory of this .tmx corpus in your computer.
# Also note that the .tmx corpus of the OpenSubtitles is a large file (1-GB file).

# Split and subset respectively the English and Indonesian lines from the corpus

eng <- stringr::str_subset(string = tmx, pattern = '<tuv xml\\:lang\\="en".+<\\/tuv\\>')
head(eng)

idn <- stringr::str_subset(string = tmx, pattern = '<tuv xml\\:lang\\="id".+<\\/tuv\\>')
head(idn)

rm(tmx)

# Extract only the text by removing the tagging (English section)

## regular expression used to do the extraction
regex_to_extract_en_text <- '(?<=["]en["]\\>\\<seg\\>)[^<]+(?=\\<\\/seg\\>)'

eng <- stringr::str_extract(string = eng, pattern = regex_to_extract_en_text)
eng <- stringr::str_replace_all(string = eng, pattern = "(^\\-\\=|\\=\\-$)", "")
head(eng) # peek into the first six lines of the output

# Extract only the text by removing the tagging (Indonesian section)

## regular expression used to do the extraction
regex_to_extract_id_text <- '(?<=["]id["]\\>\\<seg\\>)[^<]+(?=\\<\\/seg\\>)'

idn <- stringr::str_extract(string = idn, pattern = regex_to_extract_id_text)
idn <- stringr::str_replace_all(string = idn, pattern = "(^\\-\\=|\\=\\-$)", "")
head(idn) # peek into the first six lines of the output

# check that the number of lines/sentences should be the same between the English and Indonesian texts
length(eng) == length(idn) # this equality logical operation should produce TRUE

# Save the English source language to the current working directory 
readr::write_lines(x = eng, file = "eng_OpenSub.txt")

# Save the Indonesian target language to the current working directory
readr::write_lines(x = idn, file = "id_OpenSub.txt")