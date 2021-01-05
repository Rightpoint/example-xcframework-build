This repo supports the article ["Why XCFrameworks Matter"](https://www.rightpoint.com/rplabs/2021/01/why-xcframeworks-matter/) on the Rightpoint Blog. This article illustrates why XCFrameworks are preferred over universal frameworks going forward, and shows how one might build their own using the terminal.

There's a very simple Xcode project in here that builds an iOS framework. `build_framework.sh` shows the process of creating a Universal Framework from this codebase supporting iOS and the iOS Simulator. It also shows the newer, preferred process of assembling an XCFramework that supports iOS, iOS Simulator, Catalyst, and MacOS.

## Usage

1. Open the Xcode project and replace the signing info with your own.
2. Open the terminal at the repo root and run `sh ./build_xcframework.sh`.

The output will be ExampleLibrary.xcframework and ExampleLibrary.framework in the repo root.

## A note from the author

The Xcode project is very, very simple if you want to reproduce it. All I did was make a new iOS Framework project using the "New Project" wizard in Xcode, add my signing info, and add a single Swift file.
