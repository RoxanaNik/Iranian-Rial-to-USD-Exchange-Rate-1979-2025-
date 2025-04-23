


# Install required packages if not already installed
if (!require(ggplot2)) install.packages("ggplot2")
if (!require(gganimate)) install.packages("gganimate")
if (!require(gifski)) install.packages("gifski")

# Load libraries
library(ggplot2)
library(gganimate)
library(scales)  # For formatting numbers with commas

# Create data frame
data <- data.frame(
  Year = c(1979, 1980, 1981, 1982, 1983, 1984, 1985, 1986, 1987, 1988, 1989, 1990, 1991, 1992, 1993, 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025),
  Exchange_Rate = c(70, 71, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 1500, 1750, 1750, 1750, 1750, 1750, 1750, 1750, 1750, 7900, 8200, 8600, 8900, 9200, 9400, 9100, 9900, 10300, 10800, 12260, 18517, 25780, 29970, 31000, 33127, 42000, 42000, 42000, 42000, 41850, 42000, 767550, 820500)
)

# Create the plot
p <- ggplot(data, aes(x = Year, y = Exchange_Rate)) +
  geom_line(color = "blue", size = 1.2) +
  geom_point(aes(group = seq_along(Year)), color = "blue", size = 2) +  # Point for animation
  geom_text(aes(label = scales::comma(Exchange_Rate)), 
            vjust = -0.5, hjust = 0.5, color = "blue", size = 4) +  # Annotation
  scale_y_log10(labels = scales::comma, limits = c(50, 1000000)) +  # Logarithmic y-axis
  scale_x_continuous(breaks = seq(1979, 2025, by = 5)) +  # X-axis breaks every 5 years
  labs(
    title = "Iranian Rial to USD Exchange Rate (1979-2025)",
    x = "Year",
    y = "Exchange Rate (IRR per USD)"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 14, hjust = 0.5, margin = margin(b = 20)),
    axis.text.x = element_text(angle = 45, hjust = 1),
    axis.title = element_text(size = 12),
    panel.grid.major = element_line(color = "gray80", linetype = "dashed"),
    panel.grid.minor = element_line(color = "gray90", linetype = "dashed")
  ) +
  transition_reveal(Year)  # Animate by revealing data along Year

# Render and save the animation
anim <- animate(p, 
                nframes = nrow(data),  # One frame per year
                fps = 20,              # 20 frames per second
                width = 800,           # Pixel width
                height = 600,          # Pixel height
                renderer = gifski_renderer("exchange_rate_animation.gif"))

# Optional: Display animation in RStudio viewer
# print(anim)