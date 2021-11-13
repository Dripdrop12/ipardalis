require(stringr)
require(fs)
require(glue)
require(readr)
require(dplyr)
source("R/clean_ancestor_report.R")

create_lineage_post(
  breeder = "Lelafo",
  birth = "2021-04-02",
  sex = "female",
  tags = c("lelafo", "vulcan", "odin", "agent orange"),
  filial = "F2-CG14",
  sire = list(
    name = "Vulcan",
    loc = "newenglandchameleons.md"
  ),
  dam = list(
    name = "Odin's daughter",
    loc = "newenglandchameleons.md"
  )
)