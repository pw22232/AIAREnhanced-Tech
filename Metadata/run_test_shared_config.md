[Running a test locally but using shared configuration](https://galasa.dev/docs/writing-own-tests/running-test-modes)

![Run_test_shared_config](hybridrunmode.png)

## General Information
- Running tests locally with shared configurations involves setting the Galasa bootstrap to the URL of the Galasa Ecosystem storing the shared configurations.
- The Galasa Framework operates within the local JVM but retrieves configuration data from the remote ecosystem.
- Credential properties are obtained from a local file during execution.
- This hybrid approach simplifies test execution with local resources while benefiting from shared configurations.
- Test results and artifacts are stored locally.

## Components

**Local JVM (Nested Components - Executing):**
- The Local JVM represents the Java Virtual Machine running locally.
- Within the Local JVM, the "Galasa Framework" and "Testcase Class" execute tests.
- Tests are launched and executed within the local JVM environment.

**Local File System (Nested Components - Bootstrap and Stored):**
- The Local File System serves as a storage and configuration repository for local testing.
- The "Bootstrap" component holds configuration information, with the URL pointing to the remote Galasa Ecosystem where shared configurations are stored.
- The "Test Results" component stores the results of local tests and related artifacts.
- Local test execution leverages shared configurations stored remotely.

**Remote Ecosystem (Stored - Galasa Configuration):**
- The Remote Ecosystem contains the shared configuration for Galasa tests.
- The configuration is held within the ecosystem for easy access during test execution.
- It provides the necessary settings and parameters for tests.



