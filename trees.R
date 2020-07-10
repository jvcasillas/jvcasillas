# Libraries -------------------------------------------------------------------

library(tidyverse)
library(ambient)
library(scico)
library(here)
library(flametree)
library(ggforce)
library(paletteer)
library(patchwork)

# -----------------------------------------------------------------------------





# New tree --------------------------------------------------------------------

new_tree <- bind_rows(
  flametree_grow(
    seed = 98,
    time = 11,
    scale = c(0.8, 0.9),
    angle = c(-5, 5, 10),
    split = 2,
    prune = 0.1) %>%
    mutate(tree_num = 1),
  flametree_grow(
    seed = 89,
    time = 11,
    scale = c(0.8, 0.9),
    angle = c(-10, 10, 0),
    split = 3,
    prune = 0.2) %>%
    mutate(tree_num = 2),
  flametree_grow(
    seed = 85,
    time = 11,
    scale = c(0.8, 0.9),
    angle = c(5, -5, -10),
    split = 2,
    prune = 0) %>%
    mutate(tree_num = 3))

# -----------------------------------------------------------------------------





# Theme helpers ---------------------------------------------------------------

# a blank theme with a monochromatic background
theme_mono <- function(color = "black") {
  ggplot2::theme_void() +
    ggplot2::theme(
      panel.background = ggplot2::element_rect(
        fill = color,
        colour = color
      )
    )
}

palette <- "viridis"
bground <- "white"

# -----------------------------------------------------------------------------





# Plot and save ---------------------------------------------------------------

tree1 <- new_tree %>%
  filter(tree_num == 1) %>%
  ggplot(
    data = .,
    mapping = aes(
      x = coord_x,
      y = coord_y,
      group = id_path,
      size = seg_wid,
      color = seg_col)
  ) +
  geom_bezier2(show.legend = FALSE, lineend = "round") +
  scale_color_paletteer_c(palette = paste0("viridis::", palette)) +
  theme_mono(color = bground)

tree2 <- new_tree %>%
  filter(tree_num == 2) %>%
  ggplot(
    data = .,
    mapping = aes(
      x = coord_x,
      y = coord_y,
      group = id_path,
      size = seg_wid,
      color = seg_col)
  ) +
  geom_bezier2(show.legend = FALSE, lineend = "round") +
  scale_color_paletteer_c(palette = paste0("viridis::", palette)) +
  theme_mono(color = bground)

tree3 <- new_tree %>%
  filter(tree_num == 3) %>%
  ggplot(
    data = .,
    mapping = aes(
      x = coord_x,
      y = coord_y,
      group = id_path,
      size = seg_wid,
      color = seg_col)
  ) +
  geom_bezier2(show.legend = FALSE, lineend = "round") +
  scale_color_paletteer_c(palette = paste0("viridis::", palette)) +
  theme_mono(color = bground)

all_trees <- tree1 + tree2 + tree3

pixels_wide <- 6000
pixels_high <- 3000
file_name <- paste0("three_trees_", bground, "_", palette, ".png")

ggsave(
  filename = file_name,
  plot = all_trees,
  #path = here("img"),
  width = pixels_wide / 300, height = pixels_high / 300,
  units = "in",
  dpi = 300
)


# -----------------------------------------------------------------------------
