require(stringr)
require(fs)
require(glue)
require(readr)
require(dplyr)
source("R/clean_ancestor_report.R")

create_lineage_post(
  breeder = "avana",
  birth = "2023-01-23",
  sex = "female",
  tags = c("avana", "zozoro", "artalla", "arti", "gold-rush"),
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
