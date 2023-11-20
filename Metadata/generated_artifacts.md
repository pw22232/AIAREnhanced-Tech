[Generated Artificats](https://galasa.dev/docs/writing-own-tests/setting-up-galasa-project)

```
.
└── dev.galasa.example.banking
    ├── dev.galasa.example.banking.account
    │   ├── bnd.bnd
    │   ├── build.gradle
    │   ├── pom.xml
    │   └── src
    │       └── main
    │           ├── java
    │           │   └── dev
    │           │       └── galasa
    │           │           └── example
    │           │               └── banking
    │           │                   └── account
    │           │                       ├── TestAccount.java
    │           │                       └── TestAccountExtended.java
    │           └── resources
    │               └── textfiles
    │                   └── sampleText.txt
    ├── dev.galasa.example.banking.obr
    │   ├── build.gradle
    │   └── pom.xml
    ├── dev.galasa.example.banking.payee
    │   ├── bnd.bnd
    │   ├── build.gradle
    │   ├── pom.xml
    │   └── src
    │       └── main
    │           ├── java
    │           │   └── dev
    │           │       └── galasa
    │           │           └── example
    │           │               └── banking
    │           │                   └── payee
    │           │                       ├── TestPayee.java
    │           │                       └── TestPayeeExtended.java
    │           └── resources
    │               └── textfiles
    │                   └── sampleText.txt
    ├── pom.xml
    └── settings.gradle
```

### Generated Artifacts
- **Folder Structure:** The generated artifacts follow a hierarchical folder structure.
- **Parent Project:** The top-level project is called "dev.galasa.example.banking." It acts as a container for all generated files.
- **Sub-Projects:** Within the parent project, there are three generated OSGi bundle sub-projects: payee, account, and obr (OSGi Bundle Repository).

### Parent Project:
- **Use in Maven:** The parent project's `pom.xml` is used to build all other generated files in Maven.
- **Settings in Maven:** Key elements like `<groupId>`, `<artifactId>`, `<version>`, and `<packaging>` are defined.
  `\<modules>` lists the sub-modules contained within the parent project.
- **Other Elements:** Elements like `<distributionManagement>`, `<properties>`, `<dependencyManagement>`,
  `<dependencies>`, and `<plugins>` control various aspects of the project.

###  Sub-Projects:
- **Pom.xml:** Each sub-project includes a `pom.xml` for use by the build tool (either Maven or Gradle).
- **Build.gradle and bnd.bnd:** Additional configuration files for Gradle are included.
- **Source Code:** Each sub-project contains source code organized under the `src` directory, including Java files.
- **Resource Files:** A text resource file in each feature test project is used at runtime.
- **Tests:** Tests are divided into categories such as "account" and "payee."

### Pom.xml Elements:
- **Parent Pom.xml Elements:** Elements like `<project>`, `<modelVersion>`, `<groupId>`,
  `<artifactId>`, `<version>`, and `<packaging>` are used for project definition.
- **Modules:** `<modules>` lists the sub-modules contained within the parent project.
- **Dependency Management:** Defines versions of dependencies for all sub-modules.
- **Properties:** Specifies properties like file encoding and Java version.
- **Plugins:** Identifies the Maven plugins used in the build process.

### Importing Projects:
- **Eclipse Integration:** Instructions are provided on how to import these projects into Eclipse for easier development.


# Stakeholders

## Generated Artifacts:

### Entry Level
- **Folder Structure:** The created files are organized in a clear folder system.
- **Parent Project:** There's a main project folder named "dev.galasa.example.banking" that holds all the files.
- **Sub-Projects:** Inside the main folder, there are three smaller projects related to payee, account, and OSGi Bundle Repository (obr).

### Specialist
- **Folder Structure:** Artifacts adhere to a systematic hierarchical folder organization.
- **Parent Project:** The overarching project, "dev.galasa.example.banking," serves as an aggregate container for all generated artifacts.
- **Sub-Projects:** The parent project encompasses three OSGi bundle sub-projects: payee, account, and obr.

## Parent Project:

### Entry Level
- **Use in Maven:** A special file in the main project, `pom.xml`, is used to build everything in Maven, a tool for building and managing software.
- **Settings in Maven:** This file sets up important details like the project's name, version, and how it's packaged.
- **Other Elements:** It also contains settings for how the project is distributed, its properties, dependencies, and what plugins are used.

### Specialist
- **Use in Maven:** The parent project's `pom.xml` orchestrates the Maven build process for all nested projects.
- **Settings in Maven:** It defines foundational Maven elements such as `<groupId>`, `<artifactId>`, `<version>`, and `<packaging>`. `<modules>` enumerates the included sub-projects.
- **Other Elements:** It also includes configurations for `<distributionManagement>`, `<properties>`, `<dependencyManagement>`, `<dependencies>`, and `<plugins>`, each governing different facets of the Maven build lifecycle.

## Sub-Projects:

### Entry Level
- **Pom.xml:** Each smaller project has its own `pom.xml` file for building it.
- **Build.gradle and bnd.bnd:** There are extra setup files for those using Gradle, another building tool.
- **Source Code:** Each has a `src` directory with Java code.
- **Resource Files:** There's a text file in each project used when the software runs.
- **Tests:** Tests are grouped by their category, like "account" or "payee."

### Specialist
- **Pom.xml:** Each sub-project is equipped with its own `pom.xml` for Maven or Gradle builds.
- **Build.gradle and bnd.bnd:** These projects include additional configuration files for Gradle, such as `build.gradle` and `bnd.bnd`.
- **Source Code:** They contain structured source code within the `src` directory, predominantly Java files.
- **Resource Files:** Each project incorporates runtime-utilized text resource files.
- **Tests:** Test cases are segregated based on functional domains like "account" and "payee."

## Pom.xml Elements:

### Entry Level
- **Parent Pom.xml Elements:** The main `pom.xml` file has elements that define the project's basic details.
- **Modules:** It lists all the smaller projects inside the main one.
- **Dependency Management:** Sets the versions for all dependencies (parts the project needs) across the sub-projects.
- **Properties:** Defines basic settings like file format and Java version.
- **Plugins:** Lists the tools used during the build process.

### Specialist
- **Parent Pom.xml Elements:** The root `pom.xml` integrates elements like `<project>`, `<modelVersion>`, `<groupId>`, `<artifactId>`, `<version>`, and `<packaging>` for overall project specification.
- **Modules:** `<modules>` delineates the constituent sub-projects under the parent project.
- **Dependency Management:** It centralizes dependency version management for all sub-modules.
- **Properties:** Defines key project properties, including file encoding and Java compiler version.
- **Plugins:** Specifies the Maven plugins deployed in the build process.

## Importing Projects:

### Entry Level
- **Eclipse Integration:** There are steps on how to add these projects to Eclipse, a software development tool, to make working on them easier.

### Specialist
- **Eclipse Integration:** Detailed guidelines are provided for importing these projects into the Eclipse IDE, facilitating a more streamlined development workflow.
