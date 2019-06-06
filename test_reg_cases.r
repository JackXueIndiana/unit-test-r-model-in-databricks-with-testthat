# Databricks notebook source
list.of.packages <- c("testthat", "SparkR")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

library("testthat")
library("SparkR")

context("Regression Tests Linear Regression Model with Dataset")

# COMMAND ----------

# Load Input Data
data <- read.csv("/dbfs/mnt/r_model/inputfile/test/r_input_file1.csv", header=TRUE)
print(data)

# COMMAND ----------

# Load the Model from Blob Storage
inputmodel_path = "/dbfs/mnt/r_model/model/model.rds"
model <- readRDS(inputmodel_path)
print(summary(model))

# COMMAND ----------

# Perform Scoring
x <- data.frame(x = data$height)
y <- predict(model,x) 
data$weight <- y
print(data)

# COMMAND ----------

# Load Training Data
data_t <- read.csv("/dbfs/mnt/r_model/inputfile/train/weight_data.csv", header=TRUE)
data_t

# COMMAND ----------

dif <- data.frame(data_t, data)
dif

# COMMAND ----------

r_sqr <- cor(dif$weight, dif$weight.1)^2
print(r_sqr)

# COMMAND ----------


# We know that in training the R_Squred is 0.007663
train_r_sqr <- 0.007663
testName <- "Dif R_Sqrs"
test_that(testName, {
    expect_lt(abs(r_sqr - train_r_sqr), 0.001)
})

# COMMAND ----------


