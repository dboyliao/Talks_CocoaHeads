# Fourier Transform in Action

## Intro

- In this talk, I'll use command line tools **only** to compile and run swift code. Because....
    + XCode APP crashes often.
    + XCode APP slow me down in prototyping.
    + XCode APP sucks!

![fuck_xcode](img/fuck_xcode.jpg)

- The tools I will use today is simple. Most of them should be familiar to you:
    + `Makefile` and `make`
    + `xcrun` (XCode in command line)
    + `swift`(REPL) and `swiftc`(compiler)

## Demo

- I use `Blender` and `python` to implement a simple, basic lips syncing algorithm
- It takes a `wav` audio file and output neccessary parameters for lips animation.
- The core of this algorithm is the `FFT`!

![blender_demo](img/blender_demo.png)

## Routine
1. Create Setup
    - According to the [document](https://developer.apple.com/library/ios/documentation/Performance/Conceptual/vDSP_Programming_Guide/USingDFTFunctions/USingDFTFunctions.html#//apple_ref/doc/uid/TP40005147-CH4-SW1), you need to take care of **length** of the input signal.
    - This step is expensive in terms of execution time.
2. Create Output Buffers.
3. Execute FFT.

## Snippets

```{swift}
```

## Take Home Message

