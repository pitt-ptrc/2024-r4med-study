# the purpose of this demo is to filter, group, and summarize data.
# We put the results into tables. In the process, we'll motivate modifying data
# 1. read in trials data and do some filters and counts

library(dplyr)
library(janitor)

?medicaldata::strep_tb

strep_tb <- medicaldata::strep_tb |> as_tibble()

strep_tb |>
  glimpse()

strep_tb |>
  count(arm, gender)

strep_tb |>
  count(arm, improved)

strep_tb |>
  tabyl(arm, improved)

# more traditional
with(strep_tb, table(arm, improved))

strep_tb |>
  filter(arm == "Control") |>
  filter(rad_num <= 2)

strep_tb |>
  filter(arm == "Control") |>
  filter(rad_num <= 2) |>
  count(baseline_temp, baseline_cavitation)


# 2. group the data, and summarize

library(tidyr)

strep_base <-
  strep_tb |>
  select(arm, baseline_condition, gender, rad_num) |>
  separate(baseline_condition, into = c("baseline_num", "baseline_cond")) |>
  mutate(baseline_num = as.numeric(baseline_num))

strep_base_sum <-
  strep_base |>
  group_by(arm) |>
  summarise(
    n_pt = n(),
    mean_baseline = mean(baseline_num),
    mean_outcome = mean(rad_num)
  )


strep_base_sum

# 3. show an example of kable, gt, table1 with gtsummary, and move to quarto

library(knitr)
library(gt)
library(gtsummary)

strep_base_sum |>
  kable(digits = 3)

strep_base_sum |>
  gt()

strep_base_sum |>
  gt() |>
  fmt_number(decimals = 1) |>
  tab_style(
    style = cell_text(weight = "bold"),
    locations = cells_body(
      columns = mean_outcome,
      rows = mean_outcome >= 2
    )
  )

# now we move to the file analysis.qmd
