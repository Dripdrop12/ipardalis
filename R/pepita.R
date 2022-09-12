require(stringr)
require(fs)
require(glue)
require(readr)
require(dplyr)
source("R/clean_ancestor_report.R")

create_lineage_post(
  breeder = "pepita",
  birth = "2021-12-07",
  sex = "female",
  tags = c("pepita", "papafee", "coco", "hendrix"),
  filial = "F4-CG14",
  sire = list(
    name = "papafee",
    loc = ""
  ),
  dam = list(
    name = "coco",
    loc = ""
  )
)
