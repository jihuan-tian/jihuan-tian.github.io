---
layout: post
title: Access control of C++ classes
date: 2020-11-10
categories: [computer]
tags: [programming,C++,OOP]
---

The C++ public, protected and private keywords enable us to control the access to the data and methods of a class. Such access control mechanism applies to both the definition of a class and its inherited base class. It also discriminates between class developers and clients. The former can visit both public and protected entities, while the latter are only accessible to public class members. Here, the class developer stands for the programmer who writes new classes by inheriting from the existing class hierarchy. The class client represents that who only uses classes in the library in his/her application programs.

For class designers, to make the library simple and effective, and to meet the applied demands of class developers and clients, they should always keep in mind the concepts of “simplification by hiding implementation details”. Therefore, when a class hierarchy is built from bottom to top, the underlying infrastructure should usually be designed not accessible by both class developers and clients. During the course of going up in the class hierarchy, the functions of classes evolve from laying out foundation to real world application, so their access rights can be gradually released out. Some member data and methods are labeled as protected, which are reserved for class developers to add more functionality to the library. Some member data and methods are labeled as public, which are open to class clients for ease-of-use.

{{ 2020-11-10-Access control of C++ classes | backlink }}
