require(stringr)
require(fs)
require(glue)
require(readr)
require(dplyr)
require(yaml)
require(tidyr)
require(lubridate)
require(purrr)

source("R/get_clutch_df.R")

update_google <- function(df = get_clutch_df()){
  df %>% 
    mutate(id = Animal_Id, 
           description = str_squish(Desc), 
           condition = "New",
           link = glue("https://ipardalis.com/panther-chameleons-for-sale/{sire}/{dam}/{hatchend}/{`babies-name`}/"),
           image_link = glue("https://ipardalis.com/{`babies-image`}.jpg"),
           additional_image_link = glue("https://ipardalis.com/{image}.jpg"),
           availability = ifelse(is.na(`babies-sold`), "in_stock", ifelse(`babies-sold`, "out_of_stock", "in_stock")), 
           availability_date = hatchend, 
           brand = "iPardalis", 
           adult = "No",
           tax = "US:MD:6.00:n",
           price = Price,
           title = Title) %>%
    select(id, title, description, price, condition, link, image_link, additional_image_link,
           availability_date, availability, brand, adult, tax) %>%
    write_tsv("R/Google.tsv")
}