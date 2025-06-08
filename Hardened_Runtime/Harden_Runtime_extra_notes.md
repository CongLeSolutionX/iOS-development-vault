---
created: 2025-03-20 05:31:26
author: Cong Le
version: "1.0"
license(s): MIT, CC BY 4.0
copyright: Copyright (c) 2025 Cong Le. All Rights Reserved.
---



# Hardened_Runtime - More notes
> **Disclaimer:**
>
> This document contains my personal notes on the topic,
> compiled from publicly available documentation and various cited sources.
> The materials are intended for educational purposes, personal study, and reference.
> The content is dual-licensed:
> 1. **MIT License:** Applies to all code implementations (Swift, Mermaid, and other programming languages).
> 2. **Creative Commons Attribution 4.0 International License (CC BY 4.0):** Applies to all non-code content, including text, explanations, diagrams, and illustrations.
---


Below is a comprehensive list and explanation of the entitlements used in conjunction with Hardened Runtime and how they relate to your `Info.plist`. Remember to use Xcode's Capabilities tab to simplify the process.




Let's consolidate the entitlements related to Hardened Runtime that would be used in an app's `Info.plist` (or, more accurately, referenced in the entitlements file and *affect* what might be in `Info.plist`). It's crucial to remember that the entitlements themselves aren't *directly* in `Info.plist`; they are in a separate `.entitlements` file. However, some entitlements *require* corresponding entries in `Info.plist` (the usage description strings). I'll clearly distinguish these.

Here's a breakdown, categorized as they were in our previous discussions:

---

## 1. Runtime Exceptions (Entitlements - in `.entitlements` file)

These are the entitlements that relax the Hardened Runtime's default restrictions. They go in your `.entitlements` file, *not* directly in `Info.plist`.

*   **`com.apple.security.cs.allow-jit`**:
    *   **Purpose:** Allows Just-In-Time (JIT) code compilation.
    *   **`Info.plist` Connection:**  No direct `Info.plist` key.  However, if you're using `JavaScriptCore`, Apple's documentation and best practices strongly suggest you should explain *why* you need JIT in your app's documentation and potentially in a privacy-related section if you collect data via JavaScript.
*   **`com.apple.security.cs.allow-unsigned-executable-memory`**:
    *   **Purpose:** Allows unsigned executable memory.
    *   **`Info.plist` Connection:** No direct `Info.plist` key. This is generally discouraged.
*   **`com.apple.security.cs.allow-dyld-environment-variables`**:
    *   **Purpose:** Allows the use of potentially dangerous DYLD environment variables.
    *   **`Info.plist` Connection:** No direct `Info.plist` key.  Primarily for debugging.
*   **`com.apple.security.cs.disable-library-validation`**:
    *   **Purpose:** Disables library validation (allows loading unsigned or improperly signed libraries).
    *   **`Info.plist` Connection:** No direct `Info.plist` key. This is a significant security risk.
*   **`com.apple.security.cs.disable-executable-page-protection`**:
    *    **Purpose:** Disables code signing protection
    *   **`Info.plist` Connection:** No direct `Info.plist` key. This is *extremely* risky.
*   **`com.apple.security.get-task-allow`**:
    *   **Purpose:** Allows debugging tools to attach to the process.  This is *essential* for development but should be removed before distribution.
    *   **`Info.plist` Connection:**  No direct `Info.plist` key, but critically, this entitlement should *only* be present in your development builds, *never* in a build you ship to users.  Xcode handles this automatically if you set the "Debugging Tool" capability appropriately.

---

## 2. Resource Access (Entitlements - in `.entitlements` file, *with* `Info.plist` connections)

These entitlements control access to sensitive resources and *always* require corresponding usage description strings in `Info.plist`.

*   **`com.apple.security.device.audio-input`**:
    *   **Purpose:** Allows access to the microphone.
    *   **`Info.plist` Key:**  `NSMicrophoneUsageDescription` (String).  You *must* provide a human-readable explanation of why your app needs microphone access. Example: "This app uses the microphone to record voice memos."
*   **`com.apple.security.device.camera`**:
    *   **Purpose:** Allows access to the camera.
    *   **`Info.plist` Key:** `NSCameraUsageDescription` (String).  You *must* provide a human-readable explanation. Example: "This app uses the camera to take photos and videos."
*   **`com.apple.security.personal-information.location`**:
    *   **Purpose:** Allows access to location services.
    *   **`Info.plist` Keys:**
        *   `NSLocationWhenInUseUsageDescription` (String): Required if you request "when in use" location access.
        *   `NSLocationAlwaysAndWhenInUseUsageDescription` (String): Required if you request "always" location access.  You also need to explain *why* "always" access is necessary.
        *   `NSLocationUsageDescription` (String): A fallback key, but prefer the more specific ones above.
        *   `NSLocationAlwaysUsageDescription` is deprecated.
        * Provide clear explanations. Example: "This app uses your location to show nearby points of interest."
