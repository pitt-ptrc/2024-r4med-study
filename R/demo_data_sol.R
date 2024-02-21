# Solutions for session 1
# the purpose of this demo is to get you comfortable examining data

# load fake data ---------------------------------------------------------------

library(tidyverse)
library(janitor)


df <- read_csv("data/df.csv")

df |> select(starts_with("v"))


# load real data ----------------------------------------------------------
## use library() to look at {medicaldata}

# this does print nicely at the console
medicaldata::blood_storage

?medicaldata::blood_storage

# this does
medicaldata::scurvy

# this cleans up the first one
bs <- medicaldata::blood_storage |>
  as_tibble() |>
  clean_names()



strep_tb <- medicaldata::strep_tb



scurvy

strep_tb |>
  glimpse()

strep_tb |>
  select(patient_id, starts_with("base"))

# load redcap data --------------------------------------------------------
# this is an example of "wide" data. In this case, `tidyselect` is helpful.

rc <- read_csv("data/redcap.csv")

rc |> glimpse()

rc |> select(record_id, starts_with("sym"))

rc |> select(where(is.character))

rc |> select(record_id, ends_with("name"))

# the meaning of the data is unclear, can we do better?

rc_lab <- read_csv("data/redcap_lab.csv")

rc_lab |>
  select(`Record ID`, contains("following"))
