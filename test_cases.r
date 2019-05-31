# Databricks notebook source
# MAGIC %md The notebook reads in the model and does some simple tests and write out the results to a file.

# COMMAND ----------

list.of.packages <- c("testthat", "SparkR")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

library("testthat")
library("SparkR")

context("Unit Tests Linear Regression Model")

#testResults <- list() 

# COMMAND ----------

# Load the Model from Blob Storage
inputmodel_path = "/dbfs/mnt/r_model/model/model.rds"
model <- readRDS(inputmodel_path)
print(model)

# COMMAND ----------

p <- data.frame(height = c(79), weight = c(0))
x <- data.frame(x = p$height)
y <- predict(model, x)
y

# COMMAND ----------



# COMMAND ----------

#testName <- "Output Shape"
test_that("Output Shape", {
    expect_that(length(y), equals(1))
    expect_that(class(y), equals("numeric"))
    expect_that(class(y), equals("boolean"))
})

#testResults[[testName]] <- t0
#print(testResults)

# COMMAND ----------

#testName <- "Output Value Two Sides"
test_that("Output Value Two Sides", {
    expect_gt(y[1], 192)
    expect_lt(y[1], 193)
})
#testResults[[testName]] <- t1
#print(testResults)

# COMMAND ----------

#testName <- "Output Value One Side"
test_that("Output Value One Side", {
      expect_lt(y[1], 193)
})

#testResults[[testName]] <- t2
#print(testResults)

# COMMAND ----------

#df <- as.data.frame(testResults)
#df <- t(df)
#write.csv(df, file='/dbfs/mnt/r_model/outputfile/r_unit.txt', row.names=TRUE, col.names=FALSE)
#write.table(df, file='/dbfs/mnt/r_model/outputfile/r_unit.txt', row.names=TRUE, na="", col.names=FALSE, sep=",")

# COMMAND ----------

# MAGIC %md Make sure the output file written out.

# COMMAND ----------

#%fs
#ls "/mnt/r_model/outputfile"
