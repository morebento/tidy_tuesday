library(tidyverse)
library(tidytuesdayR)
library(ggthemes)
library(tidyquant)
library(janitor)

# see what data is available
tidytuesdayR::tt_available()

# download this week's data 
hbcu_data <- tidytuesdayR::tt_load("2021-02-02")

# save to rds
write_rds(hbcu_data, "hbcu_data.rds")

# subset the hbcu_all data
hbcu_all_tbl <- hbcu_data$hbcu_all

# preview the data
hbcu_all_tbl %>% glimpse()

# look at all the data vs time
hbcu_all_tbl %>%
    pivot_longer(-Year) %>%
    ggplot(aes(x=Year, y = value)) +
    geom_line(aes(colour=name)) +
    facet_wrap(vars(name), scales="free_y") +
    theme_fivethirtyeight() +
    labs(
        title = "All HBCU data vs Time",
        colour  = "Metric",
        y = "Value",
        caption = "TidyTuesday // 2020-02-02 // @benmoretti"
    )

# time series plot 
hbcu_all_tbl %>%
    select(Year, `Total - Private`, `Total - Public`, `Total enrollment`) %>%
    clean_names() %>%
    mutate(
        total_private_pct = total_private / total_enrollment,
        total_public_pct = total_public / total_enrollment
    ) %>%
    select(year, total_private_pct, total_public_pct) %>%
    pivot_longer(-year) %>%
    ggplot(aes(x=year, y=value)) +
    geom_line(aes(colour=name)) +
    theme_fivethirtyeight() +
    labs(
        title = "All HBCU data vs Time",
        colour  = "Metric",
        y = "Value",
        caption = "TidyTuesday // 2020-02-02 // @benmoretti"
    )

