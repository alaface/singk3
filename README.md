# MDS K3 Discriminants

This repository contains a Magma program for exploring discriminants of K3 surfaces and checking properties related to maximally degenerate surfaces (MDS).

## Structure

- `Discriminants smooth Pic2.txt`: Contains utility functions to determine MDS properties and compute specific representations for discriminants.

## Features

1. **MDS Verification**:
   - The function `IsMds(v)` checks if a given quadratic form is MDS by comparing it to a canonical form.

2. **Representation Computation**:
   - The function `Rep(d)` generates specific representations for a discriminant `d`.

---

## Main Scripts and Explanation

### Searching for K3 Surfaces with the Same Discriminant

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

### Compute MDS discriminants for quartic surfaces

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
