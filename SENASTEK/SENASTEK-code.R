library(tidyverse)
library(readxl)
library(RColorBrewer)

# # load ROB data
# rob <- readxl::read_xlsx("ROB_sample_conc.xlsx", sheet = "ROB_sample_half_conc", na = "NA")
# # exclude irrelevant data points
# rob1 <- rob %>% 
#   filter(!TRANSLATION_NODE %in% c("ERROR", "PROPER NAME")) %>% 
#   select(CASES, LEFT, NODE, RIGHT, TRANSLATION, TRANSLATION_NODE, TRANSLATION_POS)

# # save the SENASTEK data
# write_tsv(rob1, file = "SENASTEK/SENASTEK_data_rob1.txt")
# load the SENASTEK data
rob1 <- readr::read_tsv(file = "SENASTEK/SENASTEK_data_rob1.txt")

# # load STEAL data
# steal <- read_xlsx("STEAL_sample_conc.xlsx", sheet = "STEAL_sample_half_conc", na = "NA")
# # exclude irrelevant data points
# steal1 <- steal %>% 
#   filter(INCLUSION == TRUE, !is.na(TRANSLATION_POS)) %>% 
#   select(CASES, LEFT, NODE, RIGHT, TRANSLATION, TRANSLATION_NODE, TRANSLATION_POS)

# # save the SENASTEK data
# write_tsv(steal1, file = "SENASTEK/SENASTEK_data_steal1.txt")
# load the SENASTEK data
steal1 <- readr::read_tsv(file = "SENASTEK/SENASTEK_data_steal1.txt")

# helper function for determining the p-value to print in the text
pval_print <- function(pval) {
  
  if (pval < 0.05 & pval > 0.01) {
    pv <- " < 0.05"
  } else if (pval < 0.01 & pval > 0.001) {
    pv <- " < 0.01"
  } else if (pval < 0.001) {
    pv <- " < 0.001"
  } else if (pval > 0.05 & pval < 0.1) {
    pv <- " > 0.05"
  } else if (pval > 0.1) {
    pv <- " > 0.1"
  }
  
  return(pv)
  
}


# lexical equivalence for ROB ===============
rob_equiv_lemma <- c("rampok", "rampok", "curi", "rampas", "rampok", "copet", "kemalingan", "rampok", "ambil", "rebut", "rampok", "perampok")

rob1_lex_equivalence <- rob1 %>%
  count(TRANSLATION_NODE, sort = TRUE) %>% 
  mutate(LEMMAS = rob_equiv_lemma,
         WORD_CLASS = if_else(LEMMAS == "perampok", "noun", "verb")) %>% 
  rename(WORD_FORM = TRANSLATION_NODE) %>% 
  arrange(desc(WORD_CLASS), desc(n)) %>% 
  select(WORD_FORM, LEMMAS, WORD_CLASS, N_WORD_FORM = n)

rob1_lex_equivalence

## binomial test for the distribution of word class equivalence of ROB ========
## data preparation
### lemma equivalence for all word classes
rob1_lemma_equivalence <- rob1_lex_equivalence %>% 
  group_by(LEMMAS, WORD_CLASS) %>% 
  summarise(N_LEMMAS = sum(N_WORD_FORM), .groups = "drop") %>% 
  arrange(desc(WORD_CLASS), desc(N_LEMMAS))
rob1_lemma_equivalence

### only the lemmas for verbal equivalence
rob1_verbal_lemma_equivalence <- rob1_lemma_equivalence %>% 
  filter(WORD_CLASS == "verb") %>% 
  group_by(LEMMAS) %>% 
  summarise(N_LEMMAS = sum(N_LEMMAS), .groups = "drop") %>% 
  arrange(desc(N_LEMMAS))
rob1_verbal_lemma_equivalence

### summarising the distribution of the word classes across lemmas
rob1_wclass_equivalence <- rob1_lemma_equivalence %>% 
  group_by(WORD_CLASS) %>% 
  summarise(N_WORD_CLASS = sum(N_LEMMAS), .groups = "drop") %>% 
  arrange(desc(N_WORD_CLASS))
rob1_wclass_equivalence

