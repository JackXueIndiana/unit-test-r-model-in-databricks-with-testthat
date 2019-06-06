# Unit tests and regression tests of R model in Databricks with library TestThat
We show you how to do unit test and regression test of R models in Azure Databricks cluster with CRAN package testthat.

We find a solution (or a work-around). In the method test_file() in the script /Shared/r_model/test_suite.r, we can pass in a test cases file. If this file is in Workspace, say /Shared/r_model/tests/test_cases.r, then the method test_file() cannot find the file. But if the same file is in DBFS then the method can locate it. Based on this observation, we code /Shared/r_model/tests/test_cases.r in Workspace, and then export it to a PC where databricks CLI is installed and finally copy this file back to DBFS by using the CLI. Now we run /Shared/r_model/test_suite.r which generates the desired JunitReporter in XML.

Assuming a R model has been training and saved as RDS file. Here is the steps for testing

Create r script for test cases in test_cases.r

Create r script for test suite in test_suite.r

These two r scripts are located the same folder in Databricks Workspace.

Run test_cases.r interactively to make sure its correctness.

Then go to a PC where Databricks CLI installed and configured to connect to the Azure Databricks workspace.

Then run the following commands to move file test_cases.r to DBFS:

command 1 databricks workspace export --overwrite /Shared/r_model/test/unit_test/test_cases.r .

command 2 databricks fs cp --overwrite test_ cases.r "dbfs:/mnt/r_model/"

command 3 databricks fs ls "dbfs:/mnt/r_model/"

Now you can go back to the workspace and run the test_suite.r interactively which will generate a XML file in JUNIT format and saved in DBFS. You can also set up a Databricks job to run test_suite.r remotely.

The JUNIT XML can be copied to the PC with the following command:

databricks fs cp "dbfs:/mnt/r_model/outputfile/r_unit.xml" .

## Regression tests with dataset
To conduct a regression test, say after re-training a model, besides the unit tests, you need to use a dataset to do a regression test to verify the KPI, say R^2, is comparable to the one we got in training/retraining.

The way to do is is still using the TestThat package. You need to load in the ground truth data to compared the predicted values from the current model. The R^2 can be calculated as 

r_sqr <- cor(y, y_hat)^2

You can set a threshold, say

abs(r_sqr - r_sqr_train)<=0.001
