require(stringr)
require(fs)
require(glue)
require(readr)
require(dplyr)

clean_txt <- function(breeder = "blossom") {
  
  txt <- readLines("~/chams_det_ancestor_report.html") %>%
    .[-(1:grep("<body>", .))] %>%
    str_replace_all(" class=\".*\"", "") %>%
    str_replace_all(" in ", " at ") %>%
    str_replace("born at", "produced by") %>%
    str_replace("died at", "died with") %>%
    str_replace("/home/jon/chams_det_ancestor_report/", glue("/blog/{breeder}/")) %>%
    str_remove("</html>") %>%
    str_remove("</body>")
  
  dir_copy("~/chams_det_ancestor_report/", glue("content/blog/{breeder}/"), overwrite = TRUE)
  writeLines(txt)
}

cham_data <- readr::read_csv("~/chams.csv") %>%
  slice(1:(grep("Place", .data$Person) - 1))

family_data <- cham_data %>% 
  slice((grep("Family", .data$Person)+1):nrow(.)) %>%
  select(Person, Surname) %>%
  rename(Family = Person, Child = Surname)
  
marriage_data <- cham_data %>%
  slice((grep("Marriage", .data$Person)+1):(grep("Family", .data$Person) -1)) %>%
  select(Person, Surname, Given) %>%
  rename(Family = Person, Husband = Surname, Wife = Given)

combined_family <- left_join(family_data, marriage_data, by = "Family")
