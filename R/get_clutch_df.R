get_clutch_df <- function(clutch_dir = "data/clutches/") {
  clutch_list <- dir_map(clutch_dir, read_yaml, type = "file")
  clutch_df <- as.data.frame(do.call(bind_rows, clutch_list))
  
  # Clean data
  clutch_df <- clutch_df %>%
    filter(listed == TRUE) %>%
    unnest_wider(babies, names_sep = "-") %>%
    mutate(across(c(laid, hatchstart, hatchend), ymd)) %>% 
    filter(!is.na(`babies-name`)) %>%
    mutate(
      `babies-phenotype` = if_else(
        condition = is.na(`babies-phenotype`),
        true = "YBBB Ambilobe",
        false = `babies-phenotype`
      ),
      age_months = interval(hatchend, today()) %/% months(1),
      Group_Id = str_replace_all(paste0(sire, "-", dam, "-", hatchend), " ", "-"),
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
      Desc = str_squish(paste0(Title, " from ", str_to_title(sire), " and ", str_to_title(dam), ". ", desc, ifelse(is.na(`babies-desc`), "", `babies-desc`), " We've included sire and dam dendrograms if available, but you can view our ", str_to_title(sire), " or ", str_to_title(dam), " breeder pages for more information.")),
      sire_doh = readr::read_lines(glue("content/blog/{sire}/index.md")) %>% 
        .[grepl("date = ", .)] %>% lubridate::as_date() %>% stringr::str_replace_all("-", "/"),
      sire_tree = glue("/blog/{sire_doh}/{sire}/tree.png"),
      dam_doh = readr::read_lines(glue("content/blog/{dam}/index.md")) %>% 
        .[grepl("date = ", .)] %>% lubridate::as_date() %>% stringr::str_replace_all("-", "/"),
      dam_tree = glue("/blog/{dam_doh}/{dam}/tree.png"),
      lineage_collage = glue("{image}.jpg"),
      Photo_Urls = glue("{ifelse(is.na(`babies-image`), list(`babies-images`), `babies-image`)}.jpg"),
      site_priority = case_when(
        is.na(`babies-primary`) ~ "0.0",
        `babies-primary`        ~ "0.5",
        .default                = "0.5"
      )
    )
  canonical_links <- clutch_df %>% 
    group_by(sire, dam, hatchend) %>% 
    filter(`babies-primary`) %>% 
    mutate(canonical = glue("/panther-chameleons-for-sale/{sire}/{dam}/{`hatchend`}/{`babies-name`}/")) %>%
    select(sire, dam, hatchend, canonical)
  
  clutch_df <- clutch_df %>%
    left_join(canonical_links, by = c("sire", "dam", "hatchend")) %>%
    mutate(
      site_priority = ifelse(is.na(canonical), "0.5", site_priority),
      canonical = ifelse(is.na(canonical), glue("/panther-chameleons-for-sale/{sire}/{dam}/{`hatchend`}/{`babies-name`}/"), canonical)
    )
  clutch_df
}