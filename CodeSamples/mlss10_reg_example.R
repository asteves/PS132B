library(ggplot2)
library(ggthemes)


# Load data ---------------------------------------------------------------

df <- read.csv("safrica.csv")


# Inspect -----------------------------------------------------------------

head(df)

#wage: average hourly earnings (1994 ZAR; 1 US dollar = 3.5 ZAR in 1994).
#female: = 1 if female, = 0 otherwise.
#age: age in years.
#educ: number of years of education (note: 10 = completed secondary school, 13 = completed university degree).
#exper: years of work experience (age-education-7).

summary(df)
sd(df$wage)


# Estimate linear regression ----------------------------------------------

#Using female, age, and educ to predict wage:
mod1 <- lm(wage ~ female + age + educ, data = df)


# Things we can extract from lm object ------------------------------------

#Basic information:
mod1

#More detailed information:
summary(mod1)

#Specific objects to extract
mod1$coefficients
mod1$residuals
mod1$fitted.values
confint(mod1, level = 0.95)


##################
##BACK TO SLIDES##
##################


# Manual prediction -------------------------------------------------------

#Computing inner product in R:
vec1 <- c(4,2,1)
vec2 <- c(2,3,5)
vec1 %*% vec2
#Not vec1*vec2 !

#Predicting wage for specific x vector (predictor values)
beta.hat <- mod1$coefficients
x.star <- c("female" = 1, "age" = 30, "educ" = 13)
beta.hat %*% x.star

#Don't forget about the intercept!
x.star <- c(1, "female" = 1, "age" = 30, "educ" = 13)
beta.hat %*% x.star


# Predict function --------------------------------------------------------

newdata1 <- data.frame("female" = 1, "age" = 30, "educ" = 13)
newdata2 <- data.frame("female" = c(1,0), "age" = c(30,32), "educ" = c(13,10))
newdata.typo <- data.frame("femalee" = c(1,0), "age" = c(30,32), "educ" = c(13,10))

predict(mod1)
predict(mod1, newdata = newdata1)
predict(mod1, newdata = newdata2)
predict(mod1, newdata = newdata.typo)

##################
##BACK TO SLIDES##
##################


# Additional considerations with predictors -------------------------------

#QUALITATIVE PREDICTORS

#Creating a fake, 4-level variable
df$tmode <- sample(c("Car","Bus","Bike","Walk"),nrow(df),replace = T)

mod2 <- lm(wage ~ female + age + educ + tmode, data = df)
summary(mod2)

#Here's what R actually used in the model:
modmat <- model.matrix(mod2)
head(modmat)


#INTERACTIONS

mod3 <- lm(wage ~ female*age + educ, data = df)
summary(mod3)
head(model.matrix(mod3))


#POLYNOMIALS

mod4a <- lm(wage ~ age, data = df)
summary(mod4a)

mod4b <- lm(wage ~ age + I(age^2), data = df)
summary(mod4b)
head(model.matrix(mod4b))

ggplot(df, aes(x = age, y = wage)) + geom_point() +
  theme_economist(dkpanel = T)

ggplot(df, aes(x = age, y = wage)) + geom_point() +
  geom_smooth(method = "lm", formula = y ~ x) +
  coord_cartesian(ylim = c(0,20)) +
  theme_economist(dkpanel = T)

ggplot(df, aes(x = age, y = wage)) + geom_point() +
  geom_smooth(method = "lm", formula = y ~ x + I(x^2)) +
  coord_cartesian(ylim = c(0,20)) +
  theme_economist(dkpanel = T)


#PERFECT COLLINEARITY

mod5 <- lm(wage ~ female + age + educ + exper, data = df)
summary(mod5)
