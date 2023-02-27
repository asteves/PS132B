
# Basic operations --------------------------------------------------------

4+4   #addition

6-2   #subtraction

100/10   #division

450*3   #multiplication

(4+4)*(6-2)/(100/10)*(450*3)   #order of operations work as they should

4+4*(6-2)/100/10*(450*3)   #different answer when the parentheses move

8^2   #raise a number to a power

sqrt(64)   #square root

pi   #the constant pi

log(10)   #the natural log (log with Euler's number e as the base)

exp(10)   #exponentiate (Take Euler's number and raise it to some power)

exp(log(10))

10 %% 2   #remainders: 2 goes into ten 5 times, no remainder

11 %% 2    #2 goes into 11 five times, remainder = 1

11 %/% 2    #integer division: 2 goes into 11 how many times? 5


# Objects -----------------------------------------------------------------

#scalar
a <- 5
add.obj <- 4 + a
div.obj <- 100/10

#vector
b <- c(1,3,5)
sub.obj <- 6 - b
mult.obj <- 5*b - a

#vectors and data frame
vec1 <- c(1,2,3,4)
vec2 <- c(7,8,9,10)
vec3 <- c("hello","world","welcome","back")
fake.dat.1 <- data.frame(vec1,vec2,vec3)

#data frame
fake.dat.2 <- data.frame(v1 = c(2,4,6,8),
                         v2 = c(1.12,1.33,2.85,3.01),
                         v3 = c("red","blue","green","yellow"))

#data frame fail
fake.dat.3 <- data.frame(v1 = c(2,4,6,8),
                         v2 = c(1.12,1.33,2.85,3.01),
                         v3 = c("red","blue","green"))

#list
and_a_list <- list(fake.dat.1,fake.dat.2,b)

#names of objects:
#must begin with a letter
#are case-sensitive
#can also include numbers 
#can also include . and _
abc_vector <- c(1,4,5)
abc_vector
Abc_vector
abcvector
abc.vector

abc.vector <- c(9,8,7)
abc.vector


# Order of code execution matters -----------------------------------------

var1 + var2
var1 <- 5
var2 <- 10


# Useful functionalities --------------------------------------------------

#Looking up documentation
?data.frame
?read.csv
?lm

#installing packages
install.packages("powerLATE")

#Loading packages
library(dplyr)
library(ggplot2)
library(package_i_dont_have)

#Checking the class or structure of an object
class(b)
str(b)
class(fake.dat.1)
str(fake.dat.1)


# Important, specialized values -------------------------------------------

#Missing values are represented by NA (not "NA", na, Na, etc.)
vec4_yes <- c(2,6,NA,8,9) #Correct!
vec4_yes
str(vec4_yes)

vec4_no <- c(2,6,"NA",8,9) #Incorrect!
vec4_no
str(vec4_no)

#TRUE and FALSE are specialized logical values
is.numeric(vec4_yes)
is.numeric(vec4_no)


# Logical statements ------------------------------------------------------

a <- 5
a == 5  #a is equal to 5
as.numeric(a == 5)  #a is equal to 5, numerical representation
5 > 3  #5 is greater than 3
6 < 4  #6 is less than 4
a != 5  #a is not equal to 5
a > 5  #a is greater than 5
a >= 5  #a is greater than or equal to 5

if (a == 5){
  a <- a*2
}
a

if (a == 5){
  a <- a*2
}
a


# Loading data ------------------------------------------------------------

getwd()
#If data are in the current working directory, then load as follows:
dat <- read.csv("asylum_survey_data.csv")

#If data are not in current working directory, 
#will need to further specify the location either:

#(a) relative to current working directory
#e.g. data in one parent folder up can be loaded via:
#dat <- read.csv("../asylum_survey_data.csv")

#(b) using fully specified path of file, e.g.
#dat <- read.csv("/Users/INSERT_REST_OF_PATHWAY/asylum_survey_data.csv")


# Working with data frames ------------------------------------------------

#Viewing data
View(dat)
#Note: Avoid using the View() function in R Markdown code chunks,
#as it will cause knitting errors.

#Inspect first few rows
head(dat)

#Basic summary
summary(dat)

#Access individual variables with extraction operator ($)
dat$age
dat$cty
dat$prefer_prop
dat$cons_trt


