# Databricks notebook source
# MAGIC %md The notebook reads in the model and does some simple tests and write out the results to a file.

# COMMAND ----------

# command 1
# databricks workspace export --overwrite /Shared/r_model/test/reg_test/test_reg_cases .
# command 2
# databricks fs cp --overwrite test_reg_cases.r "dbfs:/mnt/r_model/"
# command 3
# databricks fs ls "dbfs:/mnt/r_model/"

list.of.packages <- c("testthat")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

library("testthat")

# COMMAND ----------

#test_dir("..", reporter = JunitReporter$new(file = "/dbfs/mnt/r_model/outputfile/r_unit.xml"))
test_file("/dbfs/mnt/r_model/test_reg_cases.r", reporter = JunitReporter$new(file = "/dbfs/mnt/r_model/outputfile/r_reg.xml"))

# COMMAND ----------

# MAGIC %fs
# MAGIC ls "/mnt/r_model/outputfile"

# COMMAND ----------

file.show("/dbfs/mnt/r_model/outputfile/r_reg.xml")

# COMMAND ----------


