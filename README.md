# MDS K3 Discriminants

This repository contains a Magma program for exploring discriminants of K3 surfaces and checking properties related to maximally degenerate surfaces (MDS).

## Structure

- `src/mds_utils.magma`: Contains utility functions to determine MDS properties and compute specific representations for discriminants.
- `src/main.magma`: Main script that uses the utility functions to search for examples and compute MDS discriminants.

## Features

1. **MDS Verification**:
   - The function `IsMds(v)` checks if a given quadratic form is MDS by comparing it to a canonical form.

2. **Representation Computation**:
   - The function `Rep(d)` generates specific representations for a discriminant `d`.

3. **Search for Non-MDS and MDS K3 Surfaces**:
   - The main script searches for pairs of K3 surfaces with the same discriminant where one is MDS and the other is not.

4. **Computation of MDS Discriminants**:
   - The script identifies discriminants of quartic surfaces that correspond to MDS forms.

---

## Main Scripts and Explanation

### 1. Searching for K3 Surfaces with the Same Discriminant

This loop identifies examples of K3 surfaces with the same discriminant, where one is MDS, and the other is not. The `IsMds` function is used to check the MDS property of each surface.

```magma
// Search for examples of K3 surfaces with the same discriminant,
// one MDS and the other not MDS
for a in [1..5] do
    lis := [];
    for b in [0..a] do
        lis := lis cat [<[a, b, c], b^2 - 4 * a * c> : c in [-10..Floor(b^2 / (4 * a))]];
    end for;
    ll := [[u, v] : u, v in lis | u ne v and u[2] eq v[2] and IsMds(u[1]) ne IsMds(v[1])];
    if #ll gt 0 then
        ll;
    end if;
end for;
