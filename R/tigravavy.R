require(stringr)
require(fs)
require(glue)
require(readr)
require(dplyr)
source("R/clean_ancestor_report.R")

create_lineage_post(
  breeder = "tigravavy",
  birth = "2020-12-12",
  sex = "female",
  tags = c("tigravavy", "jude", "alla", "flash", "cowboy", "jj"),
  filial = "F3-CG12",
  sire = list(
    name = "Jude",
    loc = ""
  ),
  dam = list(
    name = "Alla",
    loc = ""
  )
)