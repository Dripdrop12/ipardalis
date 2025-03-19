require(stringr)
require(fs)
require(glue)
require(readr)
require(dplyr)
source("R/create_lineage_post.R")

create_lineage_post(
  breeder = "smiles",
  birth = "2023-03-17",
  sex = "male",
  tags = c("smiles", "cadillac", "atlas", "amarillo"),
  filial = "F5-CG14",
  primary_img = "img/ambilobe/smiles/smiles2",
  sire = list(
    name = "Cadillac",
    loc = "longshot.md"
  ),
  dam = list(
    name = "Jane",
    loc = "longshot.md"
  )
)
