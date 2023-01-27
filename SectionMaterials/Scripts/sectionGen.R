library(dplyr)

s101 = readr::read_csv("polsci-132b-2023-B_DIS-101_rosters.csv", show_col_types = F) |>
  mutate(section = 101)
s102 = readr::read_csv("polsci-132b-2023-B_DIS-102_rosters.csv", show_col_types = F) |>
  mutate(section = 102)

sections = bind_rows(list(s101,s102))

sections_clean = sections |>
  select(name = Name, section) |>
  tidyr::separate(name, into = c("last", "first"), sep = ",")|>
  mutate(first = trimws(first))|>
  select(-last)

write.csv(sections_clean, file = "sections.csv", row.names = F)
