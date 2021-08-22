neonate_df <- readODS::read_ods("UVB_data.ods", row_names = FALSE)
DT::saveWidget(
  widget = DT::datatable(
    data = neonate_df, 
    width = 550, 
    rownames = FALSE,
    options = list(
      pageLength = -1,
      lengthMenu = list(c(-1, 15, 25), c("All", "15", "25")),
      sDom = '<"top">lrt<"bottom">ip'
    )
  ), 
  file = "dt1.html", 
  selfcontained = TRUE)
fs::file_move("dt1.html", "../../../static/dt/dt1.html")