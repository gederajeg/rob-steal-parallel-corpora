library(tidyverse)
library(readxl)
rob2 <- readr::read_rds("/Users/Primahadi/Documents/research/2020-11-03-PARALLEL-CORPUS-PUPS/rob2.rds")
steal2 <- readr::read_rds("/Users/Primahadi/Documents/research/2020-11-03-PARALLEL-CORPUS-PUPS/steal2.rds")

# count the construction pattern of RAMPOK (ROB's translation) as verb
rampok_idn_cxn <- rob2 %>% 
	filter(TRANSLATION_POS == "verb", 
	       str_detect(TRANSLATION_NODE, "rampok")) %>%
	count(CXN_IDN) %>%
	filter(str_detect(CXN_IDN, "GOODS|TARGET")) %>%
	mutate(CXN_IDN = tolower(CXN_IDN),
	       CXN_IDN = str_replace(CXN_IDN, "\\-obj$", "-object"),
	       CXN_IDN = str_replace(CXN_IDN, "\\-subj-pass$", "-subj"),
	       BASE_verb = "rampok",
	       VOICE = ifelse(CXN_IDN == "target-subj", "NON-AV", "AV")) %>%
	rename(CXN_TYPE = CXN_IDN)

rampok_idn_cxn

# count the construction pattern of CURI (STEAL's translation) as verb
curi_idn_cxn <- steal2 %>% 
	filter(TRANSLATION_POS == "verb", 
	       str_detect(TRANSLATION_NODE, "curi")) %>%
	count(CXN_IDN) %>%
	filter(str_detect(CXN_IDN, "GOODS|TARGET")) %>%
	mutate(CXN_IDN = tolower(CXN_IDN),
	       CXN_IDN = str_replace(CXN_IDN, "\\-obj$", "-object"),
	       CXN_IDN = str_replace(CXN_IDN, "\\-subj-pass$", "-subj"),
	       BASE_verb = "curi",
	       VOICE = ifelse(CXN_IDN == "goods-subj", "NON-AV", "AV")) %>%
	rename(CXN_TYPE = CXN_IDN)

curi_idn_cxn

# combine the RAMPOK and CURI data from the parallel corpora
(parallel_data <- bind_rows(rampok_idn_cxn, curi_idn_cxn))

# split the AV and PASS data
parallel_data_av <- parallel_data %>% filter(VOICE == "AV")
parallel_data_pass <- parallel_data %>% filter(VOICE == "NON-AV")

# create a tabulation matrix for AV only since two constructional variations occur there in AV
parallel_mtx_av <- parallel_data_av %>% 
  pivot_wider(-VOICE, names_from = BASE_verb, values_from = n) %>% 
  data.frame(row.names = 1) %>% 
  as.matrix()

parallel_mtx_av <- parallel_mtx_av[ , c(2, 1)] # switch the column order

# barplot for AV
barplot(prop.table(parallel_mtx_av, 2), 
        legend.text = TRUE, 
        xlim = c(0, 3.2), 
        args.legend = list(bty = "n", x = 3.35, y = 1, border = "gray95"), 
        col = c("grey20", "gray90", "grey20", "gray90"), 
        border = "gray95", 
        ylab = "Proportion", 
        xlab = "Verbs", 
        main = "Proportion of construction types by verbs")

# run significance test (chi-squared and fisher-exact, and effect size)
chisq.test(parallel_mtx_av, correct = TRUE)$p.value
chisq.test(parallel_mtx_av, correct = TRUE)$residuals
chisq.test(parallel_mtx_av, correct = TRUE)$expected
chisq.test(parallel_mtx_av, correct = TRUE)$observed - chisq.test(parallel_mtx_av, correct = TRUE)$expected 
fisher.test(parallel_mtx_av, alternative = "greater")$p.value # since cell a is greater than expected
fisher.test(parallel_mtx_av, alternative = "greater")$estimate
vcd::assocstats(parallel_mtx_av)$phi # phi-coefficient effect size is the same with cramer's V for the 2-by-2 table as in this data
vcd::assocstats(parallel_mtx_av)$cramer # phi-coefficient effect size is the same with cramer's V for the 2-by-2 table as in this data

# ====================== # End of the parallel data codes
	
# read the AntConc concordance data for RAMPOK and CURI from the Monolingual corpora
antconc_data <- readxl::read_xlsx("/Users/Primahadi/Documents/research/2021-10-17-ROBSTEAL-IDN/antconc_results-CURI-RAMPOK.xlsx")

# potential translated novel
excluded_novels <- c("Musashi_Eiji_Yoshikawa_INDONESIA_Tamat.txt", "MULAN.txt")

# filter relevant observation and perform other pre-processing
antconc_data1 <- antconc_data %>%
	filter(!FILES %in% c("Harimau Harimau (Moctar Lubis).txt", excluded_novels), 
	       DUPLICATES == FALSE, 
	       REDUPLICATION == FALSE, 
	       SYNTACTIC_CATEGORY == "verb", 
	       !is.na(CXN_TYPE), 
	       CXN_TYPE != "UNCLEAR") %>% 
	mutate(NODE_lower = tolower(NODE), 
	       CXN_TYPE_new = str_replace(CXN_TYPE, "\\-(ov|pass|pass\\-ter)$", ""), 
	       VOICE_new = ifelse(str_detect(VOICE, "^AV"), "AV", "NON-AV (OV, PASS-di, PASS-ter)"), 
	       BASE_verb = ifelse(str_detect(NODE_lower, "rampok"), "rampok", "curi"))
	
