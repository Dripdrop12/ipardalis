require(stringr)
require(fs)
require(glue)
require(readr)
require(dplyr)
source("R/clean_ancestor_report.R")

create_lineage_post(
  breeder = "zor",
  birth = "2023-01-24",
  sex = "male",
  tags = c("zor", "zozoro", "artalla", "arti", "alla", "gold-rush"),
  filial = "F4-CG14",
  sire = list(
    name = "zozoro",
    loc = ""
  ),
  dam = list(
    name = "artalla",
    loc = ""
  )
)
