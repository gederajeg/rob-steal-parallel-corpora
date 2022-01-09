Repositori data dan kode pemrograman untuk Penelitian Unggulan Program
Studi (PUPS) dengan judul *MODEL KAJIAN TERJEMAHAN BERBASIS BANK DATA
TERJEMAHAN DIGITAL INGGRIS-INDONESIA DAN IMPLIKASI PEDAGOGISNYA*
================
[Gede Primahadi Wijaya
Rajeg](https://udayananetworking.unud.ac.id/lecturer/880-gede-primahadi-wijaya-rajeg)
<a itemprop="sameAs" content="https://orcid.org/0000-0002-2047-8621" href="https://orcid.org/0000-0002-2047-8621" target="orcid.widget" rel="noopener noreferrer" style="vertical-align:top;"><img src="https://orcid.org/sites/default/files/images/orcid_16x16.png" style="width:1em;margin-right:.5em;" alt="ORCID iD icon"></a>(Ketua
Tim Peneliti), [I Made
Rajeg](https://udayananetworking.unud.ac.id/lecturer/1817-i-made-rajeg)
<a itemprop="sameAs" content="https://orcid.org/0000-0001-8989-0203" href="https://orcid.org/0000-0001-8989-0203" target="orcid.widget" rel="noopener noreferrer" style="vertical-align:top;"><img src="https://orcid.org/sites/default/files/images/orcid_16x16.png" style="width:1em;margin-right:.5em;" alt="ORCID iD icon"></a>(Anggota),
I Gede Semara Dharma Putra (Anggota Mahasiswa), Putu Dea Indah Kartini
(Anggota Mahasiswa)

<!-- README.md is generated from README.Rmd. Please edit that file -->

Universitas Udayana, Bali, Indonesia

<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png" /></a>
[![](https://img.shields.io/badge/doi-10.17605/OSF.IO/Y6ESA-lightblue.svg)](https://doi.org/10.17605/OSF.IO/Y6ESA)<br />Semua
berkas di dalam repositori ini berlisensi
<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/">Creative
Commons Attribution-NonCommercial-ShareAlike 4.0 International
License</a>.

Kunjungi [laman
utama](https://udayananetworking.unud.ac.id/lecturer/research/880-gede-primahadi-wijaya-rajeg/a-model-for-translation-study-based-on-english-indonesian-translation-database-and-its-pedagogical-implication-1179)
penelitian ini.

Jika berkas-berkas dalam repositori ini ([Rajeg et al.
2021b](#ref-rajeg_material_2021)) digunakan untuk tujuan penelitian dan
pengajaran, harap menyitir/mengutip repositori ini sebagai berikut:

> Rajeg, Gede Primahadi Wijaya, I Made Rajeg, Putu Dea Indah Kartini & I
> Gede Semara Dharma Putra. 2021. Material pendukung untuk *MODEL KAJIAN
> TERJEMAHAN BERBASIS BANK DATA TERJEMAHAN DIGITAL INGGRIS-INDONESIA DAN
> IMPLIKASI PEDAGOGISNYA*. Open Science Framework.
> <https://doi.org/10.17605/OSF.IO/Y6ESA>. <https://osf.io/y6esa/>.

# Material

-   Direktori
    [SENASTEK](https://github.com/gederajeg/rob-steal-parallel-corpora/tree/main/SENASTEK)
    berisi berkas pendukung untuk makalah yang disajikan pada [*Seminar
    Nasional Sains, Teknologi dan
    Humaniora*](https://senastek.unud.ac.id) 2021 (SENASTEK 2021).
    Berkas-berkas tersebut berupa data mentah, [kode pemrograman
    R](https://github.com/gederajeg/rob-steal-parallel-corpora/blob/main/SENASTEK/SENASTEK-code.R)
    untuk analisis kuantitatif dan visualisasi,
    [salindia/slides](https://doi.org/10.6084/m9.figshare.17078369) dan
    [abstrak](https://github.com/gederajeg/rob-steal-parallel-corpora/blob/main/SENASTEK/SENASTEK-abstrak.pdf)
    presentasi ([Rajeg et al. 2021a](#ref-rajeg_pemanfaatan_2021)), dan
    dua grafik statistik yang digunakan dalam presentasi.

-   Direktori
    [LITERATES](https://github.com/gederajeg/rob-steal-parallel-corpora/tree/main/LITERATES)
    berisi berkas pendukung untuk makalah pada *LINGUISTICS, LITERATURE,
    CULTURE AND ARTS INTERNATIONAL SEMINAR*
    ([LITERATES](https://fba.unmas.ac.id/literates/)) yang
    diselenggarakan pada tanggal 22 Januari 2022 oleh [Fakultas Bahasa
    Asing](https://fba.unmas.ac.id) (FBA), Universitas Mahasaraswati
    Denpasar.

-   Berkas
    [`gpwr2021-code-for-pre-processing-the-osub-tmx-file.R`](https://github.com/gederajeg/rob-steal-parallel-corpora/blob/main/gpwr2021-code-for-pre-processing-the-osub-tmx-file.R)
    mengandung kode pemrograman untuk pengolahan awal korpus paralel
    Inggris-Indonesia *OpenSubtitles2018* ([Lison & Tiedemann
    2016](#ref-lison_opensubtitles2016_2016)) berformat `.tmx`.
    Pengolahan ini adalah untuk memisahkan kalimat bahasa Inggris dan
    padanan bahasa Indonesianya menjadi dua berkas teks biasa (`.txt`)
    terpisah, yang kemudian bisa menjadi input untuk konkordansi paralel
    (lihat info selanjutnya).

-   Program untuk menghasilkan konkordansi paralel menggunakan R dikemas
    dalam fungsi `para_conc()` yang diterbitkan bersama dengan modul
    pemrograman R bernama
    [**paracorp**](https://gederajeg.github.io/paracorp/) ([Rajeg
    2021](#ref-rajeg_paracorp_2021)). Perhatikan salah satu contoh
    penggunaan `para_conc()` berikut. Info lengkap cara memasang dan
    mengutip modul **paracorp** dalam publikasi dapat dilihat pada laman
    [**paracorp**](https://gederajeg.github.io/paracorp/).

``` r
# load the paracorp R package
# more info at https://gederajeg.github.io/paracorp/
library(paracorp)  

# in this example, the English text is used as the source text
my_para_conc <- para_conc(source_text = sci_en,
                          target_text = sci_id,
                          pattern = "\\bshould\\b", # regular expression pattern
                          conc_sample = 20) # retrieve 20 random concordance lines
#> The output concordance file (called: 'parallel_conc.txt') will be saved in this directory: '/Volumes/GoogleDrive/Other computers/My MacBook Pro/Documents/research/2020-11-03-PARALLEL-CORPUS-PUPS'
#> The output concordance will ALSO be returned as a tibble data frame in the R console.
#> Detecting the match/pattern...
#> You choose to generate a 20 random-sample of the concordance lines.
#> Creating a 20 random-sample of the concordance lines...
#> Generating the concordance for the match/pattern...
#> Saving the output concordance file (called: 'parallel_conc.txt') in '/Volumes/GoogleDrive/Other computers/My MacBook Pro/Documents/research/2020-11-03-PARALLEL-CORPUS-PUPS'.

# peek into the results as tibble/data frame
head(my_para_conc)
#> # A tibble: 6 × 4
#>   LEFT                   NODE   RIGHT                 TRANSLATION               
#>   <chr>                  <chr>  <chr>                 <chr>                     
#> 1 This enzyme should cr… should also react to the ho… "Enzim ini tentunya menja…
#> 2 When designating thes… should always be borne in m… "Ketika menentukan filum …
#> 3 You                    should be able to control n… "Anda seharusnya dapat me…
#> 4 It                     should be admitted that ini… "Perlu diakui bahwa untuk…
#> 5 This was doubly ironi… should be denigrated rather… "Hal ini sangat ironis, k…
#> 6 The electric resulted… should be directly distribu… "Listrik yang dihasilkan …
```

# Sesi ruang kerja R

``` r
devtools::session_info()
#> ─ Session info ───────────────────────────────────────────────────────────────
#>  setting  value
#>  version  R version 4.1.2 (2021-11-01)
#>  os       macOS Big Sur 10.16
#>  system   x86_64, darwin17.0
#>  ui       X11
#>  language (EN)
#>  collate  en_US.UTF-8
#>  ctype    en_US.UTF-8
#>  tz       Asia/Makassar
#>  date     2022-01-09
#>  pandoc   2.14.0.3 @ /Applications/RStudio.app/Contents/MacOS/pandoc/ (via rmarkdown)
#> 
#> ─ Packages ───────────────────────────────────────────────────────────────────
#>  package     * version date (UTC) lib source
#>  assertthat    0.2.1   2019-03-21 [1] CRAN (R 4.1.0)
#>  bit           4.0.4   2020-08-04 [1] CRAN (R 4.1.0)
#>  bit64         4.0.5   2020-08-30 [1] CRAN (R 4.1.0)
#>  cachem        1.0.6   2021-08-19 [1] CRAN (R 4.1.0)
#>  callr         3.7.0   2021-04-20 [1] CRAN (R 4.1.0)
#>  cli           3.1.0   2021-10-27 [1] CRAN (R 4.1.0)
#>  crayon        1.4.2   2021-10-29 [1] CRAN (R 4.1.0)
#>  DBI           1.1.2   2021-12-20 [1] CRAN (R 4.1.0)
#>  desc          1.4.0   2021-09-28 [1] CRAN (R 4.1.0)
#>  devtools      2.4.3   2021-11-30 [1] CRAN (R 4.1.0)
#>  digest        0.6.29  2021-12-01 [1] CRAN (R 4.1.0)
#>  dplyr         1.0.7   2021-06-18 [1] CRAN (R 4.1.0)
#>  ellipsis      0.3.2   2021-04-29 [1] CRAN (R 4.1.0)
#>  evaluate      0.14    2019-05-28 [1] CRAN (R 4.1.0)
#>  fansi         0.5.0   2021-05-25 [1] CRAN (R 4.1.0)
#>  fastmap       1.1.0   2021-01-25 [1] CRAN (R 4.1.0)
#>  fs            1.5.2   2021-12-08 [1] CRAN (R 4.1.0)
#>  generics      0.1.1   2021-10-25 [1] CRAN (R 4.1.0)
#>  glue          1.6.0   2021-12-17 [1] CRAN (R 4.1.0)
#>  hms           1.1.1   2021-09-26 [1] CRAN (R 4.1.0)
#>  htmltools     0.5.2   2021-08-25 [1] CRAN (R 4.1.0)
#>  knitr         1.37    2021-12-16 [1] CRAN (R 4.1.0)
#>  lifecycle     1.0.1   2021-09-24 [1] CRAN (R 4.1.0)
#>  magrittr      2.0.1   2020-11-17 [1] CRAN (R 4.1.0)
#>  memoise       2.0.1   2021-11-26 [1] CRAN (R 4.1.0)
#>  paracorp    * 0.0.1   2021-12-30 [1] Github (gederajeg/paracorp@c2cd065)
#>  pillar        1.6.4   2021-10-18 [1] CRAN (R 4.1.0)
#>  pkgbuild      1.3.1   2021-12-20 [1] CRAN (R 4.1.0)
#>  pkgconfig     2.0.3   2019-09-22 [1] CRAN (R 4.1.0)
#>  pkgload       1.2.4   2021-11-30 [1] CRAN (R 4.1.0)
#>  prettyunits   1.1.1   2020-01-24 [1] CRAN (R 4.1.0)
#>  processx      3.5.2   2021-04-30 [1] CRAN (R 4.1.0)
#>  ps            1.6.0   2021-02-28 [1] CRAN (R 4.1.0)
#>  purrr         0.3.4   2020-04-17 [1] CRAN (R 4.1.0)
#>  R6            2.5.1   2021-08-19 [1] CRAN (R 4.1.0)
#>  readr         2.1.1   2021-11-30 [1] CRAN (R 4.1.0)
#>  remotes       2.4.2   2021-11-30 [1] CRAN (R 4.1.0)
#>  rlang         0.4.12  2021-10-18 [1] CRAN (R 4.1.0)
#>  rmarkdown     2.11    2021-09-14 [1] CRAN (R 4.1.0)
#>  rprojroot     2.0.2   2020-11-15 [1] CRAN (R 4.1.0)
#>  rstudioapi    0.13    2020-11-12 [1] CRAN (R 4.1.0)
#>  sessioninfo   1.2.2   2021-12-06 [1] CRAN (R 4.1.0)
#>  stringi       1.7.6   2021-11-29 [1] CRAN (R 4.1.0)
#>  stringr       1.4.0   2019-02-10 [1] CRAN (R 4.1.0)
#>  testthat      3.1.1   2021-12-03 [1] CRAN (R 4.1.0)
#>  tibble        3.1.6   2021-11-07 [1] CRAN (R 4.1.0)
#>  tidyselect    1.1.1   2021-04-30 [1] CRAN (R 4.1.0)
#>  tzdb          0.2.0   2021-10-27 [1] CRAN (R 4.1.0)
#>  usethis       2.1.5   2021-12-09 [1] CRAN (R 4.1.0)
#>  utf8          1.2.2   2021-07-24 [1] CRAN (R 4.1.0)
#>  vctrs         0.3.8   2021-04-29 [1] CRAN (R 4.1.0)
#>  vroom         1.5.7   2021-11-30 [1] CRAN (R 4.1.0)
#>  withr         2.4.3   2021-11-30 [1] CRAN (R 4.1.0)
#>  xfun          0.29    2021-12-14 [1] CRAN (R 4.1.0)
#>  yaml          2.2.1   2020-02-01 [1] CRAN (R 4.1.0)
#> 
#>  [1] /Users/Primahadi/Rlibs
#>  [2] /Library/Frameworks/R.framework/Versions/4.1/Resources/library
#> 
#> ──────────────────────────────────────────────────────────────────────────────
```

# Referensi

<div id="refs" class="references csl-bib-body hanging-indent">

<div id="ref-lison_opensubtitles2016_2016" class="csl-entry">

Lison, Pierre & Jörg Tiedemann. 2016. Opensubtitles2016: Extracting
large parallel corpora from movie and tv subtitles. *Proceedings of the
Tenth International Conference on Language Resources and Evaluation
(LREC’16)*, 923–929. Portorož, Slovenia: European Language Resources
Association (ELRA).

</div>

<div id="ref-rajeg_paracorp_2021" class="csl-entry">

Rajeg, Gede Primahadi Wijaya. 2021. *Paracorp: A concordancer for
parallel, bilingual corpora*. GitHub; Open Science Framework (OSF).
doi:[10.17605/OSF.IO/HV9CU](https://doi.org/10.17605/OSF.IO/HV9CU).
<https://github.com/gederajeg/paracorp>.

</div>

<div id="ref-rajeg_pemanfaatan_2021" class="csl-entry">

Rajeg, Gede Primahadi Wijaya, I Made Rajeg, Putu Dea Indah Kartini & I
Gede Semara Dharma Putra. 2021a. Pemanfaatan Bank-data Digital Dwibahasa
dalam Kajian Terjemahan: Studi kasus padanan bahasa Indonesia untuk
verba sinonim bahasa Inggris ROB & STEAL. Paper.
doi:[10.6084/m9.figshare.17078369](https://doi.org/10.6084/m9.figshare.17078369).
<https://github.com/gederajeg/rob-steal-parallel-corpora>.

</div>

<div id="ref-rajeg_material_2021" class="csl-entry">

Rajeg, Gede Primahadi Wijaya, I Made Rajeg, Putu Dea Indah Kartini & I
Gede Semara Dharma Putra. 2021b. Material pendukung untuk *MODEL KAJIAN
TERJEMAHAN BERBASIS BANK DATA TERJEMAHAN DIGITAL INGGRIS-INDONESIA DAN
IMPLIKASI PEDAGOGISNYA*. Open Science Framework.
doi:[10.17605/OSF.IO/Y6ESA](https://doi.org/10.17605/OSF.IO/Y6ESA).
<https://osf.io/y6esa/>.

</div>

</div>
