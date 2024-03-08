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

# list(sire="", dam="", hatchend="") %>% create_listings()
create_listings <- function(filters = list(sire="", dam="", hatchend=""), draft = FALSE, overwrite = TRUE, gen_webp = FALSE){
  new_listings <- get_clutch_df() %>%
    filter(
      if (filters$sire != "") sire == filters$sire else rep(T, nrow(.)),
      if (filters$dam != "") dam == filters$dam else rep(T, nrow(.)),
      if (filters$hatchend != "") hatchend == ymd(filters$hatchend) else rep(T, nrow(.))
    )
  on.exit({new_listings <<- new_listings; baby <<- baby})
  
  canonical_links <- new_listings %>% 
    group_by(sire, dam, hatchend) %>% 
    filter(`babies-primary`) %>% 
    mutate(canonical = glue("/panther-chameleons-for-sale/{sire}/{dam}/{`hatchend`}/{`babies-name`}/")) %>%
    select(sire, dam, hatchend, canonical)
  
  new_listings <- new_listings %>%
    left_join(canonical_links, by = c("sire", "dam", "hatchend")) %>%
    mutate(
      canonical = ifelse(is.na(canonical), glue("/panther-chameleons-for-sale/{sire}/{dam}/{`hatchend`}/{`babies-name`}/"), canonical)
    )
  
  for(row in 1:nrow(new_listings)) {
    # Setup
    baby <- new_listings %>% slice(row)
    listing_dir <- glue("content/panther-chameleons-for-sale/{baby$sire}/{baby$dam}/{baby$hatchend[[1]]}")
    if (!dir_exists(listing_dir)) dir_create(listing_dir, recurse = TRUE)
    
    # Lineage tree check
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
    
    # Pricing
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
    
    # Image search
    img_dir <- fs::path("static", fs::path_dir(baby$`babies-image`))
    img_name <- baby$`babies-name`
    pos_img <- fs::dir_ls(img_dir, glob = "*.jpg")
    img_list <- pos_img[str_detect(pos_img, regex(glue("{img_name}\\.|{img_name}_")))]
    img_df <- tibble(
      imgs = stringr::str_remove(img_list, "static"),
      baby_name = baby$`babies-name`,
      baby_sire = str_to_title(baby$sire),
      baby_dam = str_to_title(baby$dam),
      baby_hatchend = baby$hatchend,
      img_date = lubridate::as_date(fs::file_info(img_list)$modification_time, "%Y-%m-%d")
    )
    if (gen_webp){
      img_path <- fs::path_wd("/static", baby$`babies-image`)
      old_webp <- fs::dir_ls(img_dir, glob = "*.webp")
      del_webp <- old_webp[str_detect(old_webp, img_name)]
      fs::file_delete(del_webp)
      system2(
        command = "cwebp",
        args = glue::glue(" -q 100 {img_path}.jpg -o {img_path}.webp"))
    }
    
    
    baby %>% 
      mutate(draft = draft, base_price = base_price) %>%
      glue_data(
        read_lines("R/sample-product.md") %>%
          append(.,
            values = img_df %>% glue_data("  {{{{{{{{< figure src=\"{imgs}\" caption=\"{baby_name} - {baby_sire} x {baby_dam} (hatched {baby_hatchend} | pictured {img_date}) | Ambilobe Panther Chameleons for sale\" >}}}}}}}}"), 
            after = str_which(., " gallery ")) %>%
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

