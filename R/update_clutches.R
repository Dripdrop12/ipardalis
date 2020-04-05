for (clutch_file in fs::dir_ls("data/clutches")) {
  clutch <- yaml::read_yaml(clutch_file)
  for(i in 1:length(clutch$babies)) 
    clutch$babies[[i]]$image <- stringr::str_replace_all(clutch$babies[[i]]$image, "\\.$", "")
  
  yaml::write_yaml(clutch, clutch_file)
}
