

firstup <- function(x) {
  substr(x, 1, 1) <- toupper(substr(x, 1, 1))
  x
}

build_a_links <- function(user = "jvcasillas", platform = "github") {
  a_link   <- paste0("https://", platform, ".com/", user)
}

build_img_links <- function(user = "jvcasillas", platform = "github") {
  if (platform == "twitter") {
    img_link <- paste0("https://img.shields.io/", platform, "/follow/", user,
                       "?label=", firstup(platform), "&style=social")
  } else {
    img_link <- paste0("https://img.shields.io/", platform, "/followers/", user,
                       ".svg?label=", firstup(platform), "&style=social")
  }
}

build_img <- function(user = "jvcasillas", platform = "github", alt = "") {
  link <- build_img_links(user, platform)
  out  <-  paste0('<img src="', link, '" alt="', alt, '">')
}

spit_html <- function(user, platform, alt = "") {
  a_link <- build_a_links(user, platform)
  img    <- build_img(user, platform, alt = alt)

  a_open  <- paste0('<a href="', a_link, '">')
  a_close <- paste0("</a>")

  cat(
    paste0("\n", a_open, "\n", "  ", img, "\n", a_close, "\n")
  )
}

