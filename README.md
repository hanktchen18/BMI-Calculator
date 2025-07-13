# BMI-Calculator
A simple BMI Calculator iOS app built with Swift and UIKit.
![proj_7](https://github.com/user-attachments/assets/0b0bae6f-60ac-491d-b46e-996ad4477dce)

## Requirements

- Xcode 15 or higher  
- iOS 15.0+  
- Swift 5  
- Internet connection (for API call)  

---

## Installation

1. Clone this repository or download the project files.
2. Open the `.xcodeproj` in **Xcode**.
3. Build and run on Simulator or a physical device.

---

## How to Use

1. Enter **Height (inches)** and **Weight (pounds)** in the respective fields.
2. Tap **Calculate BMI**:
   - The app will validate your input.
   - It sends your height and weight to the Web API:
     ```
     https://jig2ag6wwdvb52n6jrexlf3n7u0comxh.lambda-url.us-west-2.on.aws/?height=VALUE&weight=VALUE
     ```
   - Displays the calculated BMI, health risk level, and a success message.
3. Tap **Educate Me** to open a recommended educational article based on your BMI result.

---

## Features

- Opens recommended health education articles in-app via `SFSafariViewController`

- Validates empty and non-numeric input
- Calls a real-time Web API for BMI and risk evaluation
- Displays color-coded health risk (e.g., green = healthy, red = high risk)
- Error messages for:
  - Empty input
  - Invalid numeric format
  - API/network failure
  - JSON parsing errors

---

## What I Learned

- Using `UITextField`, `UILabel`, and `@IBAction` in UIKit to handle form inputs and actions
- Validating user input and converting `String` to `Int`
- Making asynchronous API calls with `URLSession` and decoding JSON using `Codable`
- Updating UI on the main thread using `DispatchQueue.main.async`
- Embedding Safari in-app with `SFSafariViewController`
- Providing responsive user feedback with error and success messages
