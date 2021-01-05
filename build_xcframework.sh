#!/usr/bin/env

# This script builds a very simple library for illustrative purposes.

echo "Cleaning..."
rm -rf ./build
rm ./ExampleLibrary.framework
rm -rf ./ExampleLibrary.xcframework

echo "Building for iOS..."
xcodebuild archive \
    -sdk iphoneos IPHONEOS_DEPLOYMENT_TARGET=9.0 \
    -arch armv7 -arch arm64 \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
    -scheme "ExampleLibrary" \
    -archivePath "./build/iphoneos/ExampleLibrary.xcarchive" SKIP_INSTALL=NO

echo "Building for iOS Simulator..."
xcodebuild archive \
    -sdk iphonesimulator IPHONEOS_DEPLOYMENT_TARGET=9.0 \
    -arch x86_64 -arch arm64 \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
    -scheme "ExampleLibrary" \
    -archivePath "./build/iphonesimulator/ExampleLibrary.xcarchive" SKIP_INSTALL=NO

echo "Building for Catalyst..."
xcodebuild archive \
    MACOSX_DEPLOYMENT_TARGET=10.15 \
    -destination "platform=macOS,variant=Mac Catalyst" \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
    -scheme "ExampleLibrary" \
    -archivePath "./build/maccatalyst/ExampleLibrary.xcarchive" SKIP_INSTALL=NO

echo "Building for MacOS..."
xcodebuild archive \
    -sdk macosx MACOSX_DEPLOYMENT_TARGET=11.0 \
    -arch x86_64 -arch arm64 \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
    -scheme "ExampleLibrary" \
    -archivePath "./build/macosx/ExampleLibrary.xcarchive" SKIP_INSTALL=NO

# The old way - building a framework that supports iOS and Simulator by lipo-ing them into one framework
echo "Building Framework with iOS and iOS Simulator support..."
lipo -create -output "./ExampleLibrary.framework" \
	"./build/iphoneos/ExampleLibrary.xcarchive/Products/Library/Frameworks/ExampleLibrary.framework/ExampleLibrary" \
	"./build/iphonesimulator/ExampleLibrary.xcarchive/Products/Library/Frameworks/ExampleLibrary.framework/ExampleLibrary"

# The new way - building an xcframework that supports everything
echo "Building XCFramework..."
xcodebuild -create-xcframework -output ./ExampleLibrary.xcframework \
	-framework "./build/iphoneos/ExampleLibrary.xcarchive/Products/Library/Frameworks/ExampleLibrary.framework" \
	-framework "./build/iphonesimulator/ExampleLibrary.xcarchive/Products/Library/Frameworks/ExampleLibrary.framework" \
    -framework "./build/maccatalyst/ExampleLibrary.xcarchive/Products/Library/Frameworks/ExampleLibrary.framework" \
    -framework "./build/macosx/ExampleLibrary.xcarchive/Products/Library/Frameworks/ExampleLibrary.framework"