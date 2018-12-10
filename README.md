# RFPortals

Proof of concept application for remote Access Control using:

* NFCCore
* CoreBluetooth


## Info.plist

* Added `NSUserActivityTypes` with value `com.goliatone.RFPortals.scanPortals`
* Added `Privacy - NFC Scan Usage Description`
* Added `Privacy - Camera Usage Description`

### TODO

Knock background to open if BLE present, see [here](https://stackoverflow.com/questions/30619778/swift-coremotion-detect-tap-or-knock-on-device-while-in-background) 


<!--
Refactor QR:
https://medium.com/programming-with-swift/how-to-read-a-barcode-or-qrcode-with-swift-programming-with-swift-10d4315141d2
-->
