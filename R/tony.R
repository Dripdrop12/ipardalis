require(stringr)
require(fs)
require(glue)
require(readr)
require(dplyr)
source("R/clean_ancestor_report.R")

create_lineage_post(
  breeder = "tony",
  birth = "2021-06-01",
  sex = "male",
  tags = c("tony", "nugget", "artemis"),
  filial = "F4-CG13",
  sire = list(
    name = "Nugget",
    loc = ""
  ),
  dam = list(
    name = "Amara",
    loc = ""
  )
)
