# tourism_basic_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

- https://fluttercrashcourse.com/

- flutter downgrade 2.10

### Open ios simulator using following command
- open -a simulator

### For Android use android studio -> Virtual device manager -> Select device and click on play

- If you are using the command line you can launch the emulator using this command:
-   flutter emulators --launch [emulator-id]

-   https://lormenyoh.medium.com/resetting-for-cold-boot-emulator-engine-failed-fixed-8d8aaffd1c7c

- run following command to generate model classes, you have to do it once or whenever model changes
- also need to do install packages in dependencies json_annotation, and in dev_dependencies
- json_serializable, build_runner

-       flutter packages pub run build_runner build
-   with delete conflicting files using -d or --delete-conflicting-outputs 
-       flutter packages pub run build_runner build --delete-conflicting-outputs

- https://docs.flutter.dev/development/data-and-backend/json

- https://docs.google.com/document/d/1wbiXe81x1OWSqB-mSCWLOvIGngZpB3J6JAlD8CO6zyQ/edit
- https://github.com/seenickcode/fluttercrashcourse-lessons

- Simulate slow loading time - app called Charles proxy
    