library("tidyverse")
library("viridis")
library("patchwork")


values <- seq(1, 2, length.out = 30)
choose_colors <- function(n = 30, ...) {
  cols <- viridis_pal(...)(n)
  return(cols)
}
bground <- "black"


dist_function <- function(col, mean, sd) {
  stat_function(
    fun = dnorm,
    args = list(mean = mean, sd = sd), color = col)
  }

dist_1 <- ggplot(data = tibble(x = c(-8, 8)), aes(x = x)) +
  theme_mono(color = bground) +
  coord_cartesian(xlim = c(-8, 7), ylim = c(-0.1, 0.45), expand = F) +
  mapply(dist_function, mean = 0, sd = values,
         col = choose_colors(option = "C", end = 0.95))

dist_2 <- ggplot(data = tibble(x = c(-8, 8)), aes(x = x)) +
  theme_mono(color = bground) +
  coord_cartesian(xlim = c(-7, 8), ylim = c(-0.1, 0.45), expand = F) +
  mapply(dist_function, mean = 0, sd = values,
         col = choose_colors(option = "D", end = 0.95))

all_dists <- dist_1 + dist_2

pixels_wide <- 6000
pixels_high <- 3000
file_name <- paste0("two_guassians_", bground, ".png")

ggsave(
  filename = file_name,
  plot = all_dists,
  width = pixels_wide / 300, height = pixels_high / 300,
  units = "in",
  dpi = 300
)
