require(stringr)
require(fs)
require(glue)
require(readr)
require(dplyr)
source("R/clean_ancestor_report.R")

create_lineage_post(
  breeder = "jackson",
  birth = "2021-01-20",
  sex = "male",
  tags = c("jack", "mavokely", "amarillo"),
  filial = "F4-CG13",
  sire = list(
    name = "Jack",
    loc = ""
  ),
  dam = list(
    name = "Mavokely",
    loc = ""
  )
)
