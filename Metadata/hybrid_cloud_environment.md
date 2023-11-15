[Using Galasa in a Hybrid Cloud Environment](https://galasa.dev/about)

![](galasa-hybrid-cloud.png)

## General Information
- Hybrid cloud environments combine different platforms and technologies for enhanced efficiency, security, and performance.
- End-to-end integration testing in such environments can be complex.
- Galasa simplifies this testing by providing a comprehensive testing framework.
- The framework enables the testing of applications running on diverse platforms (z/OS and Cloud) and utilizing various technologies.
- The centralized storage of test results and artifacts simplifies reporting and failure analysis.

## Components 

### Galasa Test
- The Galasa test plays a crucial role in end-to-end integration testing in a hybrid cloud environment.
- It can be initiated from an IDE or as part of a CI/CD pipeline.
- Galasa initializes the test environment, generates test data, executes the test, and validates the test output.
- All test results and artifacts are centrally stored for easy report generation and failure diagnosis.

### 3270 Emulator 
- The 3270 emulator is an essential component for simulating mainframe interactions in a hybrid cloud setup.

### Application
- The "Application" nest represents the core of the hybrid cloud application.
- It contains several key components for end-to-end testing.

### Web Browser
- The "Web browser" component represents the user interface and interactions with the application.

### Database
- The database component stores critical data for the hybrid cloud application.

### On/Off Premise Cloud
- The "On/Off premise cloud" nest indicates the dual nature of cloud hosting.

### Cloud Hosted Web Server
- This component signifies a web server hosted in the cloud.

### z/OS LPAR
- The "z/OS LPAR" nest represents a mainframe environment.
- It contains components related to mainframe technology.

### Batch Job
- The "Batch job" component signifies the execution of batch processes on the mainframe.

### CICS Application
- The "CICS application" component relates to Customer Information Control System (CICS) applications on the mainframe.












