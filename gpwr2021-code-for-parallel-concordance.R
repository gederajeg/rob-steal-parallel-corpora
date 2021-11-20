# if you find this code useful for your research and teaching,
# please cite it via the repository as follow:

# Rajeg, Gede Primahadi Wijaya, I. Made Rajeg, Putu Dea Indah Kartini & I. Gede Semara Dharma Putra. 2021. Material pendukung untuk MODEL KAJIAN TERJEMAHAN BERBASIS BANK DATA TERJEMAHAN DIGITAL INGGRIS-INDONESIA DAN IMPLIKASI PEDAGOGISNYA. Open Science Framework. https://doi.org/10.17605/OSF.IO/Y6ESA. https://osf.io/y6esa/.

# load the tidyverse R package used in the conc_osub() function below
library(tidyverse)

# If you haven't installed the tidyverse, install it first in R by running this code: install.packages("tidyverse").
# To learn more about what tidyverse is, go to its official webpage at https://www.tidyverse.org/

# Main code below ====================

# The following codes are for generating the parallel concordance from the English and Indonesian corpus texts in the OpenSubtitle corpus. 
# The codes are wrapped into a function called `conc_osub()`
conc_osub <- function(eng = "English source text", 
                      idn = "Indonesian target text", 
                      pattern = "Search pattern", 
                      case_insensitive = FALSE, 
                      conc_sample = 300, 
                      filename = "parallel_conc.txt") {
  
  m_eng <- eng; rm(eng)
  m_idn <- idn; rm(idn)
  
  search_term <- pattern
  samples <- conc_sample
  
  message(paste("The output concordance file (called: '", filename,"') will be save in this directory: '", getwd(), "'\n", sep = ""))
  
  cat("LEFT\tNODE\tRIGHT\tTRANSLATION", file = filename, sep = "\n")
  
  for (i in seq_along(search_term)) {
    
    m_id <- stringr::str_which(m_eng, stringr::regex(search_term[i], ignore_case = case_insensitive))
    
    if ((length(m_id) >= 1) == TRUE) {
      
      m <- m_eng[m_id]
      message("Detecting the match/pattern...\n")
      m_loc <- stringr::str_locate_all(m, stringr::regex(search_term[i], ignore_case = case_insensitive))
      m_loc <- purrr::map(m_loc, tibble::as_tibble)
      m_loc <- purrr::map_df(m_loc, dplyr::bind_rows)
      
      # duplicate the number of subset text as many as the number of the match
      m1 <- rep(m, stringr::str_count(m, stringr::regex(search_term[i], ignore_case = case_insensitive)))
      m_id <- rep(m_id, stringr::str_count(m, stringr::regex(search_term[i], ignore_case = case_insensitive)))
      
      if (samples) {
        
        message(paste("You choose to generate a ", samples, " random-sample of the concordance lines.\n", sep = ""))
        message(paste("Creating a ", samples, " random-sample of the concordance lines...\n", sep = ""))
        
        # sample count
        sample_count <- sample(1:length(m1), samples)
        
        # retrieve random sample sentences
        eng_sample <- m1[sample_count]
        idn_sample <- m_idn[m_id[sample_count]]
        m_loc1 <- m_loc[sample_count, ]
        
      } else {
        
        message("Retrieving all occurrences of the search pattern...\n")
        
        eng_sample <- m1
        idn_sample <- m_idn[m_id]
        m_loc1 <- m_loc
        
      }
      
      # extract match
      message("Generating the concordance for the match/pattern...\n")
      node <- stringr::str_sub(eng_sample, start = m_loc1$start, end = m_loc1$end)
      node_tag <- stringr::str_c("\t<NODE>", node, "</NODE>\t", sep = "")
      left <- stringr::str_sub(eng_sample, start = 1, end = (m_loc1$start - 1))
      right <- stringr::str_sub(eng_sample, start = (m_loc1$end + 1), end = nchar(eng_sample))
      
      # create concordance
      # LEFT <- stringr::str_sub(left, start = (nchar(left) - context_char), end = nchar(left))
      LEFT <- replace(left, nchar(left) == 0, "~")
      NODE <- node
      # RIGHT <- stringr::str_sub(right, start = 1, end = context_char)
      RIGHT <- replace(right, nchar(right) == 0, "~")
      TRANSLATION <- idn_sample
      concord_df <- tibble::tibble(LEFT, NODE, RIGHT, TRANSLATION)
      concord_df <- dplyr::mutate(concord_df,
                                  LEFT = stringr::str_trim(.data$LEFT),
                                  NODE = stringr::str_trim(.data$NODE),
                                  RIGHT = stringr::str_trim(.data$RIGHT))
      concord_df <- dplyr::mutate(concord_df,
                                  LEFT = stringr::str_replace(LEFT, "^-", '"-'),
                                  RIGHT = stringr::str_replace(RIGHT, "^-", '"-'),
                                  TRANSLATION = stringr::str_replace(TRANSLATION, "^-", '"-'))
      
      message(paste("Saving the output concordance file (called: '", filename,"') in '", getwd(), "'\n", sep = ""))
      readr::write_tsv(dplyr::arrange(concord_df, dplyr::desc(NODE), RIGHT), filename, append = TRUE)
      
    } else {
      
      message("Sorry; no match found! Try another corpus/pattern!\n")
      
    }
    
  }
  
}
