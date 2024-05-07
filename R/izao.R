require(stringr)
require(fs)
require(glue)
require(readr)
require(dplyr)
source("R/create_lineage_post.R")

create_lineage_post(
  breeder = "izao",
  birth = "2023-09-27",
  sex = "female",
  tags = c("izao", "kosmo", "mainty"),
  filial = "Unknown",
  sire = list(
    name = "kosmo",
    loc = ""
  ),
  dam = list(
    name = "mainty",
    loc = ""
  )
)
