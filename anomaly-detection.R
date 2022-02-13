require(readr)
require(tibble)
require(tsibble)
require(anomalize)
require(dplyr)
require(feasts)
require(ggplot2)

require(dtwclust)

clients <- read_csv("ts_2.csv") %>%
   as_tsibble(., key = Client_ID, index = Date)
glimpse(clients, width = 60)

result_13252 <- clients %>%
  filter(Client_ID == 4) %>%
  time_decompose(Value, merge = TRUE) %>%
  anomalize(remainder) %>%
  time_recompose()

result_13252 %>% plot_anomaly_decomposition()

result_13252 %>% plot_anomalies()

result_13252 %>%
  plot_anomalies() +
  geom_line()