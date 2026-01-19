# 📱 How to Install on an iPhone

Deploying to a real iPhone requires **Code Signing**, which is Apple's way of ensuring that only authorized apps run on their devices. This guide will walk you through the process.

## 🛠️ Prerequisites

*   A physical iPhone and a USB cable.
*   A Mac with Xcode installed.
*   An Apple ID (a free one works fine).

## 📝 Step-by-Step Instructions

### 1. Connect and Trust

1.  Connect the iPhone to your Mac via USB.
2.  Unlock the iPhone and tap **"Trust this Computer"** when the popup appears.
3.  Enter the iPhone's passcode.

### 2. Open the iOS Project

Run the following command in your terminal from the project root:

```bash
open ios/Runner.xcworkspace
```

### 3. Configure Signing in Xcode

1.  In the left sidebar (Project Navigator), click the blue **Runner** icon at the very top.
2.  In the main window, select the **Runner** target under the "TARGETS" list.
3.  Click the **Signing & Capabilities** tab.
4.  If no account is listed, click **Add Account...** and sign in with your Apple ID.
5.  Under the **Team** dropdown, select your name (e.g., `Riccardo (Personal Team)`).
6.  Xcode will automatically generate a development certificate and provisioning profile.

### 4. Set a Unique Bundle Identifier

1.  In the same **Signing & Capabilities** tab, look for **Bundle Identifier**.
2.  Change it from the default to something unique (e.g., `com.ricc.kids-jigsaw-puzzle.v1`).
    *   *Note: Bundle IDs must be globally unique.*

### 5. Running the App

1.  At the top of the Xcode window, look for the device selector (to the right of the Play button).
2.  Select your connected **iPhone**.
3.  Click the **Play (Run)** button or press `Cmd + R`.

### 6. Trust the Developer on the Phone

The first time you run the app, the iPhone will show an "Untrusted Developer" error.

1.  On the iPhone, go to **Settings > General**.
2.  Scroll down to **VPN & Device Management** (or **Profiles & Device Management**).
3.  Tap on your Apple ID under "Developer App".
4.  Tap **"Trust [Your Apple ID]"** and confirm.
5.  Launch the app from the home screen!

---

## 🚀 Future Runs

Once the initial signing is set up, you can run the app directly from your terminal using:

```bash
just run-ios
```

Happy puzzling! 🧩
