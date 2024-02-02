[Run Test Locally](https://galasa.dev/docs/writing-own-tests/running-test-modes)

![Running Local](running_local.png)

## Entry Level

### General Information
- Running a test on your own computer means everything happens there, without needing online resources or shared settings.
- The setup file for Galasa on your computer doesn't link to any online resources.
- Galasa runs using your computer's Java system with your own settings.
- All the outcomes and details from your tests are stored on your computer, making them easy to find and use.
- You can start these tests with a special command in Galasa's tool or by using an Eclipse plugin.

### Components

**Local JVM (Nested Components - Executing):**
- This is where your computer runs the Java part of Galasa.
- Galasa and your test scripts run here.
- Your tests are done entirely on your computer, without needing anything from the internet.

**Local File System (Nested Components - Bootstrap, Stored):**
- Your computer's storage keeps all the test settings and results.
- The setup file ("Bootstrap") doesn't use any online resources.
- All the settings for Galasa are kept on your computer.
- Everything from your tests, like results and files, is saved on your computer.

## Specialist

### General Information
- Running a test locally means that all test processes occur on your local machine, without shared configurations or dependencies on external ecosystems.
- The Galasa bootstrap file remains empty, making no reference to external resources.
- The Galasa Framework is launched within the local JVM, utilizing local configurations.
- All test results and artifacts are kept on the local disk, facilitating easy access and management.
- Tests can be executed in local mode using the "runs submit local" Galasa CLI command or within the Eclipse JVM using the Eclipse plugin.

### Components

**Local JVM (Nested Components - Executing):**
- The Local JVM represents the Java Virtual Machine running locally.
- Within the Local JVM, the "Galasa Framework" and "Testcase Class" execute tests.
- All test processes run on the local machine, with no reliance on external ecosystems.

**Local File System (Nested Components - Bootstrap, Stored):**
- The Local File System serves as the central repository for configurations and results when running tests locally.
- The "Bootstrap" component remains blank, containing no reference to external ecosystems.
- The "Galasa Configuration" is stored locally and contains all necessary configuration data.
- Test results and related artifacts are stored on the local disk, ensuring everything remains on the local machine.

