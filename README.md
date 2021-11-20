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
[![](https://img.shields.io/badge/doi-10.17605/OSF.IO/Y6ESA-green.svg)](https://doi.org/10.17605/OSF.IO/Y6ESA)<br />Semua
berkas di dalam repositori ini berlisensi
<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/">Creative
Commons Attribution-NonCommercial-ShareAlike 4.0 International
License</a>.

Kunjungi laman utama penelitian ini pada [tautan
ini](https://udayananetworking.unud.ac.id/lecturer/research/880-gede-primahadi-wijaya-rajeg/a-model-for-translation-study-based-on-english-indonesian-translation-database-and-its-pedagogical-implication-1179).

Jika berkas-berkas dalam repositori ini ([Rajeg et al.
2021](#ref-rajeg_material_2021)) digunakan untuk tujuan penelitian dan
pengajaran, harap menyitir/mengutip repositori ini sebagai berikut:

> Rajeg, Gede Primahadi Wijaya, I. Made Rajeg, Putu Dea Indah Kartini &
> I. Gede Semara Dharma Putra. 2021. Material pendukung untuk *MODEL
> KAJIAN TERJEMAHAN BERBASIS BANK DATA TERJEMAHAN DIGITAL
> INGGRIS-INDONESIA DAN IMPLIKASI PEDAGOGISNYA*. Open Science Framework.
> <https://doi.org/10.17605/OSF.IO/Y6ESA>. <https://osf.io/y6esa/>.

# Material

-   Direktori
    [SENASTEK](https://github.com/gederajeg/rob-steal-parallel-corpora/tree/main/SENASTEK)
    berisi berkas pendukung untuk makalah yang disajikan pada [*Seminar
    Nasional Sains, Teknologi dan
    Humaniora*](https://senastek.unud.ac.id) 2021 (SENASTEK 2021).
    Berkas-berkas tersebut berupa data mentah, [kode pemrograman
    R](https://github.com/gederajeg/rob-steal-parallel-corpora/blob/main/SENASTEK/SENASTEK-code.R)
    untuk analisis kuantitatif dan visualisasi, dan grafik statistik.

-   Berkas
    [`gpwr2021-code-for-pre-processing-the-osub-tmx-file.R`](https://github.com/gederajeg/rob-steal-parallel-corpora/blob/main/gpwr2021-code-for-pre-processing-the-osub-tmx-file.R)
    mengandung kode pemrograman untuk pengolahan awal korpus paralel
    Inggris-Indonesia *OpenSubtitles2018* ([Lison & Tiedemann
    2016](#ref-lison_opensubtitles2016_2016)) berformat `.tmx`.
    Pengolahan ini adalah untuk memisahkan kalimat bahasa Inggris dan
    padanan bahasa Indonesianya menjadi dua berkas teks biasa (`.txt`)
    terpisah.

-   

# Session info

``` r
devtools::session_info()
#> ─ Session info ───────────────────────────────────────────────────────────────
#>  setting  value                       
#>  version  R version 4.0.5 (2021-03-31)
#>  os       macOS Big Sur 10.16         
#>  system   x86_64, darwin17.0          
#>  ui       X11                         
#>  language (EN)                        
#>  collate  en_US.UTF-8                 
#>  ctype    en_US.UTF-8                 
#>  tz       Asia/Makassar               
#>  date     2021-11-20                  
#> 
#> ─ Packages ───────────────────────────────────────────────────────────────────
#>  package     * version date       lib source        
#>  backports     1.1.7   2020-05-13 [1] CRAN (R 4.0.0)
#>  cachem        1.0.5   2021-05-15 [1] CRAN (R 4.0.2)
#>  callr         3.6.0   2021-03-28 [1] CRAN (R 4.0.2)
#>  cli           3.1.0   2021-10-27 [1] CRAN (R 4.0.2)
#>  crayon        1.4.1   2021-02-08 [1] CRAN (R 4.0.2)
#>  desc          1.4.0   2021-09-28 [1] CRAN (R 4.0.2)
#>  devtools      2.3.0   2020-04-10 [1] CRAN (R 4.0.0)
#>  digest        0.6.25  2020-02-23 [1] CRAN (R 4.0.0)
#>  ellipsis      0.3.1   2020-05-15 [1] CRAN (R 4.0.0)
#>  evaluate      0.14    2019-05-28 [1] CRAN (R 4.0.0)
#>  fastmap       1.1.0   2021-01-25 [1] CRAN (R 4.0.2)
#>  fs            1.4.1   2020-04-04 [1] CRAN (R 4.0.0)
#>  glue          1.4.1   2020-05-13 [1] CRAN (R 4.0.0)
#>  htmltools     0.5.2   2021-08-25 [1] CRAN (R 4.0.2)
#>  knitr         1.30    2020-09-22 [1] CRAN (R 4.0.2)
#>  lifecycle     1.0.0   2021-02-15 [1] CRAN (R 4.0.2)
#>  magrittr      2.0.1   2020-11-17 [1] CRAN (R 4.0.2)
#>  memoise       2.0.0   2021-01-26 [1] CRAN (R 4.0.2)
#>  pkgbuild      1.0.8   2020-05-07 [1] CRAN (R 4.0.0)
#>  pkgload       1.1.0   2020-05-29 [1] CRAN (R 4.0.0)
#>  prettyunits   1.1.1   2020-01-24 [1] CRAN (R 4.0.0)
#>  processx      3.5.1   2021-04-04 [1] CRAN (R 4.0.2)
#>  ps            1.6.0   2021-02-28 [1] CRAN (R 4.0.2)
#>  purrr         0.3.4   2020-04-17 [1] CRAN (R 4.0.0)
#>  R6            2.4.1   2019-11-12 [1] CRAN (R 4.0.0)
#>  remotes       2.1.1   2020-02-15 [1] CRAN (R 4.0.0)
#>  rlang         0.4.11  2021-04-30 [1] CRAN (R 4.0.2)
#>  rmarkdown     2.11    2021-09-14 [1] CRAN (R 4.0.2)
#>  rprojroot     1.3-2   2018-01-03 [1] CRAN (R 4.0.0)
#>  rstudioapi    0.13    2020-11-12 [1] CRAN (R 4.0.2)
#>  sessioninfo   1.1.1   2018-11-05 [1] CRAN (R 4.0.0)
#>  stringi       1.5.3   2020-09-09 [1] CRAN (R 4.0.2)
#>  stringr       1.4.0   2019-02-10 [1] CRAN (R 4.0.0)
#>  testthat      3.0.2   2021-02-14 [1] CRAN (R 4.0.2)
#>  usethis       2.1.3   2021-10-27 [1] CRAN (R 4.0.2)
#>  withr         2.4.1   2021-01-26 [1] CRAN (R 4.0.2)
#>  xfun          0.22    2021-03-11 [1] CRAN (R 4.0.2)
#>  yaml          2.2.1   2020-02-01 [1] CRAN (R 4.0.0)
#> 
#> [1] /Users/Primahadi/Rlibs
#> [2] /Library/Frameworks/R.framework/Versions/4.0/Resources/library
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

<div id="ref-rajeg_material_2021" class="csl-entry">

Rajeg, Gede Primahadi Wijaya, I Made Rajeg, Putu Dea Indah Kartini & I
Gede Semara Dharma Putra. 2021. Material pendukung untuk *MODEL KAJIAN
TERJEMAHAN BERBASIS BANK DATA TERJEMAHAN DIGITAL INGGRIS-INDONESIA DAN
IMPLIKASI PEDAGOGISNYA*. Open Science Framework.
doi:[10.17605/OSF.IO/Y6ESA](https://doi.org/10.17605/OSF.IO/Y6ESA).
<https://osf.io/y6esa/>.

</div>

</div>
