require(stringr)
require(fs)
require(glue)
require(readr)
require(dplyr)
source("R/clean_ancestor_report.R")

create_lineage_post(
  breeder = "zozoro",
  birth = "2021-10-06",
  sex = "male",
  tags = c("gold rush", "my friend", "divergent"),
  filial = "F3-CG13",
  sire = list(
    name = "Au-mirongatra (Gold Rush)",
    loc = "kammerflage.md"
  ),
  dam = list(
    name = "Ankoso-bolamena (Goldie)",
    loc = "kammerflage.md"
  )
)
