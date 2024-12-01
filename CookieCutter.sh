#!/bin/bash

# Gebruik:
# `# ./SwiftCookieCutter.sh <projectnaam>`

# Controleer of er een projectnaam is opgegeven
if [ -z "$1" ]; then
  echo "❌ Geef een daynaam op als argument aan het script."
  exit 1
fi

# Controleer of de juiste commando's beschikbaar zijn
# swift
if ! type "swift" > /dev/null; then
  echo "❌ Please install the Swift Language"
fi

# git
if ! type "git" > /dev/null; then
  echo "❌ Please install the git cli"
fi

# github
if ! type "git" > /dev/null; then
  echo "❌ Please install Github cli (gh)"
fi

# Maak een nieuwe directory voor het project
mkdir "Day$1"
cd "Day$1" || exit
echo "✅ Successfully created new project directory"


# Maak een nieuw Swift Package project
echo "🚧 Creating a new Swift Package project"
swift package init
echo "✅ Successfully created a new Swift Package project"

# Voeg een test target toe aan de Package.swift
cat <<EOT > Package.swift
// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Day$1",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Day$1",
            targets: ["Day$1"]
        )
    ],
    dependencies: [
        .package(name: "Shared", path: "../Shared")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Day$1",
            dependencies: ["Shared"]
        ),
        .testTarget(
            name: "Day$1Tests",
            dependencies: ["Day$1"]
        ),
    ]
)

EOT
echo "✅ Successfully added sample test"

echo ""

echo "🚧 Perform clean build and initial test run"
# Voer schoon opzetten van het project uit voor eventuele fouten
swift build

# Voer de tests uit
swift test
echo "✅ Successfully built project and performed test run"

echo ""

# Creeer een NOTES.md
cat <<EOT > NOTES.md
# AoC Day $1 - 📝 Notes from the journey 🍅 by 🍅

## 🏷️ Labels

- ✅ done
- 🚧 WIP
- ❌ ERROR
- ⚠️ TODO

## 🍅 Pomodoro 1
- ⚠️ Read the description
- ⚠️ Import the input data
- ⚠️ Make the example input pass
EOT

echo "✅ Successfully created template NOTES.md"

# Setup gitignore to not exclude Input.swift
cat <<EOT > .gitignore
.DS_Store
/.build
/Packages
xcuserdata/
DerivedData/
.swiftpm/configuration/registries.json
.swiftpm/xcode/package.xcworkspace/contents.xcworkspacedata
.netrc
Input.swift
EOT

echo "✅ Successfully created gitignore"

echo ""

# go back to top directory to commit changes
cd ..
git add .
git commit -m "Day$1 scaffold setup"
cd Day$1

echo ""

echo "✅ Swift PM project 'Day$1' succesvol aangemaakt. Veel plezier met AoC!"