---
layout: post
title: Usage of the const keyword in C++
date: 2021-01-15
categories: [thoughts]
tags: [programming,C++]
mathjax: false
---

The use of `const` keyword in C++ applies constraints to the program which will be statically checked by the compiler before program’s running. Therefore, it provides an additional layer of safety mechanism during our programming activity, such as preventing us from involuntarily modifying the value of a constant variable or getting its non-constant (mutable) reference. This will be extremely useful for us to develop and debug large scale numerical libraries in a defensive way, where mathematics and programming techniques are interwoven, which makes us more prone to error than traditional software containing only work flow of logics rather than mathematics. Therefore, it is meaningful to clarify and understand the key points of `const` usage, which will be the topic of this article. 

## Differentiate between internal and external linkage of a `const` variable

We often come across a scenario that a `const` variable is declared and initialized at the same time in a header file, which will be included by many compilation modules, i.e. cpp files. Such variables are internally linked by the compiler, which are stored in the compiler’s symbol table and do not require memory allocation. This is called constant folding.

When a `const` variable is declared with an `extern` prefix in a header file but without initialization, the connotation of `extern` means the actual definition of this `const` variable is not in the same header file, but in some cpp file. Then, this variable is externally linked by the compiler, which is not stored in the symbol table of the compiler and requires actual memory allocation.

## Associativity of `const` keyword

`const T * p` or `T const * p` defines a pointer, which points to a `const` value of type `T`, while the memory address stored in `p` itself can be modified.

`T * const p` defines a pointer which points to a value of type `T`. The difference from above is that the address stored in the pointer cannot be changed and the value stored in the variable of type `T` can be modified.

`const T * const p` defines a pointer which points to a `const` value of type `T` and the address in `p` is also `const`.

Anyway, the basic principle is that the `const` keyword is bounded to its closest entity from the right and if `const` is the left-most keyword, it is bounded from the left.

## `const` return value of a function

We should keep in mind that the direct return value of a function which has not yet been assigned to an external `lvalue` is treated as `const`. This means the following expression is wrong, i.e. the direct return value of a function cannot be overridden.

```c++
int foo();

foo() = 3;
```

## Temporary objects

Temporary objects of a class are created by directly calling the constructor of the class. When it is used as an `lvalue`, it is mutable. When it is used as a `rvalue`, it is `const`. When a temporary object is passed to a function as argument, it is treated as a `rvalue` and hence has `const` type.

The operator `&` for extracting a variable’s memory address cannot be applied to a temporary object. Therefore, a temporary object can only be passed to a function by `const` reference but not by address or mutable reference.

```c++
class ClassName;

void foo_pass_by_pointer(const ClassName *);
void foo_pass_by_const_reference(const ClassName &);
void foo_pass_by_reference(ClassName &);

// Invalid
foo_pass_by_pointer(&ClassName());
// Valid
foo_pass_by_const_reference(ClassName());
// Invalid
foo_pass_by_reference(ClassName());
```

## Use the `const` keyword in a class

### `const` member functions

#### Dichotomy between `const` and mutable member functions

When the `const` keyword is explicitly appended to both the declaration and definition of a member function in a class, the compiler is told that member variables of the class should not be changed during the execution of this member function. This explicit declaration is mandatory because the compiler has no knowledge about the constness of member variables during the function execution.

`const` member functions are mandatory because they are the only interfaces for accessing constant objects. If they are not defined, the following compiler error will usually appear:

```
error: passing 'const ClassName' as 'this' argument of 'int& ClassName::member_function()'  discards qualifiers [-fpermissive]
```

This can be understood like this: every member function in a class has an inherent first argument which is the **this** pointer pointing to the instance of the current object, as shown below.

```c++
result_type member_function(ClassName * this_pointer, ...);
```

This is a mutable version of `member_function`.

When the `const` keyword is appended to it,

```c++
result_type member_function(...) const;
```

it is a `const` version of `member_function` which is equivalent to declaring a function as

```c++
result_type member_function(const ClassName * this_pointer, ...);
```

Therefore, if there is only a mutable version of `member_function` provided, when it is called from a `const` object of `ClassName`, there will be an implicit typecast from `ClassName *` to `const ClassName *`. This is forbidden by the compiler and the above “discards qualifiers” error message will appear. On the other hand, if there is only a `const` version of `member_function` provided, when it is called from a mutable object of `ClassName`, there is no error, because typecasting from `ClassName *` to `const ClassName *` is valid.

After understanding this, when we design and implement a new class, it is a good practice for us to apply the dichotomy between `const` and mutable to all class member functions.

#### Return value of a `const` member function

If the returned value of a `const` member function is a reference to some member variable in the class, because all member variables have been considered as `const` by the compiler inside the `const` member function, the returned reference should also be `const`.

#### Access class static variables from a `const` member function

A `const` member function only ensures that no changes will happen to class member variables. Therefore, class static variables, which do not belong to any instance of the class, can be modified within a `const` member function.

### `const` member variables

#### Non-static member variables

When a non-static member variable of a class is declared as `const`, it is not required to be initialized with a value at the same time as that required for a global `const` variable. The `const` keyword here only means that once this member variable is initialized, its value cannot be changed any further. Still, it is grammatically correct that such initial value is given at the declaration of a non-static member variable. However, in this way, each instance of this class will have the same value for this variable which cannot be modified. Then, there is actually no need to keep a same copy for it in each instance and we should define it as a `const` static member variable instead.

The appropriate place for initializing a `const` non-static member variable is the initializer list of the class’s constructor. This is because before the execution of the constructor’s function body, member variables of the class have already been initialized according to the initializer list. Therefore, it is the only chance to assign value to a `const` non-static member variable in the initializer list.

It should also be noted that constant folding is not applicable to a `const` non-static member variable. Meanwhile, because it cannot be guaranteed to be initialized with a value, it cannot be used to specify the size of an array.

#### Static member variables

A `const` static member variable in a class is shared by all the instances of the class. It is stored in the symbol list without memory allocation. Hence, constant folding is enabled for it and it can be used to specify the size of an array. There are two ways to initialize a `const` static member variable.

1. Initialized at the declaration, i.e. *in situ* initialization.

   ```c++
   class ClassName
   {
     static const int size = 100;
   };
   ```

2. Initialized outside the class, which is usually placed in the corresponding cpp file for the class.

   ```c++
   const int ClassName::size = 100;
   ```

One thing should be noted that because member variables of a class are initialized in the same order as their declaration, we have to make sure that the declaration and initialization of the static `const` member variable should be in front of the array whose size is defined via this variable.

## Good practices of using `const`

* Whenever a reference or a pointer is passed to a function, it should be declared as `const` in the function’s signature as much as possible. This is due to the following considerations.
  * Enable the function to be able to operate on a `const` object, because it is impossible to cast a type from `const` to mutable, unless `std::const_cast` is used.
  * Stick to the spirit of defensive programming and avoid any unnecessary or careless modification of the variable.
* Static `const` member variable had better be initialized *in situ*.
* Always keep in mind the dichotomy between `const` and mutable member functions when designing a class. For class member functions which never change member variables, they should be declared as `const`, so that they can be used for both mutable and `const` object.
