require(stringr)
require(fs)
require(glue)
require(readr)
require(dplyr)
source("R/clean_ancestor_report.R")

create_lineage_post(
  breeder = "parasy",
  birth = "2021-01-21",
  sex = "female",
  tags = c("jack", "mavokely", "amarillo"),
  filial = "F4-CG13",
  sire = list(
    name = "jack",
    loc = ""
  ),
  dam = list(
    name = "mavokely",
    loc = ""
  )
)
