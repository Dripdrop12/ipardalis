require(stringr)
require(fs)
require(glue)
require(readr)
require(dplyr)
require(yaml)
require(tidyr)
require(lubridate)
require(purrr)
source("R/add_watermark.R")

create_lineage_post <- function(
  breeder = "jude",
  birth = "",
  sex = "male",
  tags = c(),
  filial = "",
  primary_img = "",
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
    add_webp(primary_img) %>%
    write_lines(glue("content/blog/{str_to_lower(breeder)}/index.md"))
  
  file.edit(glue("content/blog/{str_to_lower(breeder)}/index.md"))
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
  title_loc <- str_which(txt, "title = 'Arti'")
  txt[title_loc] <- glue("title = \"{str_to_title(breeder)}\"")
  
  return(txt)
}

add_webp <- function(txt, primary_img) {
  banner_loc <- str_which(txt, "banner = ")
  txt[banner_loc] <- glue("banner = \"{primary_img}\"")
  
  img_dir <- fs::path("static", fs::path_dir(primary_img))
  watermark_dir(img_dir)
  gen_webp_dir(
    img_dir = img_dir, 
    img_name = fs::path_file(primary_img)
  )
  
  return(txt)
}
