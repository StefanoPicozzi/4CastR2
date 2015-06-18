
# Name: paasonomics.R
# Author: Stefano Picozzi
# Blog: http://blog.emergitect.com
# Date: November 2013

# Financial model to compare yearly operational application hosting costs between a conventional versus PaaS model.
# In this model conventional is also referred to as PMO, PaaS as FMO
# representing present and future mode of operation respectively.
#
# Instructions:
# To run, download and install R and recommended helpful related tools such as RStudio.
# Change the working directory in this code to reflect your environment.
# Manipulate assumptions by editing variable settings as indicated inline.

library("reshape2")
library("ggplot2")

setwd("~")

# Helper function for pretty money display
printMoney <- function(x) {
  gsub(" ", "", paste("$", format(x, digits = 10, nsmall = 0, decimal.mark = ".", big.mark = ","), sep = ""))
}

# Set up some plotting related constants
maxCost <- 2000000
maxApp = 15
cost <- printMoney(seq(0, maxCost, 50000))
ppi <- 300
app <- seq(1, maxApp, by = 1)

# Blended average per year costs for a virtualised or bare instance of O/S
instanceCost <- 10000

# FMO = future mode of operation == PaaS
# PMO = present mode of operation == Convential deployments

# Once off costs to establish FMO environment in Year One
fmoProdEstablishCost <- 100000
fmoTestEstablishCost <- 50000

# Once off costs to establish Present Mode assumed as Zero
pmoProdEstablishCost <- 0
pmoTestEstablishCost <- 0

# Node == application host instances
# Mgmt == supporting management infrastructure

# Blended average incremental software costs for PMO instance
pmoProdNodeCost <- instanceCost + 2000
pmoTestNodeCost <- instanceCost + 2000
pmoProdMgmtCost <- 0
pmoTestMgmtCost <- 0

# Blended average incremental software costs for FMO instance
fmoProdNodeCost <- instanceCost + 8000
fmoTestNodeCost <- instanceCost + 5000
fmoProdMgmtCost <- instanceCost + 1000
fmoTestMgmtCost <- instanceCost + 600

# Instances required for PaaS environment
fmoProdMgmtNo <- 6
fmoTestMgmtNo <- 4
# Nodes scale up as we host more applications based on this model:
fmoProdNodeNo <- 4 + (as.integer(app/6)*2)
fmoTestNodeNo <- 4 + (as.integer(app/10)*2)

# Net additional FMO Administration costs
fmoAdmFTE <- 0.2
fmoAdmFTECost <- 100000
fmoProdAdmCost <- 0 + (as.integer(app/6)*2)*(fmoAdmFTE * fmoAdmFTECost)
fmoTestAdmCost <- 0 + (as.integer(app/10)*2)*(fmoAdmFTE * fmoAdmFTECost)

# Instances required for PMO environment per application
pmoProdNodeNo <- 4
pmoTestNodeNo <- 3
pmoProMgmtNo <- 0
pmoTestMgmtNo <- 0

# PMO total cost model
pmoProdTotalCost <- pmoProdEstablishCost + (pmoProdNodeNo * app * pmoProdNodeCost)
pmoTestTotalCost <- pmoTestEstablishCost + (pmoTestNodeNo * app * pmoTestNodeCost)

# FMO total cost model
fmoProdTotalCost <- fmoProdEstablishCost + + fmoProdAdmCost + (fmoProdMgmtNo * fmoProdMgmtCost)  + (fmoProdNodeNo * fmoProdNodeCost)
fmoTestTotalCost <- fmoTestEstablishCost + fmoTestAdmCost + (fmoTestMgmtNo * fmoTestMgmtCost)  + (fmoTestNodeNo * fmoTestNodeCost)

# PMO per application unit costs per year
pmoProdAppCost <- pmoProdTotalCost/app
pmoTestAppCost <- pmoTestTotalCost/app

# FMO per application unit costs per year
fmoProdAppCost <- fmoProdTotalCost/app
fmoTestAppCost <- fmoTestTotalCost/app

#png(paste("~/paasonomics.png", sep = ""),
# 	res = ppi,
#   width = ppi*8,
#   height = ppi*8,
#   units = "px")	

# Set up plotting data frame for ggplot
# Note that for FMO using loess smoothed curves
# but can convert back to stepped function if preferred
df <- data.frame(app)
df$pmoTotalCost <- pmoProdTotalCost + pmoTestTotalCost
df$pmoAppCost <- pmoProdAppCost + pmoTestAppCost
loProd <- loess(fmoProdTotalCost ~ app)
loTest <- loess(fmoTestTotalCost ~ app)
df$fmoTotalCost <- predict(loProd) + predict(loTest)
loProd <- loess(fmoProdAppCost ~ app)
loTest <- loess(fmoTestAppCost ~ app)
df$fmoAppCost <- predict(loProd) + predict(loTest)

# Melt it so ggplot can easily plot and create legend
df.long <- melt(df, id.vars = "app")
df.long

# Some R ggplot magic to draw the graph
ggp <- ggplot(df.long, aes(x = app, y = value, colour = variable)) +
  geom_line(size = 2) +
  ggtitle("PMO v FMO\nConventional versus PaaS Deployment Model Costs") +
  ylab("Year1 Costs (includes FMO establishment)") +
  xlab("No. of Apps") +
  scale_y_continuous(breaks = seq(0, maxCost, 50000), labels = cost) +
  scale_x_discrete(breaks = seq(1, maxApp, 1), labels = app) +
  labs(colour = "Legend") +
  scale_colour_manual(labels = c("PMO Total Cost", "PMO per App Cost", "FMO Total Cost", "FMO per App Cost"), 
    values = c("red3", "orangered", "seagreen", "darkolivegreen4")) +
  theme(
    legend.position = c(0.0, 0.77),
    legend.justification = c(0,0)) 

print(ggp)

#dev.off()

