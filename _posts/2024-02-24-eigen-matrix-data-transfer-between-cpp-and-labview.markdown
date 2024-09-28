---
layout: post
title: Eigen matrix data transfer between C++ and LabView
date: 2024-02-24
categories: [computer]
tags: [Eigen,C++,LabView]
mathjax: false
---

When interfacing C++ and LabView, I need to process and manipulate the data array created in LabView with Eigen. There is no need to copy the whole array and wrapping the existing array into an Eigen object is enough and efficient. `Eigen::Map` should be used for this purpose.

On the other hand, before integrating C++ with LabView, I need to test algorithms implemented in C++ and Eigen&rsquo;s matrix type will be used instead of raw data array from LabView. Therefore, the C++ function should accept both scenarios. Hence, `Eigen::Ref` is used.

Convert a data pointer to an array to `Eigen::Map`

```C++
#include <Eigen/Core>
#include <Eigen/Dense>

using namespace Eigen;

// @p mat is a pointer to an array created in LabView, which is wrapped in an
// @p Eigen::Map object @p mat_out.
void
read_matrix_labview(const char        *filename,
                    double            *mat,
                    const unsigned int n_rows,
                    const unsigned int n_cols,
                    const char        *comment_symbol)
{
  Map<MatrixXd, Unaligned> mat_out(mat, n_rows, n_cols);
  TSC::read_matrix(std::string(filename),
                   mat_out,
                   n_rows,
                   n_cols,
                   std::string(comment_symbol));
}
```

In the following function declaration, `Ref<VectorXd>` can either accept a mutable `VectorXd` object or a `Map<VectorXd>` object. If the argument is read-only, we should use `const Ref<const VectorXd>&`.

```C++
void
tsc_electronic_trap(Ref<VectorXd>              trap_energies,
                    Ref<VectorXd>              trap_densities,
                    const Ref<const VectorXd> &temperatures,
                    const Ref<const VectorXd> &currents,
                    const double               temperature_ramp_rate,
                    const double               electrode_diameter,
                    const double               sample_thickness,
                    const double               attemp_to_jump_frequency,
                    const double               carrier_penetration_depth,
                    const double               valence_band_depth,
                    const unsigned int         energy_level_num,
                    const bool                 is_near_measurement_electrode);
```

The reason for the difference between mutable and const is described as follows.

-   The basic situation: usually we don&rsquo;t already have a `Ref<VectorXd>` object to be passed to the function, but only pass a `VectorXd` or `Map<VectorXd>` to the above function. Then a temporary `Ref<VectorXd>` object will be created. Because it is an rvalue, it is const.
-   If the function argument type is `Ref<VectorXd>&`, it requires a mutable reference to the const temporary object, which is invalid. Hence, only `Ref<VectorXd>` is allowed.
-   If the function argument type is `const Ref<const VectorXd>` or `const Ref<const VectorXd>&`, both are grammatically correct. The former is pass-by-value with respect to the object `Ref<const VectorXd>`, while the latter is pass-by-reference. Here the `Ref` object is created for `VectorXd`, the memory of which has already been dynamically allocated. Therefore, `Ref<VectorXd>` itself is a small object. For `Ref<Vector3d>`, the memory for `Vector3d` is fixed and statically created, the entirety of which is a member of `Ref<Vector3d>`. Therefore, `Ref<Vector3d>` is relatively a large object and pass-by-reference is preferred. So we should use `const Ref<const Vector3d>&`. For simplicity, for any type `T`, we only use `const Ref<const T>&`.

Reference: <https://stackoverflow.com/a/21138316>

{{ "2024-02-24-eigen-matrix-data-transfer-between-cpp-and-labview" | backlink }}
