#Test T model in Azure Databricks with testthat
We show you how to do unit test and regression test of R models in Azure Databricks cluster with CRAN package testthat.

We find a solution (or a work-around). In the method test_file() in the script /Shared/r_model/test_suite.r, we can pass in a test cases file. If this file is in Workspace, say /Shared/r_model/tests/test_cases.r, then the method test_file() cannot find the file. But if the same file is in DBFS then the method can locate it. Based on this observation, we code /Shared/r_model/tests/test_cases.r in Workspace, and then export it to a PC where databricks CLI is installed and finally copy this file back to DBFS by using the CLI. Now we run /Shared/r_model/test_suite.r which generates the desired JunitReporter in XML.