### getting the value of verb and noun equivalence
pull(filter(rob1_wclass_equivalence, WORD_CLASS == "verb"), N_WORD_CLASS)
pull(filter(rob1_wclass_equivalence, WORD_CLASS == "noun"), N_WORD_CLASS)
sum(rob1_wclass_equivalence$N_WORD_CLASS) # total tokens

### run the two-tailed binomial test for word class equivalence of ROB ======
rob1_wclass_equivalence_binom <- binom.test(rob1_wclass_equivalence$N_WORD_CLASS)
rob1_wclass_equivalence_binom
rob1_wclass_equivalence_binom$p.value
(rob1_wclass_pbinom_text <- pval_print(rob1_wclass_equivalence_binom$p.value))

## chi-square goodness-of-fit for verbal equivalence lemma for ROB =======
rob_verbal_equiv_vals <- rob1_verbal_lemma_equivalence$N_LEMMAS
names(rob_verbal_equiv_vals) <- rob1_verbal_lemma_equivalence$LEMMAS
rob1_verbal_lemma_equivalence_chisq <- chisq.test(rob_verbal_equiv_vals)
rob1_verbal_lemma_equivalence_chisq
rob1_verbal_lemma_equivalence_chisq$p.value
rob1_verbal_lemma_equivalence_chisq$residuals
rob1_verbal_lemma_equivalence_expected <- rob1_verbal_lemma_equivalence_chisq$expected
(rob1_verbal_pchisq_text <- pval_print(rob1_verbal_lemma_equivalence_chisq$p.value))

## Probability of the verbal equivalence ROB ======
prop.table(rob_verbal_equiv_vals)
prop.table(rob_verbal_equiv_vals) * 100

## visualising the barplot for lexical equivalence of ROB (Gambar 3a in the SENASTEK proceeding paper) =======
p1_idn <- rob1_verbal_lemma_equivalence %>% 
  ggplot(aes(x = reorder(LEMMAS, -N_LEMMAS),
             y = N_LEMMAS)) +
  geom_col(fill = brewer.pal(brewer.pal.info[rownames(brewer.pal.info) == "RdYlBu", 1], name = "RdYlBu")[10]) +
  theme_bw() +
  geom_text(aes(label = paste("N=", N_LEMMAS, sep = "")), vjust = -.5) +
  labs(x = "Padanan leksikal verba ROB",
       y = "Frekuensi kemunculan") +
  theme(axis.text = element_text(size = 12),
        axis.title = element_text(size = 17)) +
  geom_hline(yintercept = unique(rob1_verbal_lemma_equivalence_expected),
             colour = brewer.pal(brewer.pal.info[rownames(brewer.pal.info) == "YlOrRd", 1], name = "YlOrRd")[6], linetype = "dashed") +
  annotate(geom = "text", x = 4.5, y = unique(rob1_verbal_lemma_equivalence_expected) + 5, label = paste("frekuensi harapan (expected frequency) = ", prettyNum(round(unique(rob1_verbal_lemma_equivalence_expected), 2), decimal.mark = ","), sep = ""))
p1_idn
### uncomment the following code to save into file
# ggsave("SENASTEK/SENASTEK-plot-verbal-equivalence-rob-idn.png", plot = p1_idn, height = 5, width = 6, dpi = 300)





# lexical equivalence for STEAL ===============
steal_equiv_lemma <- c("curi", "curi", "curi", "curian", "pencurian", "hilang", "culik", "ambil", "rampas", "rebut", "renggut", "pencuri")

steal1_lex_equivalence <- steal1 %>% 
  count(TRANSLATION_NODE, sort = TRUE) %>% 
  mutate(LEMMAS = steal_equiv_lemma) %>% 
  left_join(steal1 %>% 
              count(TRANSLATION_NODE, TRANSLATION_POS, sort = TRUE),
            by = c("TRANSLATION_NODE", "n")) %>% 
  rename(WORD_CLASS = TRANSLATION_POS,
         WORD_FORM = TRANSLATION_NODE) %>% 
  arrange(desc(WORD_CLASS), desc(n)) %>% 
  select(WORD_FORM, LEMMAS, WORD_CLASS, N_WORD_FORM = n)

steal1_lex_equivalence

## binomial test for the distribution of word class equivalence of STEAL ========
## data preparation
### lemma equivalence for all word classes
steal1_lemma_equivalence <- steal1_lex_equivalence %>% 
  group_by(LEMMAS, WORD_CLASS) %>% 
  summarise(N_LEMMAS = sum(N_WORD_FORM), .groups = "drop") %>% 
  arrange(desc(WORD_CLASS), desc(N_LEMMAS))
