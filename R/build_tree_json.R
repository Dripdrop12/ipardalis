require(xml2)

clean_xml <- function(
  xml_path = "~/chams.gramps",
  root = "Blossom") {
  
  xml_tree <- xml2::read_xml(xml_path)
  
  chams
}
