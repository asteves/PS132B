rm(list = ls())
library(foreign)
library(dplyr)
library(ggplot2)
library(GGally)
library(ggthemes)


# Basic data exploration --------------------------------------------------

#Loading mpg dataset
data(mpg)
?mpg

#Viewing
head(mpg)
#can also use the View() function

#Simplest summary
summary(mpg)

#Continuous variable distributions
min(mpg$hwy)
max(mpg$hwy)
mean(mpg$hwy)
median(mpg$hwy)
quantile(mpg$hwy, probs = c(0.1,0.9))

#Discrete variable distributions
table(mpg$year)
table(mpg$class)
table(mpg$class,mpg$year)
prop.table(table(mpg$class,mpg$year))
prop.table(table(mpg$class,mpg$year),margin = 1)
prop.table(table(mpg$class,mpg$year),margin = 2)

#Test of differences in means
t.test(mpg$hwy[mpg$year == 1999],
       mpg$hwy[mpg$year == 2008])
t.test(mpg$hwy[mpg$class == "compact"],
       mpg$hwy[mpg$class == "suv"])

#Correlations
cor(mpg$cty,mpg$hwy)
cor.test(mpg$cty,mpg$hwy)

mpg.sub <- mpg[,c("displ","year","cyl","cty","hwy")]
cor(mpg.sub)

#Quick and dirty plots
hist(mpg$cty)
plot(mpg$cty) #Only interesting if data are in particular order
plot(mpg$cty,mpg$hwy)


# Introducing ggplot ------------------------------------------------------

#Every ggplot2 plot has three key components:
#1. Data
#2. A set of aesthetic mappings between variables in the data 
#   and visual properties
#3. At least one layer which describes how to render each observation. 
#   Layers are usually created with a geom function.

#Nothing
ggplot(mpg)

#A canvas:
ggplot(mpg, aes(x = displ, y = hwy))

#Adding a plotting layer: Simple scatter plot
ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point()


# Examples of plots -------------------------------------------------------

#Two ways of breaking down the results above by groups 
#(in this case, by class):

ggplot(mpg, aes(x = displ, y = hwy, color = class)) + 
  geom_point()

ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point() + 
  facet_wrap(~class)

#Adding trend lines:

ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point()

ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth(method = "lm")

#Visualizing univariate distributions:

ggplot(mpg, aes(x = hwy)) + geom_histogram()

ggplot(mpg, aes(x = hwy)) + geom_freqpoly()

ggplot(mpg, aes(x = hwy)) + geom_density()

#Visualizing distributions for discrete variables:

ggplot(mpg, aes(x = manufacturer)) + geom_bar()

#Visualizing comparisons of distributions:

ggplot(mpg, aes(x = drv, y = hwy)) + geom_point() #This is not very useful

ggplot(mpg, aes(x = drv, y = hwy)) + geom_boxplot()

ggplot(mpg, aes(x = drv, y = hwy)) + geom_violin()


# Another ggplot example --------------------------------------------------

dat <- read.dta("Swiss_Panel_long.dta")
head(dat)
summary(dat)

#The data are structured at the municipality-year level.
#nat_rate is the naturalization rate.
#repdem is an indicator for whether the municipality in that year decided
#on naturalization applications through representative democracy (1)
#or direct democracy (0).

#Subsetting data for illustrative purposes
pdat <- subset(dat, year >= 2000 & muniID <= 20)

#Plotting all data points by year and nat_rate
ggplot(data = pdat, aes(x = year, y = nat_rate)) +
  geom_point()
ggplot(data = pdat, aes(x = year, y = nat_rate)) +
  geom_point() + 
  scale_x_continuous(breaks = seq(from = 2000, to = 2009))

#Plotting all data points by year and nat_rate, also with line
ggplot(data = pdat, aes(x = year, y = nat_rate)) +
  geom_point() + 
  scale_x_continuous(breaks = seq(from = 2000, to = 2009)) +
  geom_line()

#Plotting all data points by year and nat_rate, with the line now grouped
ggplot(data = pdat, aes(x = year, y = nat_rate, group = muni_name)) +
  geom_point() + 
  scale_x_continuous(breaks = seq(from = 2000, to = 2009)) + 
  geom_line()

#Plotting all data points by year and nat_rate, 
#grouped (with color) by municipality
ggplot(data = pdat, aes(x = year, y = nat_rate, color = muni_name)) +
  geom_point() + 
  scale_x_continuous(breaks = seq(from = 2000, to = 2009)) + 
  geom_line()

#Plotting all data points by year and nat_rate, 
#with municipalities in separate panels,
#and hard-coding the color of the points and lines
ggplot(data = pdat, aes(x = year, y = nat_rate)) +
  geom_point(color = "red") + 
  scale_x_continuous(breaks = seq(from = 2000, to = 2009)) + 
  geom_line(color = "steelblue") +
  facet_wrap(~ muni_name) + 
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1))

