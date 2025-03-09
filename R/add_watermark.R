require(magick)
require(purrr)
require(stringr)

watermark <- image_read("static/img/iPardalis-watermark-black.png")
add_watermark <- function(image_path, watermark) {
  base_img <- image_read(image_path)
  out <- image_composite(base_img, image_scale(watermark, "150"), gravity = "north")
  image_write(out, image_path)
}

watermark_dir <- function(img_dir, recurse = TRUE, skip_webp = TRUE) {
  if (skip_webp) glob = "*.JPG|*.jpg" else glob = "*.JPG|*.jpg|*.webp"
  imgs <- fs::dir_ls(img_dir, glob = glob, recurse = recurse)
  map(imgs, add_watermark, watermark)
}

gen_webp_dir <- function(img_dir, img_name) {
  
  old_webp <- fs::dir_ls(img_dir, glob = "*.webp")
  fs::file_delete(old_webp)
  
  img_path <- fs::path(img_dir, img_name)
  system2(
    command = "cwebp",
    args = glue::glue(" -q 100 {img_path}.jpg -o {img_path}.webp"))
}