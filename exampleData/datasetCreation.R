library(tidyverse)


## Squirrel data 
s_raw = read_csv("Desktop/CyberSquirrel1/CyberSquirrel-map_data.csv", show_col_types = FALSE)

s_clean = s_raw |>
  mutate(id = row_number(),
         year = lubridate::year(Date),
         numAttacks = 1) |>
  rename(place = `City/Town`,
         state = `State/Provence`) |>
  select(id, year, animal = Opperative, place, numAttacks
         )

write.csv(s_clean, "~/Desktop/squirrels.csv", row.names = F)

## Wine Data 
wine_r = read_csv("Desktop/archive 2/winemag-data_first150k.csv")

set.seed(123)
wine_c = wine_r |>
  slice_sample(n = 1000)|>
  select(country, points, price, variety, province)
  
write.csv(wine_c, "~/Desktop/wine.csv", row.names = F)

## Songs Data 
songs_r = read_csv("Desktop/song_data.csv") 

songs_c = songs_r |>
  slice_sample(n = 1000) |>
  mutate(key = case_when(
    key == 0 ~ "A",
    key == 1 ~ "Bb",
    key == 2 ~ "B",
    key == 3 ~ "C",
    key == 4 ~ "Db",
    key == 5 ~"D",
    key == 6 ~ "Eb",
    key == 7 ~ "E",
    key == 8 ~ "F",
    key == 9 ~ "Gb",
    key == 10 ~ "G",
    key == 11 ~ "Ab"
  )) |>
  select(name = song_name, length = song_duration_ms, popularity = song_popularity, key, danceability)

write.csv(songs_c, "~/Desktop/song_data.csv", row.names = F)


### CFB data 
college_r = read_csv("Desktop/data.csv") |>
  select(home_team, home_conference, home_points, away_team, away_conference, away_points,excitement_index) |>
  mutate(home_win = if_else(home_points > away_points, TRUE, FALSE))

write.csv(college_r, "~/Desktop/footballGames.csv", row.names = F)

### Cal Fires 
cal_f = read_csv("Desktop/California_Fire_Incidents.csv")

cal_c = cal_f |>
  select(AcresBurned, year = ArchiveYear, county = Counties,
         Injuries, Fatalities,Helicopters)

write.csv(cal_c, "~/Desktop/calFires.csv", row.names = F)

### Restaurants 
sf_r = read_csv("Desktop/Restaurant_Scores_-_LIVES_Standard.csv") |>
  slice_sample(n = 1000)

sf_c = sf_r |>
  mutate(highRisk = if_else(risk_category == "High Risk", TRUE, FALSE),
         isViolation = if_else(!is.na(violation_id), TRUE, FALSE)) |>
  select(name = business_name, city = business_city,business_postal_code, inspection_date, risk_category, isViolation, highRisk) 

write.csv(sf_c, "~/Desktop/resaturantViolations.csv", row.names = F)
