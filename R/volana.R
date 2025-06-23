require(stringr)
require(fs)
require(glue)
require(readr)
require(dplyr)
source("R/create_lineage_post.R")

create_lineage_post(
  breeder = "Volana",
  birth = "2024-02-28",
  sex = "female",
  tags = c("volana", "secret weapon", "night owl"),
  filial = "F10-CG14",
  primary_img = "img/ambilobe/volana/volana1",
  sire = list(
    name = "Secret Weapon",
    loc = "kammerflage.md"
  ),
  dam = list(
    name = "Pollen",
    loc = "kammerflage.md"
  )
)
