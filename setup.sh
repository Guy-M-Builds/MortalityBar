#!/bin/bash
# MortalityBar — Project Setup
# Run this script after installing Xcode to generate the .xcodeproj

set -e
cd "$(dirname "$0")"

echo "=== MortalityBar Setup ==="

# Check for Xcode
if ! xcodebuild -version &>/dev/null; then
    echo "ERROR: Full Xcode installation required (not just Command Line Tools)."
    echo "Install Xcode from the Mac App Store, then run:"
    echo "  sudo xcode-select -s /Applications/Xcode.app/Contents/Developer"
    exit 1
fi

# Option 1: Use xcodegen if available
if command -v xcodegen &>/dev/null; then
    echo "Generating project with xcodegen..."
    xcodegen generate
    echo "Done! Open MortalityBar.xcodeproj"
    open MortalityBar.xcodeproj
    exit 0
fi

# Option 2: Use swift package generate-xcodeproj (deprecated but works)
echo "xcodegen not found. Trying swift package generate-xcodeproj..."
if swift package generate-xcodeproj 2>/dev/null; then
    echo "Done! Open MortalityBar.xcodeproj"
    echo "NOTE: You may need to manually set LSUIElement=YES in build settings."
    open MortalityBar.xcodeproj
    exit 0
fi

# Option 3: Manual instructions
echo ""
echo "Could not auto-generate .xcodeproj."
echo ""
echo "To set up manually:"
echo "1. Open Xcode → File → New → Project → macOS → App"
echo "2. Name: MortalityBar, Interface: SwiftUI, Language: Swift"
echo "3. Save to ~/MortalityBar (replace the auto-generated folder)"
echo "4. Delete the auto-generated ContentView.swift"
echo "5. Drag all .swift files from MortalityBar/ into the Xcode project"
echo "6. In target → Info, add LSUIElement = YES"
echo "7. Set deployment target to macOS 13.0"
echo "8. Build & Run (⌘R)"
echo ""
echo "Or install xcodegen: brew install xcodegen"
