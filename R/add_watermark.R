require(magick)
require(purrr)
watermark <- image_read("static/img/iPardalis-watermark-black.png")
add_watermark <- function(image_path, watermark) {
  base_img <- image_read(image_path)
  out <- image_composite(base_img, image_scale(watermark, "150"), gravity = "center")
  image_write(out, image_path)
}

watermark_dir <- function(img_dir, recurse = TRUE) {
  imgs <- fs::dir_ls(img_dir, glob = "*.JPG|*.jpg|*.webp", recurse = recurse)
  map(imgs, add_watermark, watermark)
}