# count the CXN_TYPE_new, VOICE_new, and BASE_verb
cxn_types_all <- antconc_data1 %>% 
  count(VOICE_new, CXN_TYPE_new, BASE_verb)

cxn_types_av <- cxn_types_all %>% 
  filter(VOICE_new == "AV") %>%
	group_by(BASE_verb) %>%
	mutate(perc_by_verb = round((n/sum(n) * 100), 2))

cxn_types_pass <- cxn_types_all %>% 
  filter(VOICE_new != "AV") %>%
	group_by(BASE_verb) %>%
	mutate(perc_by_verb = round((n/sum(n) * 100), 2))

# assocstats and FYE test for CXN_TYPE_new and BASE_verb - AV
antconc_mtx_av <- table(subset(antconc_data1, VOICE_new == "AV")$CXN_TYPE_new, 
                        subset(antconc_data1, VOICE_new == "AV")$BASE_verb)

antconc_mtx_av_prop <- prop.table(antconc_mtx_av, margin = 2)
barplot(antconc_mtx_av_prop, 
        legend.text = TRUE, 
        xlim = c(0, 3.175), 
        args.legend = list(bty = "n", border = "gray95"), 
        ylab = "Proportion", 
        xlab = "Verbs", 
        col = c("grey20", "gray90", "grey20", "gray90"), 
        border = "gray95")

vcd::assocstats(antconc_mtx_av)
fisher.test(antconc_mtx_av)

# assocstats and FYE test for CXN_TYPE_new and BASE_verb - PASS
antconc_mtx_pass <- table(subset(antconc_data1, VOICE_new != "AV")$CXN_TYPE_new, 
                          subset(antconc_data1, VOICE_new != "AV")$BASE_verb)

antconc_mtx_pass_prop <- prop.table(antconc_mtx_pass, margin = 2)
barplot(antconc_mtx_pass_prop, 
        legend.text = TRUE, 
        xlim = c(0, 3.175), 
        args.legend = list(bty = "n", border = "gray95"), 
        ylab = "Proportion", 
        xlab = "Verbs", 
        col = c("grey20", "gray90", "grey20", "gray90"), 
        border = "gray95")

vcd::assocstats(antconc_mtx_pass)
fisher.test(antconc_mtx_pass)


# OLD CODES BELOW ======================= 


# syntactic valence/transitivity
mencuri_val <- c(intransitive = 80, transitive = 238)
merampok_val <- c(intransitive = 10, transitive = 24)
(valence_curi_rampok_av <- rbind(mencuri_val, merampok_val))
fisher.test(valence_curi_rampok_av)$p.value
fisher.test(valence_curi_rampok_av)$p.value < 0.05 # Is p-value significant?
fisher.test(valence_curi_rampok_av)$p.value < 0.01 # Is p-value very significant?
fisher.test(valence_curi_rampok_av)$p.value < 0.001 # Is p-value highly significant?
vcd::assocstats(valence_curi_rampok_av)

# construction type AV (mapping of GOODS and TARGET to direct object) 
mencuri <- c(goods_object = 234, target_object = 4)
merampok <- c(goods_object = 13, target_object = 11)
(cxn_curi_rampok_av <- rbind(mencuri, merampok))
fisher.test(cxn_curi_rampok_av)$p.value
fisher.test(cxn_curi_rampok_av)$p.value < 0.001 # Is p-value highly significant?
vcd::assocstats(cxn_curi_rampok_av)
barplot(prop.table(t(cxn_curi_rampok_av), 2), 
        legend = rownames(t(cxn_curi_rampok_av)), 
        xlim = c(0, 3.5), 
        col = c("grey20", "gray90", "grey20", "gray90"), 
        border = "gray50", 
        args.legend = list(bty = "n", border = "gray95"))

# construction type PASS-di (mapping of GOODS and TARGET to direct object) 
dicuri <- c(goods_subj_pass = 74, target_subj_pass = 1)
dirampok <- c(goods_subj_pass = 5, target_subj_pass = 15)
(cxn_curi_rampok_pass <- rbind(dicuri, dirampok))
fisher.test(cxn_curi_rampok_pass)$p.value
fisher.test(cxn_curi_rampok_pass)$p.value < 0.05 # Is p-value significant?
fisher.test(cxn_curi_rampok_pass)$p.value < 0.01 # Is p-value very significant?
fisher.test(cxn_curi_rampok_pass)$p.value < 0.001 # Is p-value highly significant?
vcd::assocstats(cxn_curi_rampok_pass)
barplot(prop.table(t(cxn_curi_rampok_pass), 2), legend = rownames(t(cxn_curi_rampok_pass)), xlim = c(0, 3.5), col = c("grey20", "gray90", "grey20", "gray90"), border = "gray50", args.legend = list(bty = "n"))