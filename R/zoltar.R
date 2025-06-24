require(stringr)
require(fs)
require(glue)
require(readr)
require(dplyr)
source("R/create_lineage_post.R")

create_lineage_post(
  breeder = "Zoltar",
  birth = "2024-02-28",
  sex = "male",
  tags = c("zoltar", "secret weapon", "night owl"),
  filial = "F10-CG14",
  primary_img = "img/ambilobe/zoltar/zoltar2",
  sire = list(
    name = "Secret Weapon",
    loc = "kammerflage.md"
  ),
  dam = list(
    name = "Pollen",
    loc = "kammerflage.md"
  )
)
