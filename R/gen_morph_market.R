require(fs)
require(yaml)
require(dplyr)
require(tidyr)
require(lubridate)
require(stringr)
require(purrr)

gen_morph_market <- function(
    clutch_dir = "data/clutches/", 
    file_name = "R/morphmarket.csv",
    morph_market_export = "~/Downloads/animals(3).csv",
    sire_list = c("jackson", "manjaka", "ralph", "tony", "zandrin", "zava", "zozoro")){
  
  clutch_list <- dir_map(clutch_dir, read_yaml, type = "file")
  clutch_df <- as.data.frame(do.call(rbind, clutch_list))
  
  clutch_df <- clutch_df %>%
    filter(
      !map_vec(soldoutmale, is.null),
      map_vec(soldoutmale, is.list),
      sire %in% sire_list
    ) %>%
    unnest_longer(soldoutmale) %>%
    unnest_wider(soldoutmale, names_sep = "-") %>% 
    mutate_if(is.list, ~ unlist(.)) %>%
    filter(
      is.na(`soldoutmale-sold`)) %>%
    mutate(across(c(laid, hatchstart, hatchend), ymd)) %>%
    filter(!is.na(hatchend)) %>%
    mutate(
      `soldoutmale-phenotype` = if_else(
        condition = is.na(`soldoutmale-phenotype`),
        true = "YBBB Ambilobe",
        false = `soldoutmale-phenotype`
      ),
      age_months = interval(hatchend, today()) %/% months(1),
      Category = "Panther Chameleons",
      Group_Id = paste0(sire, "-", dam, hatchend),
      Animal_Id = paste0(`soldoutmale-name`, "-", Group_Id),
      Title = paste0(
        age_months, " Month-old ",
        `soldoutmale-phenotype`, " Panther Chameleon"
      ),
      Price = `soldoutmale-price`,
      State = "For Sale",
      Visibility = "Public",
      Enabled = "Active",
      Is_Group = "No",
      Sex = `soldoutmale-gender`,
      Dob = format(hatchend, "%m-%d-%Y"),
      Maturity = case_when(
        age_months > 9 ~ "Adult",
        age_months > 5 ~ "Subadult",
        age_months >= 3 ~ "Juvenile"
      ),
      Traits = str_replace(`soldoutmale-phenotype`, "Rainbow", "Classic"),
      Desc = paste0(Title, " (", Animal_Id, ") - ", desc, ifelse(is.na(`soldoutmale-desc`), "", `soldoutmale-desc`)),
      Origin = "Self Produced",
      Proven_Breeder = "No",
      Quantity = 1,
      Prey_State = "Live",
      Prey_Food = "Cricket",
      Min_Shipping = 40,
      Max_Shipping = 100,
      Is_Negotiable = "Will Consider",
      Is_Rep_Photo = "No",
      Is_For_Trade = "No",
      Photo_Urls = paste0("https://ipardalis.com", `soldoutmale-image`, ".jpg")
    ) %>%
    select(Category:Photo_Urls)
  
  morph_market_df <- readr::read_csv(morph_market_export)
  
  out <- sync_morph_market(clutch_df, morph_market_df) 
  
  write.csv(out, file_name, row.names = FALSE)
}

sync_morph_market <- function(clutch_df, morph_market_df) {
  to_keep <- morph_market_df %>% 
    filter(State == "Not For Sale" | `Category*` == "More Colubrids") %>%
    rename(
      Category = `Category*`,
      Title = `Title*`,
      Animal_Id = `Animal_Id*`,
      Maturity = `Maturity*`) %>%
    select(-Video_Url, -Weight, -Length, -Length_Type)
  
  bind_rows(to_keep, clutch_df) %>%
    select(Category:Is_For_Trade)
}

gen_morph_market()
