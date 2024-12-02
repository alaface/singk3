# MDS K3 Discriminants

This repository contains a Magma program for exploring discriminants of K3 surfaces and checking properties related to maximally degenerate surfaces (MDS).

## Structure

- `library.m`: Contains utility functions to determine MDS properties, compute specific representations for discriminants and compute intersection products on a surface after contracting a finite set of irreducible curves.

## Features

1. **MDS Verification**:
   - The function `IsMds(v)` checks if a given quadratic form is MDS by comparing it to a canonical form.

2. **Representation Computation**:
   - The function `Rep(d)` generates specific representations for a discriminant `d`.

---

## Main Scripts and Explanation

### Searching for K3 Surfaces with the Same Discriminant
This block of code searches for examples of K3 surfaces with the same discriminant, where one is MDS and the other is not. It does so by generating quadratic forms and checking their discriminants and MDS properties.

- The **outer loop** iterates over coefficients $a$ in the range [1..5], initializing a list of quadratic forms.
- The **inner loop** iterates over $b$ in the range [0..a], generating quadratic forms of the type $[a, b, c]$, where $c$ is chosen such that the discriminant $\Delta = b^2 - 4ac$ is meaningful.
- For each pair of quadratic forms $[u, v]$, it checks:
  1. If they have the same discriminant.
  2. If one is MDS and the other is not, using the function `IsMds`.

```magma
// Search for examples of K3 surfaces with the same discriminant,
// one MDS and the other not MDS
for a in [1..5] do
    lis := [];
    // The outer loop iterates over coefficients 'a' in the range [1..5].
    for b in [0..a] do
        // The inner loop generates quadratic forms with coefficients 'b' and computes possible values for 'c'.
        lis := lis cat [<[a, b, c], b^2 - 4 * a * c> : c in [-10..Floor(b^2 / (4 * a))]];
    end for;
    // Check pairs of quadratic forms with the same discriminant and differing MDS properties.
    ll := [[u, v] : u, v in lis | u ne v and u[2] eq v[2] and IsMds(u[1]) ne IsMds(v[1])];
    if #ll gt 0 then
        // If such pairs are found, output them.
        ll;
    end if;
end for;
```

### Computing MDS Discriminants for Quartic Surfaces

This section computes the discriminants of quartic surfaces corresponding to maximally degenerate surfaces (MDS). The discriminants are filtered and verified based on specific criteria.

- The **list `dis`** is constructed by filtering discriminants $d$ in the range [1..1000], retaining only those that:
  1. Are perfect squares (`IsSquare(d)`).
  2. Are valid discriminants (`IsDiscriminant(d)`).
- For each discriminant $d$, the loop checks possible coefficients $b$ in the range [0..3].
- It computes $c$ such that $b^2 - d$ is divisible by 8 and verifies if the quadratic form $[2, b, c]$ is MDS using the function `IsMds`.

```magma
dis := [d : d in [1..1000] | IsDiscriminant(d) or IsSquare(d)];
ll := [];
for d in dis do
    for b in [0..3] do
        // Compute 'c' such that (b^2 - d) is divisible by 8.
        c, r := Quotrem(b^2 - d, 8);
        if r eq 0 and IsMds([2, b, c]) then
            // If the quadratic form [2, b, c] is MDS, append 'd' to the list of results.
            Append(~ll, d);
        end if;
    end for;
end for;
```
## Computing the Intersection Matrix for a singular $K3$ Surface

Given a $K3$ surface with the following Picard lattice represented by the \(4 \times 4\) intersection matrix:

$$
\begin{pmatrix*}[r]
  4 & 2 & 0 & 0 \\
  2 & -2 & 1 & 1 \\
  0 & 1 & -2 & 0 \\
  0 & 1 & 0 & -2
\end{pmatrix*},
$$

we compute the reduced \(2 \times 2\) intersection matrix in the basis \(\{H, -H + 2E_1 + E_2 + E_3\}\) using the following Magma code:

```magma
// Define the 4x4 intersection matrix of the Picard lattice
M := [
    [4, 2, 0, 0],
    [2, -2, 1, 1],
    [0, 1, -2, 0],
    [0, 1, 0, -2]
];

// Define the vectors representing the basis of the Picard lattice
H := [1, 0, 0, 0];
E1 := [0, 1, 0, 0];
E2 := [0, 0, 1, 0];
E3 := [0, 0, 0, 1];

// Define the new basis vectors
B1 := H;
B2 := [-1, 2, 1, 1];  // -H + 2E1 + E2 + E3

// Compute the 2x2 intersection matrix in the new basis
N := [
    [qua(B1, B1, M, []), qua(B1, B2, M, [])],
    [qua(B2, B1, M, []), qua(B2, B2, M, [])]
];
N;
