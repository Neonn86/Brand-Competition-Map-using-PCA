# Importing necessary libraries
library(glmnet)
library(readxl)
rm(list=ls(all=TRUE)) #clear data

# Importing the data and assigning x and y
cars_data <-  read_excel("Cars_Data.xlsx", sheet = "Infinity Data")  
y <-  cars_data[,17]
x <-  as.matrix(cars_data[,2:16])

# Creating the correlation matrix
cor_mat = cor(x)


# Principal Components Analysis
out1 <-  eigen(cor_mat)	# eigen decomposition of correlation matrix
va <-  out1$values			# eigenvalues
ve <-  out1$vectors		# eigenvector

# Scree Plot
plot(va, ylab = "Eigenvalues", xlab = "Component Nos")

ego <- va[va > 1]							# eigenvalues > 1
nn <- nrow(as.matrix(ego))		# number of factors to retain

out2 <- ve[,1:nn]							# eigenvectors associated with the retained factors
out3 <- ifelse(abs(out2) < 0.3, 0, out2)		# ignore small values < 0.3

rownames(out3) <- c("Attractive",	"Quiet",	"Unreliable",	"Poorly Built",	"Interesting",	"Sporty",	"Uncomfortable",	"Roomy",	"Easy Service",	"Prestige",	"Common",	"Economical",	"Successful",	"AvantGarde",	"Poor Value")

z_test <- x %*% out3
out_test <- lm(as.matrix(y) ~ z_test)
summary(out_test)

## Z1 and Z2 are negative, therefore we change the signs of those two vectors.

out4 <- out3
out4[,1] <- -1*out3[,1]
out4[,2] <- -1*out3[,2]

out4
z = x %*% out4			# Component Scores; coordinates of the brands in the map
out5 = lm(as.matrix(y) ~ z)		# Preference Regression to estimate how benefits drive overall preferences = f(benefits)
summary(out5)

## All slopes are positive. However, only Z1 and Z3 are statistically significant at 5% significance level.

# Coordinates of brands in (Z1, Z3) space
Z1 = z[,1]
Z3 = z[,3]
z.out = cbind(Z1, Z3)
rownames(z.out) = c("Infinity","Ford","Audi","Toyota","Eagle","Honda","Saab","Pontiac","BMW","Mercury")

# Plot the brand map
plot(Z1, Z3, main = "Brands in Z1 and Z3 space", xlab = "Benefit Z1: Popular & Good Engineering", ylab = "Benefit Z3: Basic & Affordable", col = "red", pch = 19, cex = 2)
text(z.out, labels = row.names(z.out), font = 2, cex = 0.5, pos = c(1,4))

# Slopes of iso-preference and ideal vector	
b1 = as.vector(coef(out5)[2])
b2 = as.vector(coef(out5)[4])
slope.iso.preference = - b1/b2
slope.ideal.vector = b2/b1

# Angles of iso-preference and ideal vector	
angle.iso.preference = atan(slope.iso.preference)*180/pi	
angle.ideal.vector = atan(slope.ideal.vector)*180/pi

# Data Bootstrapping

set.seed(50)

colnames(z) <- c("Z1", "Z2", "Z3", "Z4")
data <- cbind(y, z)
bb <- 1000
nn <- nrow(data)

angle_ideal_vector_star <- rep(0,bb)

for (i in 1:bb) {
  data_star <- data[sample(nn, nn, replace=T),]
  y_star <- data_star[,1]
  z_star <- data_star[,2:ncol(data_star)]
  model <- lm(as.matrix(y_star) ~ as.matrix(z_star))
  model_coef <- coef(model)
  slope_ideal_vector_star <- model_coef[4]/model_coef[2]
  angle_ideal_vector_star[i] <- atan(slope_ideal_vector_star)*180/pi
}

conf_int <- quantile(angle_ideal_vector_star, c(0.025, 0.975), na.rm = TRUE)
round(conf_int,2)