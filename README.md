Please use these command in command line to get started:

1. dart pub global activate fvm -> to install fvm to your main flutter installation, make sure fvm command can be run from command line after doing this, if not, add Pub/Cache/bin (not sure where, depends on OS and installation) to PATH env
2. fvm install -> to install correct flutter version for this project
3. dart pub global activate melos -> to install melos in system, make sure melos command can be run from command line after doing this, should be done if fvm (step 1 & 2) already setup properly
4. melos bootstrap -> to run flutter pub get for all available packages
5. copy .env.example in root project to .env in root project, edit according to development environment
6. melos env -> generate .env dart code based on .env files
7. melos translate -> generate translation dart code based on .arb files
8. flutter run -> to run the app