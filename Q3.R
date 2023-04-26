library(dplyr)
library(ggplot2)
library(mice)
library(corrplot)
library(boot)
library(MASS)
library(lmridge)
library(car)

myData1 <- read.csv("C:/Users/sanja/Downloads/FINALDATASET.txt")
View(myData1)

movie.reducedmod<- lm(Votes~Runtime_Minutes, myData1)
anova(movie.reducedmod)

movie.fullmod <- lm(Votes~Runtime_Minutes + Year, myData1)
anova(movie.fullmod)

anova(movie.reducedmod, movie.fullmod)


summary(movie.reducedmod)
summary(movie.fullmod)

dfbetasPlots(movie.fullmod)

resNorm = residuals(movie.fullmod)
resNorm
residualPlots(movie.fullmod)
plot(fitted(movie.fullmod),residuals(movie.fullmod), xlab = "Fitted Values", ylab = "Residuals",main = "Residuals vs Fitted Values Plot")
#we can say that the assumption of constant varience has been violated here
shapiro.test(resNorm)

qqPlot(resNorm)
qqline(resNorm)

#multicollinearity
vif(lm(Votes~Year+Runtime_Minutes, data=myData1))

influencePlot(movie.fullmod, id.method = "cook", plot = TRUE)

cooksd <- cooks.distance(movie.fullmod)


# Create a bar plot of Cook's distances
plot(cooksd, type = "h", lwd = 2, ylab = "Cook's Distance", main = "Cook's Distance Plot")

# Add a horizontal line at Cook's distance of 0.5
abline(h = 0.5, col = "red")

summary(movie.fullmod)

wts1 <- 1/fitted(lm(abs(residuals(movie.fullmod)) ~ Year + Runtime_Minutes, data = myData1))^2 # making weighted model
modelWLS <- lm(Votes ~ Year + Runtime_Minutes, data = myData1, weights = wts1)

summary(modelWLS)


qqPlot(resWeight)
qqline(resWeight)

resWeight <- residuals(modelWLS)
library(lmtest)
bptest(movie.fullmod)


# Define function for bootstrapping
boot.wls <- function(myData1, indicies, maxit = 20) {
  data1 <- myData1[indicies, ]
  y = data1$Votes
  x4 = data1$Year
  x6 = data1$Runtime_Minutes
  
  # Fit initial model
  Fullmodel <- lm(y ~ x4 + x6 , data = data1)
  
  # Compute weight vector
  wts1 <- 1/fitted(lm(abs(residuals(movie.fullmod)) ~ Year + Runtime_Minutes, data = data1))^2
  
  # Fit WLS model using weight vector
  modelWLS <- lm(y ~ Year + Runtime_Minutes , data = data1, weights = wts1)
  
  return(coef(modelWLS))
}

WLS.boot <- boot(data = myData1, statistic = boot.wls, R = 100, maxit = 20)
summary(WLS.boot)
# View results
WLS.boot

resBoot = residuals(WLS.boot)
residualPlot(resBoot)
resBoot

Reduced <- lm(Votes~Runtime_Minutes, data=myData1)
anova(Reduced, modelWLS)
