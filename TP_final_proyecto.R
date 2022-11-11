library(haven)
library(dplyr)
library(ggplot2)

# Reading values from URL
valuesFromFile <- read_dta(file =  "https://www.noamlupu.com/argentina_ecological_data.dta")

# Get elements with year > 1920
valuesBiggerThan1920 <- filter(valuesFromFile, year > 1920)

# Select columns
selectedValues <- select(valuesBiggerThan1920, total,pop, year, province, department)
buenosAiresValues <- filter(selectedValues, province == "Buenos Aires")
buenosAiresByDepartment <- filter(buenosAiresValues, department == "25 de Mayo")

# Create new column with percent of people voting per year
newTable <- mutate(buenosAiresByDepartment, percent_pop_per_year=total*100/pop)

ggplot(newTable, aes(x=year, y=percent_pop_per_year)) + geom_line(color="blue") + theme_linedraw() + scale_y_continuous(limits=c(0, 100))