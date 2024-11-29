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

## Usage

1. Clone the repository:
   ```bash
   git clone https://github.com/username/mds_k3_discriminants.git
   cd mds_k3_discriminants/src
