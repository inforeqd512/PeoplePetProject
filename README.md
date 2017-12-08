# PeoplePetProject

## Prerequisites

- **_Java_** - Java runtime _v7_ or _v8_ and above.
- **_swagger-codegen_** - _snapshot version 2.3.0_ is required.
- **_CocoaPods_** - _cocoapods_ must have been already installed.


## Network API

- Swagger specs helps set the contract that the service should adhere to
- Swagger codegen used to perform network calls per specs 
- This helps automate writing network code 

## Patterns used
- Repository used to abstract network calls and caching
- View model for making view logic testable, thus testing as much as possible via unit tests
- Business logic separated to make it testable
- Unit tests for what's important eg. business and view model logic

## Testing
- Test coverage reports enabled
- Test should run at CI checkin for being ready for continous deployment
- Although have included network tests using mock for the task, IMHO this is an anti-pattern as due to having many expectations, it takes longer to run. This makes unit tests run slower at each CI checkin. Instead contract tests can be written in JS and run on node servers at every backend deployment instead
- UI tests for system integration testing. Not really necessary for this app, but may be helpful to test key business flows
