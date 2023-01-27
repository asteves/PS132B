# How should we think about randomness? -----------------------------------
set.seed(123)
num_vec = 1:5
num_vec[c(5,3,1,2,4)]
num_vec[c(1,3,4,2,5)]

## How many possible ordering are there are 5 numbers? 
factorial(5)

## What are we doing here? 

## SAMPLING!
sample(1:5, 5)

# Data Loading ------------------------------------------------------------

sections = read.csv("sections.csv")
section101 = subset(sections, section == 101)
section102 = subset(sections, section == 102)


# Section 101 -------------------------------------------------------------
head(section101)

## Let's make some random groups 
## How many students do we have 
nrow(section101)

group = 1:9
section101$group = sample(group, nrow(section101), replace = TRUE)

## We have a problem when we do this. Why? 

## An alternative 
group2 = c(rep(1:9, each = 3))
section101$group = sample(group2, nrow(section101), replace = FALSE)
section101[order(section101$group),]

# Section 102  ------------------------------------------------------------

head(section102)

## Let's make some random groups 
## How many students do we have 
nrow(section102)

group = 1:9
section102$group = sample(group, nrow(section101), replace = TRUE)

## We have a problem when we do this. Why? 

## An alternative 
group2 = c(rep(1:9, each = 3))
section102$group = sample(group2, nrow(section101), replace = FALSE)
section102[order(section102$group),]
