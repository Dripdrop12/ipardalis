require(stringr)
require(fs)
require(glue)

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
  
  dir_copy("~/chams_det_ancestor_report/", glue("static/blog/{breeder}/"), overwrite = TRUE)
  writeLines(txt)
}

