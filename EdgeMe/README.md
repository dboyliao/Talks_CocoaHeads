# Cpp + Obj-C+ + Swift: EdgeMe

In this talk, I'll show you how to accommodate Cpp, Obj-C(Obj-C++) and Swift by building a simple app, EdgeMe.

## Why You Have to Do This?

Good question. Why bother to use three different languagues in one project? It is getting even worse as Cpp getting involved!

As for me, my job is to develop algorithm using ML or image processing technics. These tasks rely heavily on matrix computation. However, I do not see good library provide me the funcionality for matrix computation I need. As a result, OpenCV seems to be a good option to me.

## How is It Done?

I think it is better explained with a simple demo. Let's build EdgeMe from scratch. 

In this demo, I will go through following steps, which typically is the same process for you guys who want to use Cpp or library written in Cpp in your projects.

1. (Optional) Setup the library.
    - You don't have to this if you are writting your own Cpp library.
2. Writting wrapper in Obj-C++.
3. Import wrappers in the bridging header.
4. Calling wrappers in the Swift code.

That's all.

Though as simple as it seem, I still have several bugs as I try to do it in the first time. I will point out what you should keep in mind in the following demo.

## Demo Time

## Summary

- If you can use `pod` to install the libraries you need, do it. Building from source is for the brave.
  - If it is not for the reason of version control, go for the **latest** version available on `pod`.
- Keep every single Cpp code behind tha wall of Obj-C++ or your Swift code will not compile.
  - Make good use of Obj-C++ extensions.
  - Do not `#import` or `#include` in the wrapper headers. It will break your bridging header.
