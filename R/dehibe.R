require(stringr)
require(fs)
require(glue)
require(readr)
require(dplyr)
source("R/clean_ancestor_report.R")

create_lineage_post(
  breeder = "dehibe",
  birth = "2021-10-15",
  sex = "male",
  tags = c("dehibe", "arti", "alla", "jj", "artemis"),
  filial = "F4-CG13",
  sire = list(
    name = "arti",
    loc = ""
  ),
  dam = list(
    name = "alla",
    loc = ""
  )
)
