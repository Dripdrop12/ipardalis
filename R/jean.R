require(stringr)
require(fs)
require(glue)
require(readr)
require(dplyr)
source("R/create_lineage_post.R")

create_lineage_post(
  breeder = "jean",
  birth = "2023-03-14",
  sex = "female",
  tags = c("jean", "jackson", "beans", "jack", "mcnulty"),
  filial = "F5-CG14",
  sire = list(
    name = "jackson",
    loc = ""
  ),
  dam = list(
    name = "beans",
    loc = ""
  )
)
