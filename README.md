# How to use Design Patterns and Unit Tests to create High Quality Systems
 
This project was created for my presentation on how to use Design Patterns and Unit Tests to create High-Quality Systems for the "Coding Bootcamp 2023 – Learn to Program" event on August 18, 2023.


## Topics Covered in this project

- Clean Architecture
- Clean Code
- SOLID
- Domain-Driven Design - DDD
    - Bounded Contexts
    - Entities
    - Aggregates
    - Domain Services
    - Domain Events
- Design Patterns
    - Dependency Injection
    - Repository
    - Specification
- ORM
- Unit testing
    - Mocking

## Benefits

The main benefits obtained from Clean Architecture, Design Patterns, especially Dependency Injection, and unit testing are:

- Improving code quality and maintainability.
- Reducing coupling and increasing class cohesion.
- Facilitating error detection and correction.
- Boosting developers' confidence and productivity.


## Delphi Version

The project was developed using "Delphi 11 Version 28.0.47991.2819".


## Database

The Sqlite_demo database that comes with the FireDAC installation. This way, you won't need to install a separate DBMS or manually create the database.


## Dependency

The project uses Spring4D framework, which is the only external dependency you need to install. Dependency Injection, Collections, Persistence, and Mocks functionalities are all available within this framework.

If you don't have Spring4D installed yet, download it from the project repository at https://bitbucket.org/sglienke/spring4d/src/develop/. 

The develop branch in the example, and I suggest you do the same, as the master branch might not be compatible.

I won't go through the Spring4D installation steps here, as there are several tutorials available online on how to install the library. For your convenience, I'll list the steps below:
- Download the Spring4D source code from the official repository.
- Make sure you're using the develop branch with the "git branch" command.
- Run the "Build.exe" installer in the project directory and follow the instructions.

## Unit Testing

The Test project was created using the DUnitX framework that is available in the default Delphi installer.


