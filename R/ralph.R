require(stringr)
require(fs)
require(glue)
require(readr)
require(dplyr)
source("R/clean_ancestor_report.R")

create_lineage_post(
  breeder = "ralph",
  birth = "2021-06-05",
  sex = "male",
  tags = c("ralph", "alfred", "kanto", "brightflame", "triple"),
  filial = "F4-CG13",
  sire = list(
    name = "Alfred",
    loc = ""
  ),
  dam = list(
    name = "Kanto",
    loc = ""
  )
)