require(stringr)
require(fs)
require(glue)
require(readr)
require(dplyr)
source("R/clean_ancestor_report.R")

create_lineage_post(
  breeder = "artilly",
  birth = "2022-02-03",
  sex = "female",
  tags = c("artilly", "arti", "lilly", "jude", "artemis"),
  filial = "F4-CG13",
  sire = list(
    name = "arti",
    loc = ""
  ),
  dam = list(
    name = "lilly",
    loc = ""
  )
)
