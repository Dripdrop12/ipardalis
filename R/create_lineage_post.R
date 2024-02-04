require(stringr)
require(fs)
require(glue)
require(readr)
require(dplyr)
require(yaml)
require(tidyr)
require(lubridate)
require(purrr)

create_lineage_post <- function(
  breeder = "jude",
  birth = "",
  sex = "male",
  tags = c(),
  filial = "",
  sire = list(
    name = "",
    loc = ""
  ),
  dam = list(
    name = "",
    loc = ""
  )) {
  
  # Create blog directory and delete old gramps data
  breeder_dir <- glue("content/blog/{str_to_lower(breeder)}/")
  gramps_report <- path(breeder_dir, "Family Tree 1_det_ancestor_report.html")
  dir_create(breeder_dir)
  if (!dir_exists("~/Family Tree 1_det_ancestor_report/")) stop("Re-run Gramps Report")
  dir_copy("~/Family Tree 1_det_ancestor_report/", breeder_dir, overwrite = TRUE)
  dir_delete("~/Family Tree 1_det_ancestor_report/")
  file_move("~/Family Tree 1_det_ancestor_report.html", gramps_report)
  
  read_lines("content/blog/arti/index.md") %>%
    add_title(breeder) %>%
    str_replace_all(regex("arti", ignore_case = TRUE), breeder) %>% 
    replace_gramps_txt(clean_txt(gramps_report)) %>%
    add_lineage(sire, dam, filial) %>%
    add_tags(tags) %>%
    update_category(sex) %>%
    add_birth_date(birth) %>%
    write_lines(glue("content/blog/{str_to_lower(breeder)}/index.md"))
  
  file.edit(glue("content/blog/{str_to_lower(breeder)}/index.md"))
}

get_clutch_df <- function(clutch_dir = "data/clutches/") {
  clutch_list <- dir_map(clutch_dir, read_yaml, type = "file")
  clutch_df <- as.data.frame(do.call(bind_rows, clutch_list))
  
  # Clean data
  clutch_df <- clutch_df %>%
    filter(listed == TRUE) %>%
    unnest_wider(babies, names_sep = "-") %>%
    mutate(across(c(laid, hatchstart, hatchend), ymd)) %>% 
    filter(is.na(`babies-sold`) | is.na(`babies-name`)) %>%
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
      Photo_Urls = glue("{ifelse(is.na(`babies-image`), list(`babies-images`), `babies-image`)}.jpg")
    )

  clutch_df
}

