A sleek iOS application built with SwiftUI and UIKit for high-performance QR and barcode scanning and generation.

✨ Key Features
 * High-Performance Scanning: Integrates AVFoundation (UIKit) for a reliable and fast QR & barcode scanning experience.
 * Custom Animations: Features a dynamic scanning line animation for an engaging and modern interface.
 * Smart URL Detection: Automatically detects HTTP/HTTPS URLs in scanned QR codes and provides an option to open them directly in Safari.
 * Code Generation: The "Generator" screen allows users to:
   * Choose between generating a QR code or a Barcode (like Code 128).
   * Save generated codes directly to the device's Photos Library.
   * Share codes easily using the native iOS Share Sheet.
 * Modern UI: Built entirely with SwiftUI, including a TabView for easy navigation between the Scanner and Generator screens.
 * Hybrid Framework: Seamlessly integrates UIKit components (like the camera view) within the SwiftUI hierarchy.
   
🏛️ Architecture
This project is built using the MVVM (Model-View-ViewModel) design pattern. This architecture separates the UI (View) from the business logic (ViewModel) and data (Model), resulting in a codebase that is:
 * Clean: Easy to read and navigate.
 * Maintainable: Simplifies updates and bug fixes.
 * Testable: Allows for isolated unit testing of the business logic.
   
🧰 Tech Stack
 * Frameworks: SwiftUI, UIKit (AVFoundation), CoreImage (for QR generation), PhotosUI
 * Language: Swift
 * Architecture: MVVM
 * Tools: Xcode 16
 * Platform: iOS 18

> Note: To test scanning, you will need to run the app on a physical iPhone or iPad, as the simulator does not have a camera and you will see an alert saying this in the application.


![IMG_1607](https://github.com/user-attachments/assets/d0d30260-90f4-48f3-aaff-c25e01404240)
![IMG_1608](https://github.com/user-attachments/assets/be4a341e-9585-45ed-b98e-f22de0e54b07)
![IMG_1609](https://github.com/user-attachments/assets/df130970-08dd-48fa-8b63-8bf18cf11edd)
![IMG_1612](https://github.com/user-attachments/assets/3000f89a-1422-4fea-a107-9e8864b19a5d)
![IMG_1611](https://github.com/user-attachments/assets/1c6b4c9c-01b7-4aab-ad50-dd121447d040)
![IMG_1614](https://github.com/user-attachments/assets/9dc95563-f8c3-4e7b-8ef0-b10383920cab)
