require(stringr)
require(fs)
require(glue)
require(readr)
require(dplyr)
source("R/create_lineage_post.R")

create_lineage_post(
  breeder = "cadi",
  birth = "2023-03-17",
  sex = "female",
  tags = c("cadi", "cadillac", "atlas", "amarillo"),
  filial = "F5-CG14",
  sire = list(
    name = "Cadillac",
    loc = "longshot.md"
  ),
  dam = list(
    name = "Jane",
    loc = "longshot.md"
  )
)