update_google <- function(df = get_clutch_df()){
  df %>% 
    mutate(id = Animal_Id, 
           description = str_squish(Desc), 
           condition = "New",
           link = glue("https://ipardalis.com/babies/{sire}/{dam}/{hatchend}/{`babies-name`}/"),
           image_link = glue("https://ipardalis.com/{`babies-image`}.jpg"),
           additional_image_link = glue("https://ipardalis.com/{image}.jpg"),
           availability = "in_stock", 
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

create_listings <- function(filters = list(sire="", dam="", hatchend=""), draft = FALSE, overwrite = TRUE){
  listings <- get_clutch_df() %>%
    filter(
      if (filters$sire != "") sire == filters$sire else rep(T, nrow(.)),
      if (filters$dam != "") dam == filters$dam else rep(T, nrow(.)),
      if (filters$hatchend != "") hatchend == ymd(filters$hatchend) else rep(T, nrow(.))
    )
  on.exit(baby <<- baby)
  for(row in 1:nrow(listings)) {
    baby <- listings %>% slice(row)
    # (printf  "%s/%s/%s/%s.md" .sire .dam .hatchend .name)
    listing_dir <- glue("content/babies/{baby['sire']}/{baby['dam']}/{baby['hatchend'][[1]]}")
    if (!dir_exists(listing_dir)) dir_create(listing_dir, recurse = TRUE)
    if (!file_exists(path("content/blog", baby$dam, "tree.png"))) {
      dam_tree_missing <- TRUE
    } else {
      dam_tree_missing <- FALSE
    }
    if (!file_exists(path("content/blog", baby$sire, "tree.png"))) {
      sire_tree_missing <- TRUE
    } else {
      sire_tree_missing <- FALSE
    }
    base_price <- ifelse(baby["Sex"][[1]]=="Male", baby["maleprice"][[1]], baby["femaleprice"][[1]])
    markup <- baby["babies-price"][[1]] > base_price
    discount <- baby["babies-price"][[1]] < base_price
    if (markup) {
      strike_price <- paste0("markup_price: ", baby["babies-price"][[1]])
    } else if (discount) {
      strike_price <- paste0("discount_price: ", baby["babies-price"][[1]])
    } else {
      strike_price <- ""
    }
    
    baby %>% 
      mutate(draft = draft, base_price = base_price) %>%
      glue_data(
        read_lines("R/sample-product.md") %>%
          (function(txt){
            if (dam_tree_missing) txt <- delete_item(txt, "dam_tree")
            if (sire_tree_missing) txt <- delete_item(txt, "sire_tree")
            return(txt)
          }) %>%
          str_replace("stringrreplacement:", strike_price) %>%
          glue_collapse(sep="\n")) %>%
      write_lines(glue("{listing_dir}/{baby['babies-name'][[1]]}.md"), append = !overwrite)
  }
}

clean_txt <- function(location) {
  
  read_lines(location) %>%
    .[-(1:grep("<body>", .))] %>%
    str_replace_all(" class=\".*\"", "") %>%
    str_replace_all(" in ", " at ") %>%
    str_replace("born at", "produced by") %>%
    str_replace("died at", "died with") %>%
    str_replace("/home/jonathan/Family Tree 1_det_ancestor_report/", "") %>%
    str_remove("</html>") %>%
    str_remove("</body>")
}

replace_gramps_txt <- function(txt, gramps_txt) {
  gramps_loc <- str_which(txt, "rawhtml")
  old_gramps <- (gramps_loc[1] + 1):(gramps_loc[2] - 1)
  txt <- txt[!1:length(txt) %in% old_gramps]
  txt <- append(txt, gramps_txt, gramps_loc[1])
  
  return(txt)
}

add_lineage <- function(txt, sire, dam, filial) {
  sire_loc <- str_which(txt, "Sire") + 1
  dam_loc <- str_which(txt, "Dam") + 1
  filial_loc <- str_which(txt, "Filial") + 1
  
  if (sire$loc == "") {
    sire_txt <- glue(": [{str_to_title(sire$name)}]({{{{< ref \"/blog/{str_to_lower(sire$name)}/index.md\" >}}}})")
  } else {
    sire_id <- str_to_lower(sire$name) %>% 
      str_remove_all("[()]") %>% 
      str_replace_all("[:SPACE:]", "-") 
    sire_txt <- glue(": [{str_to_title(sire$name)}]({{{{< ref \"/blog/{sire$loc}#{sire_id}\" >}}}})")
  }
  
  if (dam$loc == "") {
    dam_txt <- glue(": [{str_to_title(dam$name)}]({{{{< ref \"/blog/{str_to_lower(dam$name)}/index.md\" >}}}})")
  } else {
    dam_id <- str_to_lower(dam$name) %>% 
      str_remove_all("[()]") %>% 
      str_replace_all("[:SPACE:]", "-") 
    dam_txt <- glue(": [{str_to_title(dam$name)}]({{{{< ref \"/blog/{dam$loc}#{dam_id}\" >}}}})")
  }
  
  filial_txt <- glue(": *{filial}*")
  
  txt[sire_loc]   <- sire_txt
  txt[dam_loc]    <- dam_txt
  txt[filial_loc] <- filial_txt
  
  return(txt)
}

add_tags <- function(txt, tags) {
  tags_c <- paste0('"', str_c(tags, collapse = "\", \""), '"')
  tags_loc <- str_which(txt, "tags =")
  tags_text <- glue("tags = [{tags_c}]")
  txt[tags_loc] <- tags_text
  
  return(txt)
}

update_category <- function(txt, sex) {
  cat_loc <- str_which(txt, "categories = ")
  sex <- str_to_lower(sex)
  if (sex == "male") {
    cat_text <- "ambilobe-sires"
  } else {
    cat_text <- "ambilobe-dams"
  }
  txt[cat_loc] <- glue("categories = [\"{cat_text}\"]")
  
  return(txt)
}

add_birth_date <- function(txt, birth) {
  birth_loc <- str_which(txt, "date = ")
  txt[birth_loc] <- glue("date = \"{birth}\"")
  
  return(txt)
}

add_title <- function(txt, breeder) {
  title_loc <- str_which(txt, "title = ")
  txt[title_loc] <- glue("title = \"{str_to_title(breeder)}\"")
  
  return(txt)
}

delete_item <- function(txt, key) {
  key_loc <- str_which(txt, key)
  txt <- txt[-key_loc]
  
  return(txt)
}

add_items <- function(txt, key, vals) {
  items_c <- paste0('"', str_c(vals, collapse = "\", \""), '"')
  items_loc <- str_which(txt, key)
  items_text <- glue("{key} [{items_c}]")
  txt[items_loc] <- items_text
  
  return(txt)
}