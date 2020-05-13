library(hexSticker)
library(showtext)
## Loading Google fonts (http://www.google.com/fonts)
font_add_google("Graduate")
## Automatically use showtext to render text for future devices
showtext_auto()

## use the ggplot2 example
imgurl <- here::here("inst", "figures/john_belushi.png")
imgurl <- system.file("figures/john_belushi.png", package="hexSticker")
sticker(imgurl, package="schoolcolors", p_size=16, s_x=1, s_y=.75, s_width=.3,
        p_family = "Graduate", filename="inst/figures/schoolcolors.png",
        h_fill = "#082567", h_color = "#FFD700")
