library(tidyverse)
library(janitor)

df <- read_csv('~/Python/test_pokemon.csv')
df <- clean_names(df)

# Observe the data
head(df)

# Cleaning
df <- df %>% 
  rowwise() %>% 
  mutate(base_total=sum(hp, attack, defense)) %>% 
  select(number:defense, base_total, sp_atk:legendary) 

# Ploting
# Legendary non legendary ratio: 
df %>% 
  ggplot() +
  geom_bar(mapping=aes(x=type1, fill=legendary)) + 
  theme(axis.text.x=element_text(angle=60)) +
  annotate(geom="rect", 
           xmin=2.2, xmax=3.8, 
           ymin=8, ymax=15, 
           alpha=0.5, 
           color='yellow', fill='yellow') +
  annotate(geom="curve", 
           x=5, y=60, 
           xend=3, yend=16, 
           curvature=0.3, 
           arrow=arrow(length=unit(5, "mm")), 
           color='black') +
  annotate(geom="text",
           x=5, y=65,
           label="The best ratio") +
  labs(title="Legendary Pokemons Ration",
       subtitle="Pokemon Trading Card Game (December 1998)",
       captions="Created by Artyom Pak",
       x="Pokemon Type",
       y="Count")
  