steal1_lemma_equivalence

### only the lemmas for verbal equivalence
steal1_verbal_lemma_equivalence <- steal1_lemma_equivalence %>% 
  filter(WORD_CLASS == "verb") %>% 
  group_by(LEMMAS) %>% 
  summarise(N_LEMMAS = sum(N_LEMMAS), .groups = "drop") %>% 
  arrange(desc(N_LEMMAS))
steal1_verbal_lemma_equivalence

### summarising the distribution of the word classes across lemmas
steal1_wclass_equivalence <- steal1_lemma_equivalence %>% 
  group_by(WORD_CLASS) %>% 
  summarise(N_WORD_CLASS = sum(N_LEMMAS), .groups = "drop") %>% 
  arrange(desc(N_WORD_CLASS))
steal1_wclass_equivalence

### getting the value of verb and noun equivalence
pull(filter(steal1_wclass_equivalence, WORD_CLASS == "verb"), N_WORD_CLASS)
pull(filter(steal1_wclass_equivalence, WORD_CLASS == "noun"), N_WORD_CLASS)
sum(steal1_wclass_equivalence$N_WORD_CLASS) # total tokens

### run the two-tailed binomial test for word class equivalence of STEAL ======
steal1_wclass_equivalence_binom <- binom.test(steal1_wclass_equivalence$N_WORD_CLASS)
steal1_wclass_equivalence_binom
steal1_wclass_equivalence_binom$p.value
(steal1_wclass_pbinom_text <- pval_print(steal1_wclass_equivalence_binom$p.value))

## chi-square goodness-of-fit for verbal equivalence lemma for STEAL =======
steal_verbal_equiv_vals <- steal1_verbal_lemma_equivalence$N_LEMMAS
names(steal_verbal_equiv_vals) <- steal1_verbal_lemma_equivalence$LEMMAS
steal1_verbal_lemma_equivalence_chisq <- chisq.test(steal_verbal_equiv_vals)
steal1_verbal_lemma_equivalence_chisq
steal1_verbal_lemma_equivalence_chisq$p.value
steal1_verbal_lemma_equivalence_chisq$residuals
steal1_verbal_lemma_equivalence_expected <- steal1_verbal_lemma_equivalence_chisq$expected
(steal1_verbal_pchisq_text <- pval_print(steal1_verbal_lemma_equivalence_chisq$p.value))

## Probability of the verbal equivalence STEAL ======
prop.table(steal_verbal_equiv_vals)
prop.table(steal_verbal_equiv_vals) * 100

## visualising the barplot for lexical equivalence of STEAL (Gambar 3b in the SENASTEK proceeding paper) =======
p2_idn <- steal1_verbal_lemma_equivalence %>% 
  ggplot(aes(x = reorder(LEMMAS, -N_LEMMAS),
             y = N_LEMMAS)) +
  geom_col(fill = brewer.pal(brewer.pal.info[rownames(brewer.pal.info) == "RdYlBu", 1], name = "RdYlBu")[10]) +
  theme_bw() +
  geom_text(aes(label = paste("N=", N_LEMMAS, sep = "")), vjust = -.5) +
  labs(x = "Padanan leksikal verba STEAL",
       y = "Frekuensi kemunculan") +
  theme(axis.text = element_text(size = 12),
        axis.title = element_text(size = 17)) +
  geom_hline(yintercept = unique(steal1_verbal_lemma_equivalence_expected),
             colour = brewer.pal(brewer.pal.info[rownames(brewer.pal.info) == "YlOrRd", 1], name = "YlOrRd")[6], linetype = "dashed") +
  annotate(geom = "text", x = 4.5, y = unique(steal1_verbal_lemma_equivalence_expected) + 5, label = paste("frekuensi harapan (expected frequency) = ", prettyNum(round(unique(steal1_verbal_lemma_equivalence_expected), 2), decimal.mark = ","), sep = ""))
p2_idn
### uncomment the following code to save into file
# ggsave("SENASTEK/SENASTEK-plot-verbal-equivalence-steal-idn.png", plot = p2_idn, height = 5, width = 6, dpi = 300)