#Plotting all data points by year and nat_rate, 
#with municipalities in separate panels,
#with automatic different coloring across the municipalities
ggplot(data = pdat, aes(x = year, y = nat_rate, color = muni_name)) +
  geom_point() + 
  scale_x_continuous(breaks = seq(from = 2000, to = 2009)) + 
  geom_line() +
  facet_wrap(~ muni_name) +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1))

#Same as above, but eliminating the legend
ggplot(data = pdat, aes(x = year, y = nat_rate, color = muni_name)) +
  geom_point() + 
  scale_x_continuous(breaks = seq(from = 2000, to = 2009)) + 
  geom_line() +
  facet_wrap(~ muni_name) +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)) +
  theme(legend.position = "none") #to remove legend

#Plotting all data points by year and nat_rate, 
#with municipalities in separate panels,
#using barplots instead
ggplot(data = pdat, aes(x = year, y = nat_rate, fill = muni_name)) +
  scale_x_continuous(breaks = seq(from = 2000, to = 2009)) +
  geom_bar(stat = "identity") +
  facet_wrap(~ muni_name) +
  theme(legend.position = "none") + 
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)) +
  theme(panel.spacing.x = unit(2, "lines")) #to add space between the panels

#Plotting all data points by year and nat_rate, 
#with municipalities in separate panels,
#with points and fitted linear regression lines
ggplot(data = pdat, aes(x = year, y = nat_rate)) +
  geom_point() + 
  scale_x_continuous(breaks = seq(from = 2000, to = 2009)) + 
  stat_smooth(method = "lm") +
  facet_wrap(~ muni_name) +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)) +
  theme(panel.spacing.x = unit(2, "lines"))

#Can also save and gradually build up the plot.
#Starting with initialization of plotting object
myplot <- ggplot(data = pdat, aes(x = year, y = nat_rate)) +
  scale_x_continuous(breaks = seq(from = 2000, to = 2009))
myplot

#Adding the layers and formatting instructions
myplot <- 
  myplot + geom_point() + stat_smooth(method = "lm") +
  facet_wrap(~ muni_name) +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)) +
  theme(panel.spacing.x = unit(2, "lines"))
myplot

#Adding some additional instructions
myplot <- 
  myplot + xlab("Year") + ylab("Naturalization Rate") +
  geom_hline(yintercept = 0, linetype = 2, color = "red")
myplot

#ggplot2 and ggthemes also come with pre-packaged aesthetic themes
myplot + theme_bw()
myplot + theme_economist()
myplot + theme_dark()
myplot + theme_solarized()

#This is all just scratching the surface of what is possible
#with ggplot!


# ggpairs: Useful summary visualization -----------------------------------

data("iris")
head(iris)
ggpairs(iris)


# Bonus Material: More on pipes -------------------------------------------

tdat <- dat %>% 
  filter(year == 2005) %>% 
  select(muni_name, year, nat_rate)
head(tdat)

#Summarizing with pipes
sdat <- dat %>% summarise(mean_nat_rate = mean(nat_rate))
sdat

sdat <- dat %>% summarise(mean_nat_rate = mean(nat_rate),
                          median_nat_rate = median(nat_rate),
                          perc99_nat_rate = quantile(nat_rate, probs = 0.95))
sdat

sdat <- dat %>% summarise(mean_nat_rate = mean(nat_rate),
                          median_nat_rate = median(nat_rate),
                          perc99_nat_rate = quantile(nat_rate, probs = 0.95),
                          n_munis = length(unique(muni_name)),
                          n_years = length(unique(year)),
                          start_year = min(year),
                          end_year = max(year))
sdat

#Grouping and summarizing with pipes
sdat <- dat %>% 
  group_by(muni_name) %>% 
  summarise(mean_nat_rate = mean(nat_rate))
head(sdat)

sdat <- dat %>% 
  group_by(muni_name) %>% 
  summarise(mean_nat_rate = mean(nat_rate),
            initial_nat_rate = nat_rate[year == 1991],
            final_nat_rate = nat_rate[year == 2009],
            n = n())
head(sdat)

#tbl_df (tibble) vs. data.frame
head(sdat)
sdat <- as.data.frame(sdat)
head(sdat)

#Creating new group-level variables without reducing the data
ndat <- dat %>% 
  group_by(muni_name) %>% 
  mutate(mean_nat_rate = mean(nat_rate))
head(ndat)

ndat <- dat %>% 
  group_by(muni_name) %>% 
  mutate(mean_nat_rate = mean(nat_rate),
         prop_time_repdem = mean(repdem),
         n = n())
head(ndat)
