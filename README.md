# onnxruntime-arm

This repository is a build pipeline for producing a Python wheel for [onnxruntime](https://github.com/microsoft/onnxruntime/) for ARM32 / 32-bit ARM / armhf / ARM.

Whilst this is intended for use with [pi-top's Python SDK](https://github.com/pi-top/pi-top-Python-SDK/), it should be suitable for anyone looking to use onnxruntime with Python on a Raspberry Pi.

### TODO

Soon
* Push wheel to PyPI as an unofficial port to make it available immediately
* Create a Debian package from the wheel (wheel2deb?)

Later
* Try to resolve upstream issues - can onnxruntime provide source to PyPI so that piwheels can manage the arm32 build?
