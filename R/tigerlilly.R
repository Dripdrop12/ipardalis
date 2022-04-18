require(stringr)
require(fs)
require(glue)
require(readr)
require(dplyr)
source("R/clean_ancestor_report.R")

create_lineage_post(
  breeder = "tigerlilly",
  birth = "2021-06-01",
  sex = "female",
  tags = c("tigerlilly", "nugget", "amara", "jude", "artemis"),
  filial = "F4-CG13",
  sire = list(
    name = "nugget",
    loc = ""
  ),
  dam = list(
    name = "amara",
    loc = ""
  )
)