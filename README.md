We show you how to do unit test and regression test of R models in Azure Databricks cluster with CRAN package testthat.

We find a solution (or a work-around). In the method test_file() in the script /Shared/r_model/test_suite.r, we can pass in a test cases file. If this file is in Workspace, say /Shared/r_model/tests/test_cases.r, then the method test_file() cannot find the file. But if the same file is in DBFS then the method can locate it. Based on this observation, we code /Shared/r_model/tests/test_cases.r in Workspace, and then export it to a PC where databricks CLI is installed and finally copy this file back to DBFS by using the CLI. Now we run /Shared/r_model/test_suite.r which generates the desired JunitReporter in XML.

Assuming a R model has been training and saved as RDS file. Here is the steps for testing 

Create r script for test cases in test_that.r

Create r script for test suite in unit_test_linear_regression.r

These two r scripts are located the same folder in Databricks Workspace.

Run test_that.r interactively.

The go to a PC where Databricks CLI installed and configured to connect to the Azure Databricks workspace.

Then run the folloiwng commands to move file test_that.r to DBFS:

command 1
databricks workspace export --overwrite /Shared/r_model/test/unit_test/test_that.r .

command 2
databricks fs cp --overwrite test_that.r "dbfs:/mnt/r_model/"

command 3
databricks fs ls "dbfs:/mnt/r_model/"

Now you can go back to th workspace and run the unit_test_linear_regression.r inteactively which will generate a XML file in JUNIT format and saved in DBFS.
