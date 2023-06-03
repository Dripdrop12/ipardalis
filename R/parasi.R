require(stringr)
require(fs)
require(glue)
require(readr)
require(dplyr)
source("R/clean_ancestor_report.R")

create_lineage_post(
  breeder = "parasi",
  birth = "2022-08-20",
  sex = "female",
  tags = c("parasi", "manjaka", "jack"),
  filial = "F2-CG14",
  sire = list(
    name = "Manjaka",
    loc = ""
  ),
  dam = list(
    name = "Parasy",
    loc = ""
  )
)
