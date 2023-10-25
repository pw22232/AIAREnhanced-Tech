[Run Test Locally](https://galasa.dev/docs/writing-own-tests/running-test-modes)

![Running Local](running_local.png)

## General Information
- Running a test locally means that all test processes occur on your local machine, without shared configurations or dependencies on external ecosystems.
- The Galasa bootstrap file remains empty, making no reference to external resources.
- The Galasa Framework is launched within the local JVM, utilizing local configurations.
- All test results and artifacts are kept on the local disk, facilitating easy access and management.
- Tests can be executed in local mode using the "runs submit local" Galasa CLI command or within the Eclipse JVM using the Eclipse plugin.

## Components

**Local JVM (Nested Components - Executing):**
- The Local JVM represents the Java Virtual Machine running locally.
- Within the Local JVM, the "Galasa Framework" and "Testcase Class" execute tests.
- All test processes run on the local machine, with no reliance on external ecosystems.

**Local File System (Nested Components - Bootstrap, Stored):**
- The Local File System serves as the central repository for configurations and results when running tests locally.
- The "Bootstrap" component remains blank, containing no reference to external ecosystems.
- The "Galasa Configuration" is stored locally and contains all necessary configuration data.
- Test results and related artifacts are stored on the local disk, ensuring everything remains on the local machine.

