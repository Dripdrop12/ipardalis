require(stringr)
require(fs)
require(glue)
require(readr)
require(dplyr)

create_lineage_post(
  breeder = "lokana",
  birth = "2020-12-02",
  sex = "female",
  tags = c("lokana", "kromatisk", "landy"),
  filial = "F9-CG12",
  sire = list(
    name = "Kromatisk",
    loc = "chromatic.md"
  ),
  dam = list(
    name = "Shirley",
    loc = "chromatic.md"
  )
)