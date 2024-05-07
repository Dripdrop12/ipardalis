require(stringr)
require(fs)
require(glue)
require(readr)
require(dplyr)
source("R/create_lineage_post.R")

create_lineage_post(
  breeder = "hong",
  birth = "2023-10-19",
  sex = "male",
  tags = c("hong", "snoop dog", "optimus prime"),
  filial = "F1-CG2",
  sire = list(
    name = "Snoop Dog",
    loc = "robersonreptiles.md"
  ),
  dam = list(
    name = "Chameleons by Design WC's Daughter",
    loc = "chamsbydesign.md"
  )
)