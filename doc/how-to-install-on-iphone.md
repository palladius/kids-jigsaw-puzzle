# 📱 How to Install on an iPhone

Deploying to a real iPhone requires **Code Signing** and **Developer Mode**. This guide will walk you through the process and troubleshooting.

## 🛠️ Prerequisites

* A physical iPhone and a USB cable.
* A Mac with Xcode installed.
* An Apple ID (a free one works fine).
* **Developer Mode** must be enabled on the iPhone (Settings > Privacy & Security > Developer Mode).

## 📝 Step-by-Step Instructions

### 1. Connect and Trust

1. Connect the iPhone to your Mac via USB.
2. Unlock the iPhone and tap **"Trust this Computer"** when the popup appears.
3. Enter the iPhone's passcode.
4. **Enable Developer Mode**: Go to **Settings > Privacy & Security > Developer Mode** and switch it **ON**.
   * *Note: The phone will restart. After rebooting, confirm again by tapping "Turn On".*

### 2. Open the iOS Project

Run the following command from the project root:

```bash
open ios/Runner.xcworkspace
```

### 3. Configure Signing and Pairing in Xcode

1. In the left sidebar, click the blue **Runner** icon at the very top.
2. Select the **Runner** target, then go to the **Signing & Capabilities** tab.
3. Select your **Team** (e.g., `Riccardo (Personal Team)`).
4. **Pair the device**: In Xcode, go to **Window > Devices and Simulators** (`Cmd + Shift + 2`). Select your iPhone and wait for it to show as "Available".

### 4. Set a Unique Bundle Identifier

1. In **Signing & Capabilities**, change the **Bundle Identifier** to something unique (e.g., `com.ricc.kids-jigsaw-puzzle.v1`).

### 5. Running the App

1. Select your iPhone in the device selector at the top cente of Xcode.
2. Click the **Play (Run)** button or press `Cmd + R`.

---

## ⚠️ Troubleshooting

### The "Endless Spinner" / Pairing Hangs
If Xcode hangs while "Pairing" or shows the phone as "Unpaired" despite being connected:
1. **Unplug and Replug**: Simply detaching and re-attaching the USB cable often triggers the final handshake.
2. **Toggle Wi-Fi**: Temporarily turn off Wi-Fi on the iPhone to force Xcode to communicate exclusively over USB.
3. **Check the Top Bar**: If you see "iOS XX.X is not installed," click the **[Get]** button to download the required system components.

### "Untrusted Developer"
If the app installs but won't open:
1. Go to **Settings > General > VPN & Device Management**.
2. Tap your Apple ID and click **Trust**.

---

## 🚀 Future Runs

Once paired and signed:
```bash
just run-ios
```
