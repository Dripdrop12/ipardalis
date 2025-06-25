require(fs)
require(yaml)
require(dplyr)
require(tidyr)
require(lubridate)
require(stringr)
require(purrr)
require(glue)

gen_morph_market <- function(
    clutch_dir = "data/clutches/", 
    file_name = "R/morphmarket.csv",
    morph_market_export = "~/Downloads/animals(5).csv"){
  
  clutch_list <- dir_map(clutch_dir, read_yaml, type = "file")
  clutch_df <- as.data.frame(do.call(bind_rows, clutch_list))
  
  clutch_df <- clutch_df %>%
    filter(listed == TRUE) %>%
    unnest_wider(babies, names_sep = "-") %>%
    mutate(across(c(laid, hatchstart, hatchend), ymd)) %>% 
    filter(is.na(`babies-sold`)) %>%
    mutate(
      `babies-phenotype` = if_else(
        condition = is.na(`babies-phenotype`),
        true = "YBBB Ambilobe",
        false = `babies-phenotype`
      ),
      age_months = interval(hatchend, today()) %/% months(1),
      Category = "Panther Chameleons",
      Group_Id = str_replace_all(paste0(sire, "-", dam, hatchend), " ", "-"),
      Animal_Id = str_replace_all(paste0(`babies-name`, "-", Group_Id), " ", "-"),
      Title = paste0(
        age_months, " Month-old ",
        `babies-phenotype`, " Panther Chameleon"
      ),
      Price = `babies-price`,
      State = "For Sale",
      Visibility = "Public",
      Enabled = "Active",
      Is_Group = "No",
      Sex = `babies-gender`,
      Dob = format(hatchend, "%m-%d-%Y"),
      Maturity = case_when(
        age_months > 9 ~ "Adult",
        age_months > 5 ~ "Subadult",
        age_months >= 2 ~ "Juvenile"
      ),
      Traits = str_replace(`babies-phenotype`, "Rainbow", "Classic"),
      Desc = paste0(Title, " (", Animal_Id, ") - ", desc, ifelse("babies-desc" %in% colnames(.), `babies-desc`, ""), "
      We've included sire and dam dendrograms, but you can search for ", sire, " or ", dam, " on our website for 5+ generations of lineage!"),
      Origin = "Self Produced",
      Proven_Breeder = "No",
      Quantity = 1,
      Diet = "Cricket, Roach, Superworm, Hornworm, Bsfl",
      Min_Shipping = 40,
      Max_Shipping = 100,
      Wholesale_Only = "No",
      Is_Negotiable = "Will Consider",
      Is_Rep_Photo = "No",
      Is_For_Trade = "No",
      sire_doh = readr::read_lines(glue("content/blog/{sire}/index.md")) %>% 
        .[grepl("date = ", .)] %>% lubridate::as_date() %>% stringr::str_replace_all("-", "/"),
      dam_doh = readr::read_lines(glue("content/blog/{dam}/index.md")) %>% 
        .[grepl("date = ", .)] %>% lubridate::as_date() %>% stringr::str_replace_all("-", "/"),
      sire_tree = ifelse(fs::file_exists(glue::glue("content/blog/{sire}/tree.png")), glue("https://ipardalis.com/blog/{sire_doh}/{sire}/tree.png"), ""),
      dam_tree = ifelse(fs::file_exists(glue::glue("content/blog/{dam}/tree.png")), glue("https://ipardalis.com/blog/{dam_doh}/{dam}/tree.png"), ""),
      Photo_Urls = glue("https://ipardalis.com{`babies-image`}.jpg https://ipardalis.com{image}.jpg {sire_tree} {dam_tree}")
    ) %>%
    select(Category:Photo_Urls)
  
  morph_market_df <- readr::read_csv(morph_market_export)
  
  out <- sync_morph_market(clutch_df, morph_market_df) 
  on.exit(upload_df <<- out)
  write.csv(out, file_name, row.names = FALSE)
}

sync_morph_market <- function(clutch_df, morph_market_df) {
  to_keep <- morph_market_df %>% 
    filter(State == "Not For Sale" | `Category*` == "More Colubrids") %>%
    rename(
      Category = `Category*`,
      Title = `Title*`,
      Animal_Id = `Animal_Id*`) %>%
    select(-Video_Url, -Weight, -Length, -Length_Type, -Wholesale_Price, -Wholesale_Description)
  
  bind_rows(to_keep, clutch_df) %>%
    select(Category:Is_For_Trade)
}

gen_morph_market()