# Functions for key operations --------------------------------------------

str(dat$age)
mean(dat$age)
sd(dat$age)

str(dat$ideo_scale)
mean(dat$ideo_scale)
sd(dat$ideo_scale)

str(dat$prefer_prop)
mean(dat$prefer_prop)
table(dat$prefer_prop)

str(dat$asylum_home)
mean(dat$asylum_home)
table(dat$asylum_home)

str(dat$cty)
mean(dat$cty)
table(dat$cty)

table(dat$cty,dat$prefer_prop)

cor(dat$age,dat$ideo_scale)


# Bracket notation --------------------------------------------------------

#Indexing with vectors
new.vec <- c(4,8,15,16,23,42)
new.vec
new.vec[3] #third element
new.vec[c(1,3)] #first and third element
new.vec[c(TRUE,FALSE,TRUE,FALSE,FALSE,FALSE)] #also first and third element
new.vec[1:4] #first four elements
new.vec[-5] #all but fifth element

#Indexing vectors or variables from data.frames
dat$prefer_prop
dat$prefer_prop[1:5]

#More efficient indexing
dat$cty
dat$cty == "United Kingdom" #logical vector
dat$prefer_prop[dat$cty == "United Kingdom"] #logical vector for indexing
mean(dat$prefer_prop[dat$cty == "United Kingdom"]) #and computing the mean

#More complex examples:

#Computing the mean preference for respondents who are from
#either the UK or France
mean(dat$prefer_prop[dat$cty == "United Kingdom" | dat$cty == "France"])

#Computing the mean preference for respondents who are from
#Italy and are on left side of ideological spectrum
mean(dat$prefer_prop[dat$cty == "Italy" & dat$ideo_scale < 5])

#Storing indices
which(dat$cty == "United Kingdom")
these.uk <- which(dat$cty == "United Kingdom")
mean(dat$prefer_prop[these.uk])

#Two-dimensional indexing (for data frames, tables, matrices)
dat[1,] #First row
dat[,6] #Sixth column
dat[1,6] #The cell pertaining to first row and sixth column

dat[1:10,6] #The cells pertaining to first ten rows and sixth column
dat[1:10,"asylum_home"] #Same thing, since sixth column is asylum_home variable
dat$asylum_home[1:10] #Same thing, different implementation

#Replacing
new.vec
new.vec[3] <- 12
new.vec

hist(dat$age)
dat$age[dat$age > 60] <- 60
hist(dat$age)


# Subsetting data ---------------------------------------------------------

#Create a smaller data set with only respondents from the UK
dat.uk <- subset(dat, dat$cty == "United Kingdom")

#Create a smaller data set with only respondents age 40 and older
dat.old <- dat[dat$age >= 40, ]

#Create a data set omitting all observations with any missing data
dat.full <- na.omit(dat)


# More on subselection ----------------------------------------------------

#Method 1: subset()

tdat <- subset(dat, subset = (employed == 1))
head(tdat)

tdat <- subset(dat, select = c(resp_id, prefer_prop, ideo_scale))
head(tdat)

tdat <- subset(dat, subset = (employed == 1), 
               select = c(resp_id, prefer_prop, ideo_scale))
head(tdat)

#Method 2: Bracket Notation

tdat <- dat[dat$employed == 1, ]
head(tdat)

tdat <- dat[, c("resp_id","prefer_prop","ideo_scale")]
head(tdat)

tdat <- dat[dat$employed == 1, c("resp_id","prefer_prop","ideo_scale")]
head(tdat)

#Method 3: dplyr piping with filter() and select()

tdat <- dat %>% filter(employed == 1)
head(tdat)

tdat <- dat %>% select(resp_id, prefer_prop, ideo_scale)
head(tdat)

tdat <- dat %>% 
  filter(employed == 1) %>% 
  select(resp_id, prefer_prop, ideo_scale)
head(tdat)


# Other important functions -----------------------------------------------

#Sampling

some_integers <- c(1,2,3,4,5,6,7)

?sample
sample(x = some_integers, size = 1)
sample(x = some_integers, size = 3)
sample(x = some_integers, size = 7)
sample(x = some_integers, size = 7, replace = TRUE)


#Linear regression

lmod <- lm(prefer_prop ~ cons_trt + ideo_scale, data = dat)
lmod
summary(lmod)