*   **`com.apple.security.personal-information.contacts`**:
    *   **Purpose:** Allows access to the user's contacts.
    *   **`Info.plist` Key:** `NSContactsUsageDescription` (String).  Example: "This app uses your contacts to let you easily share with friends."
*   **`com.apple.security.personal-information.calendars`**:
    *   **Purpose:** Allows access to the user's calendars.
    *   **`Info.plist` Key:** `NSCalendarsUsageDescription` (String). Example: "This app uses your calendar to schedule reminders."
*   **`com.apple.security.personal-information.photos-library`**:
    *   **Purpose:** Allows access to the user's photo library.
    *   **`Info.plist` Keys:**
        *   `NSPhotoLibraryUsageDescription` (String): Required for full photo library access.  Example: "This app lets you import photos from your library."
        *   `NSPhotoLibraryAddUsageDescription` (String): Required if your app *only* needs to add photos to the library, *not* read the entire library.  This is more privacy-preserving. Example: "This app saves edited photos to your library."
*   **`com.apple.security.personal-information.apple-events`**:
*   **`com.apple.security.automation.apple-events`**:
    *   **Purpose:** Allows sending Apple Events to other applications.
    *   **`Info.plist` Key:** `NSAppleEventsUsageDescription` (String). Explain which applications your app communicates with and why. Example: "This app controls [Other App Name] to automate tasks."  You may also need individual entitlements for specific applications you target with Apple Events; these are of the form `com.apple.security.scripting-targets` and require listing the specific scripting commands allowed.
    * **Example Entitlements File**:


```md
# xml file 
<key>com.apple.security.automation.apple-events</key>
<true/>
<key>com.apple.security.scripting-targets</key>
<dict>
    <key>com.apple.TextEdit</key>
    <array>
        <string>com.apple.TextEdit.text.open</string>
        <string>com.apple.TextEdit.text.close</string>
    </array>
</dict>
```


**Important Considerations and Best Practices:**

*   **Xcode Capabilities Tab:** The easiest way to manage these entitlements is through the "Signing & Capabilities" tab in your Xcode project settings.  Adding a capability (like "Camera") will automatically add the necessary entitlement to your `.entitlements` file and prompt you to add the usage description to your `Info.plist`.
*   **`Info.plist` Usage Descriptions:** These are *critical*.  If you request an entitlement that requires a usage description and don't provide one, your app will crash at runtime when it tries to access the resource.  The descriptions must be clear, concise, and accurate.
*   **Principle of Least Privilege:**  Only request the entitlements your app *absolutely* needs.  This minimizes the risk to your users and makes your app more likely to be approved during App Review.
*   **Privacy-Preserving Alternatives:**  Whenever possible, consider using more privacy-preserving APIs.  For example, instead of requesting full photo library access, use `PHPickerViewController` to let the user select specific photos.
*   **App Review:** Apple reviewers will scrutinize your app's use of entitlements and usage descriptions.  Be prepared to justify your choices.
*   **Testing:**  Thoroughly test your app with Hardened Runtime enabled to ensure that all entitlements are correctly configured and that your app behaves as expected.
*   **Documentation:**  Keep your app's documentation (both internal and user-facing) up-to-date with information about which entitlements you use and why.

---


---

<!-- 
```mermaid
%% Current Mermaid version
info
```  -->


```mermaid
---
title: "CongLeSolutionX"
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY-SA 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
config:
  theme: base
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%{
  init: {
    'flowchart': { 'htmlLabels': false },
    'fontFamily': 'Bradley Hand',
    'themeVariables': {
      'primaryColor': '#fc82',
      'primaryTextColor': '#F8B229',
      'primaryBorderColor': '#27AE60',
      'secondaryColor': '#81c784',
      'secondaryTextColor': '#6C3483',
      'lineColor': '#F8B229',
      'fontSize': '20px'
    }
  }
}%%
flowchart LR
  My_Meme@{ img: "https://raw.githubusercontent.com/CongLeSolutionX/CongLeSolutionX/refs/heads/main/assets/images/My-meme-light-bulb-question-marks.png", label: "Ăn uống gì chưa ngừi đẹp?", pos: "b", w: 200, h: 150, constraint: "off" }

  Closing_quote@{ shape: braces, label: "...searching insights in the process of formulating better questions..." }
    
  My_Meme ~~~ Closing_quote
    
  Link_to_my_profile{{"<a href='https://github.com/CongLeSolutionX' target='_blank'>Click here if you care about my profile</a>"}}

  Closing_quote ~~~ My_Meme
  My_Meme animatingEdge@--> Link_to_my_profile
  
  animatingEdge@{ animate: true }

```


---
**Licenses:**

- **MIT License:**  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) - Full text in [LICENSE](LICENSE) file.
- **Creative Commons Attribution 4.0 International:** [![License: CC BY 4.0](https://licensebuttons.net/l/by/4.0/88x31.png)](LICENSE-CC-BY) - Legal details in [LICENSE-CC-BY](LICENSE-CC-BY) and at [Creative Commons official site](http://creativecommons.org/licenses/by/4.0/).

---
