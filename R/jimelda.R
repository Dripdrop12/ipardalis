require(stringr)
require(fs)
require(glue)
require(readr)
require(dplyr)
source("R/clean_ancestor_report.R")

create_lineage_post(
  breeder = "jimelda",
  birth = "2021-12-03",
  sex = "female",
  tags = c("jimelda", "manga", "imelda", "hendrix", "bleu"),
  filial = "F4-CG14",
  sire = list(
    name = "manga",
    loc = ""
  ),
  dam = list(
    name = "imelda",
    loc = ""
  )
)
