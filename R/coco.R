require(stringr)
require(fs)
require(glue)
require(readr)
require(dplyr)
source("R/clean_ancestor_report.R")

create_lineage_post(
  breeder = "coco",
  birth = "2020-12-04",
  sex = "female",
  tags = c("coco", "hendrix", "foxey", "landy", "bolt", "gambit"),
  filial = "F3-CG3",
  sire = list(
    name = "Hendrix",
    loc = "ramblin.md"
  ),
  dam = list(
    name = "Foxey",
    loc = "ramblin.md"
  )
)