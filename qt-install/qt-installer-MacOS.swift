import Foundation

let qtCreatorVersion = "6.0.3"
let qtCreatorDownloadURL = "https://download.qt.io/official_releases/qt-creator/\(qtCreatorVersion)/qt-creator-opensource-mac-x86_64-\(qtCreatorVersion).dmg"

do {
    // Download the Qt Creator installation DMG
    let downloadLocation = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("qt-creator.dmg")
    try Data(contentsOf: URL(string: qtCreatorDownloadURL)!).write(to: downloadLocation)
    
    // Mount the DMG
    let mountPoint = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("qt-creator")
    try Process.run(["hdiutil", "attach", downloadLocation.path, "-mountpoint", mountPoint.path])
    
    // Install Qt Creator
    try Process.run(["sudo", "\(mountPoint.path)/Qt\ Creator.app/Contents/MacOS/installbuilder.sh", "-verbose"])
    
    // Unmount the DMG
    try Process.run(["hdiutil", "detach", mountPoint.path])
    
    // Clean up
    try FileManager.default.removeItem(at: downloadLocation)
    
    print("Qt Creator \(qtCreatorVersion) installed successfully")
} catch {
    print("Failed to install Qt Creator \(qtCreatorVersion): \(error)")
}
