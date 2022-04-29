require(stringr)
require(fs)
require(glue)
require(readr)
require(dplyr)
source("R/clean_ancestor_report.R")

create_lineage_post(
  breeder = "Mainty",
  birth = "2021-09-05",
  sex = "female",
  tags = c("mainty", "bangheera", "flamethrower", "grape inferno"),
  filial = "Unknown Filial",
  sire = list(
    name = "Bangheera",
    loc = "naturesvangogh.md"
  ),
  dam = list(
    name = "Moonclaw",
    loc = "naturesvangogh.md"
  )
)