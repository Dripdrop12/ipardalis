require(stringr)
require(fs)
require(glue)
require(readr)
require(dplyr)

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
  breeder_dir <- glue("content/blog/{breeder}/")
  gramps_report <- path(breeder_dir, "chams_det_ancestor_report.html")
  dir_create(breeder_dir)
  if (!dir_exists("~/chams_det_ancestor_report/")) stop("Re-run Gramps Report")
  dir_copy("~/chams_det_ancestor_report/", breeder_dir, overwrite = TRUE)
  dir_delete("~/chams_det_ancestor_report/")
  file_move("~/chams_det_ancestor_report.html", gramps_report)
  
  read_lines("content/blog/arti/index.md") %>%
    str_replace_all(regex("arti", ignore_case = TRUE), breeder) %>% 
    replace_gramps_txt(clean_txt(gramps_report, breeder)) %>%
    add_lineage(sire, dam, filial) %>%
    add_tags(tags) %>%
    update_category(sex) %>%
    add_birth_date(birth) %>%
    write_lines(glue("content/blog/{breeder}/index.md"))
  
  file.edit(glue("content/blog/{breeder}/index.md"))
} 

clean_txt <- function(location, breeder) {
  
  read_lines(location) %>%
    .[-(1:grep("<body>", .))] %>%
    str_replace_all(" class=\".*\"", "") %>%
    str_replace_all(" in ", " at ") %>%
    str_replace("born at", "produced by") %>%
    str_replace("died at", "died with") %>%
    str_replace("/home/jon/chams_det_ancestor_report/", glue("/blog/{breeder}/")) %>%
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
    sire_txt <- glue(": [{sire$name}]({{{{< ref \"/blog/{sire$name}/index.md\" >}}}})")
  } else {
    sire_id <- str_to_lower(sire$name) %>% str_replace("[:SPACE:]", "-")
    sire_txt <- glue(": [{sire$name}]({{{{< ref \"/blog/{sire$loc}#{sire_id}\" >}}}})")
  }
  
  if (dam$loc == "") {
    dam_txt <- glue(": [{dam$name}]({{{{< ref \"/blog/{dam$name}/index.md\" >}}}})")
  } else {
    dam_id <- str_to_lower(dam$name) %>% str_replace("[:SPACE:]", "-")
    dam_txt <- glue(": [{dam$name}]({{{{< ref \"/blog/{dam$loc}#{dam_id}\" >}}}})")
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
  sex <- tolower(sex)
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
