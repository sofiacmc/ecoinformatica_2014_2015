
# Load packages
# install.packages(c('Kendall','wq'))
library('Kendall')  # For Kendall analysis
library('wq')       # For Kendall and Theil-Sen Slope analysis 
library('ggplot2')  # For advanced plots 
library('reshape2') # Manipule data
library('zoo')      # Temporal series 

# set working directory 
di <- '/Users/ajpelu/ownCloud/myrepos/ts_CAdrought'
setwd(di)

#####################################################
##### Trend analysis Annual SCPDSI ##################

# Read data
anual <- read.table('http://www.iecolab.es/ecoinfo/scpdsi_annual.csv', header = TRUE, sep=',')

# Explore data
str(anual)
head(anual)

# Exploratory plot 
plot(anual$year, anual$scpdsi, type='o', 
     xlab='year', pch=19, col='#325B84',
     ylab='scpdsi', ylim=c(-6,6))
abline(h=0)
abline(h=-2, lty=2, col='red')

### Run the Trend analysis
m <- MannKendall(anual$scpdsi)
m

### Test a linear regression
ml <- lm(anual$year~anual$scpdsi)
summary(ml)

# Plot residuals 
par(mfrow=c(2,2))
plot(ml)
#####################################################


#####################################################
##### Trend analysis Monthly SCPDSI #################

# Read data
mensual <- read.table('http://www.iecolab.es/ecoinfo/scpdsi_monthly.csv', header = TRUE, sep=',')

# Explore monthly data
str(mensual)
head(mensual)

# Manipule data 
mensuales <- dcast(mensual, year ~ month, value.var = 'value')   
names(mensuales) <- c('year','jun','jul','aug','sep')

# Convert data into zoo object 
mizoo <- zoo(mensuales[-1], mensuales[,1])
str(mizoo)

# Exploratory plot 
plot(mizoo, type='o', pch=19, main='scPDSI index', 
	col='#325B84', cex.lab=2.5, cex.axis=1.5)


### Run the Theil-Sen and Trend analysis
theil <- mannKen(as.ts(mizoo))
theil
#####################################################
