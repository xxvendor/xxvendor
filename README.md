use:

```
  xx_vendor:
    git:
      url: https://github.com/xxvendor/xxvendor.git
```
*********
XXImagePicker需要如下配置：
for ios

```
<key>NSCameraUsageDescription</key>
<string>Example usage description</string>
<key>NSMicrophoneUsageDescription</key>
<string>Example usage description</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>Example usage description</string>
```

for android

```
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.RECORD_AUDIO" />
```
********