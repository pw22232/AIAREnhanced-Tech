[Running a test in the Galasa Ecosystem](https://galasa.dev/docs/writing-own-tests/running-test-modes)

![Run Remote](run_remote.png)

## Entry Level

### General Information
- To run tests on the Galasa online platform, you set up Galasa with the web address of that platform.
- This online platform has all the settings for the test and is where the test starts.
- You can send tests to run online using a special Galasa command.
- This method makes it easier to run tests online and see the results.

### Components

**Galasa Framework (Executing):**
- The Galasa framework is key for running tests online.
- Tests are sent to this online platform to run.
- The framework sets up the test environment and runs the test.
- It runs the tests in a special isolated area.

**Testcase Class (Executing):**
- This represents the specific test you want to run online.
- It's a crucial part of the test process on the Galasa platform.
- The test setup is done online, and this class carries out the testing.

**Galasa Configuration (Stored):**
- This holds all the test settings and how each test should be run.
- These settings are kept on the Galasa online platform.
- They include all the details on how the test should be performed.

**Test Results (Stored):**
- The outcomes and details from the tests are stored online in the Galasa platform.
- People can look at these results from their computers.
- These results keep a complete record of what happened in the tests.

## Specialist

### General Information
- To run tests remotely within the Galasa Ecosystem, the Galasa bootstrap is configured with the URL of the target ecosystem.
- The ecosystem holds the test configuration and is the environment in which Galasa starts for test execution.
- Tests are submitted remotely by using the "runs submit" Galasa CLI command.
- This approach simplifies remote test execution and result access within the Galasa framework.

### Components

**Galasa Framework (Executing):**
- The Galasa framework plays a central role in the remote execution of tests.
- Tests are submitted to a Galasa Ecosystem for remote execution.
- The framework is responsible for initializing the test environment and executing the test code.
- It operates within a container where the test code runs.

**Testcase Class (Executing):**
- The test case class represents the specific test to be executed remotely.
- It is a critical part of the test execution process within the Galasa Ecosystem.
- Tests are configured within the ecosystem, and the test case class carries out the defined test procedures.

**Galasa Configuration (Stored):**
- Galasa configurations hold the settings and parameters for each test.
- Configurations are stored within the Galasa Ecosystem where the test is executed.
- These configurations define how the test should be conducted and include various parameters and options.

**Test Results (Stored):**
- Test results and artifacts generated during remote test execution are stored in a dedicated database within the Galasa Ecosystem.
- Users on client machines can access and view the test results.
- The stored results provide a comprehensive record of test outcomes and associated artifacts.
