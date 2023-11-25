[Ecosystem Architecture](https://galasa.dev/docs/ecosystem/architecture)

![Ecosystem Architecture](ecosystem_architecture.png)


## Entry Level

### Kubernetes/VM Host Environment:
- Helps manage and run small parts of software.
- Keeps track of software testing and how much computer power is used.
- Automatically cleans up and frees resources when not needed.
- Can grow or reduce its capacity to support Galasa services as needed.

## Galasa Ecosystem:
- Stores and manages settings for running software tests.
- Keeps all the results and details from software tests.
- Lets you connect it with coding tools and automated systems.
- Makes testing software easier and more organized.

## Specialist

### Kubernetes/VM Host Environment:
- Orchestrates microservices for runtime management.
- Monitors tests and resource usage.
- Supports automated resource cleanup.
- Provides a scalable foundation for Galasa services.

### Galasa Ecosystem:
- Centralized repository for run configurations.
- Stores all test results and artifacts.
- Offers a REST endpoint for integration with IDEs and pipelines.
- Powers a unified testing environment for efficient development.

