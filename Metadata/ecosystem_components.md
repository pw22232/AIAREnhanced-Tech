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





