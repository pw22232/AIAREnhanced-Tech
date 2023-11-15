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
