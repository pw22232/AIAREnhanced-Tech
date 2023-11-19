[Ecosystem Components](https://galasa.dev/docs/ecosystem/architecture)

![Ecosystem Components](ecosystem_components.png)

## General Information:

### Galasa Stores:
- CPS, DSS, RAS, and CREDs serve as key stores for configuration, status, results, and credentials.
- etcd maintains a consistent source of truth for ecosystem status.

### Galasa Servers:
- Engine Controller orchestrates test engine instantiation and management.
- Resource Management ensures resource cleanup and de-provisioning.
- API Server acts as the central control point, accessible by IDEs and pipelines.
- Bootstrap Server stores initial configuration.
- Web UI (future release) provides a dashboard for managing and analyzing tests.
- LDAP authentication server (future release) enables LDAP authentication.

### Code Deployment:
- Maven Repositories and OBRs host compiled artifacts in OSGi bundles.
- Nexus server facilitates deployment of Maven artifacts and Docker images.

### Optional Reporting Servers:
- Prometheus scrapes and stores metrics.
- Grafana visualizes Prometheus metrics.
- Elasticsearch records automated test results.
- Kibana visualizes Elasticsearch metrics.

## Components

### CPS/DSS (Configuration Property Store/Dynamic Status Store):
- CPS stores configuration properties for test runs.
- DSS provides real-time status information about the ecosystem and running tests.
- Together, they ensure efficient test orchestration and resource allocation.

### RAS (Result Archive Store):
- RAS is a centralized database storing test results, logs, and artifacts.
- It aids in diagnosing test failures and simplifies result access for teams.

### Engine Controller:
- Responsible for scaling test runs within the ecosystem.
- Manages test engines and resource allocation.
- Creates Docker containers or Kubernetes pods for test execution.

### API Server:
- Central control point for the Galasa Ecosystem.
- Used for test submissions and result retrieval from IDEs and pipelines.

### Resource Manager:
- Monitors test and resource usage.
- Performs cleanup actions for stale or manually ended tests.

### Test Engines:
- Execute Galasa automation test runs.
- Interact with resources like Docker engines, Selenium Drivers, and more.

## Resources:

### Docker Engine: 
- Used to execute test runs within containers.
### Selenium Driver: 
- Enables automated interaction with web applications during tests.
### Openstack: 
- Provides cloud infrastructure resources for testing.
### z/OS - DB2: 
- Interfaces with DB2 databases on z/OS.
### z/OS - CISC: 
- Supports testing on CISC systems within the z/OS environment.
### z/OS - MQ: 
- Integrates with MQ (Message Queuing) systems on z/OS.


# Stakeholders

## General Information:

## Entry Level

### Galasa Stores:
- Key systems for storing settings, statuses, results, and passwords.
- etcd keeps a reliable record of the ecosystem's status.

### Galasa Servers:
- Engine Controller sets up and manages test engines.
- Resource Management takes care of cleaning up and getting rid of resources no longer needed.
- API Server is the main control center, used by coding tools and automated processes.
- Bootstrap Server holds the initial setup information.
- Web UI (coming soon) will let you manage and analyze tests from a dashboard.
- LDAP authentication server (coming soon) will use LDAP for logins.

### Code Deployment:
- Maven Repositories and OBRs keep the compiled software in OSGi bundles.
- Nexus server helps deploy software and Docker images.

### Optional Reporting Servers:
- Prometheus gathers and keeps track of data.
- Grafana shows the data from Prometheus in graphs.
- Elasticsearch keeps automated test results.
- Kibana shows data from Elasticsearch.


## Specialist

### Galasa Stores:
- CPS, DSS, RAS, and CREDs are fundamental repositories for configurations, statuses, results, and credentials.
- etcd maintains an authoritative record of ecosystem health and status.

### Galasa Servers:
- Engine Controller is responsible for the initiation and management of test engines.
- Resource Management oversees resource recycling and de-provisioning.
- API Server serves as the primary interaction hub for IDEs and CI/CD pipelines.
- Bootstrap Server retains the initial configuration setup.
- Web UI (upcoming) will offer a comprehensive management interface for test operations.
- LDAP authentication server (upcoming) will facilitate LDAP-based user authentication.

### Code Deployment:
- Maven Repositories and OBRs are repositories for compiled artifacts in OSGi bundles.
- Nexus server assists in the deployment and distribution of Maven artifacts and Docker images.

### Optional Reporting Servers:
- Prometheus collects and archives system metrics.
- Grafana provides a visualization interface for Prometheus data.
- Elasticsearch logs automated test results for analysis.
- Kibana offers visualization tools for Elasticsearch data.

## Components

## Entry Level

### CPS/DSS (Configuration Property Store/Dynamic Status Store):
- CPS keeps settings for test runs.
- DSS shows real-time information about the ecosystem and tests.
- They work together to manage tests and resources efficiently.

### RAS (Result Archive Store):
- A central place for test results, logs, and files.
- Helps understand test failures and makes it easy for teams to see results.

### Engine Controller:
- Scales test runs in the ecosystem.
- Handles test engines and resource distribution.
- Creates Docker containers or Kubernetes pods for tests.

### API Server:
- The main control center for the Galasa Ecosystem.
- Used for sending tests and getting results from coding tools and pipelines.

### Resource Manager:
- Keeps track of test and resource usage.
- Cleans up after tests that are no longer running.

### Test Engines:
- Run Galasa automated tests.
- Work with tools like Docker engines and Selenium Drivers.

## Specialist

### CPS/DSS (Configuration Property Store/Dynamic Status Store):
- CPS archives configuration properties for test scenarios.
- DSS maintains up-to-date status insights on the ecosystem and active tests.
- Collectively, they facilitate efficient test orchestration and resource management.

### RAS (Result Archive Store):
- RAS consolidates test results, logs, and artifacts in a centralized database.
- It plays a pivotal role in failure diagnostics and simplifies result dissemination.

### Engine Controller:
- Manages the scalability of test execution within the ecosystem.
- Oversees test engine operations and resource allocation.
- Orchestrates the creation of Docker containers or Kubernetes pods for test deployment.

### API Server:
- Acts as the central command unit for the Galasa Ecosystem.
- Integral for test submissions and result retrieval within development environments and CI/CD pipelines.

### Resource Manager:
- Monitors ongoing test and resource consumption.
- Executes cleanup protocols for resources tied to incomplete or terminated tests.

### Test Engines:
- Execute automated testing scenarios under the Galasa framework.
- Interact with an array of resources including Docker engines, Selenium Drivers, and more.

## Resources:

## Entry Level

### Docker Engine: 
- Runs tests inside containers.
### Selenium Driver: 
- Automates interactions with web applications during tests.
### Openstack: 
- Provides cloud resources for testing.
### z/OS - DB2: 
- Works with DB2 databases on z/OS.
### z/OS - CISC: 
- Supports tests on CISC systems in z/OS.
### z/OS - MQ: 
- Connects with MQ systems on z/OS for messaging.

## Specialist

### Docker Engine: 
- Facilitates test execution within isolated container environments.
### Selenium Driver: 
- Enables automated web application testing within test scenarios.
### Openstack: 
- Provides cloud-based infrastructure resources for test environments





