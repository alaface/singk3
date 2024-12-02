// Check if a vector represents a quadratic form that is MDS
IsMds := function(v)
    d := v[2]^2 - 4 * v[1] * v[3];
    if IsSquare(d) then
        return true;
    end if;
    Q := QuadraticForms(d);
    f := Q!v;
    u := Quotrem(d - (d mod 2), 4);
    g := Q![-1, d mod 2, u];
    return IsEquivalent(f, g);
end function;

// Compute specific representations for a given discriminant
Rep := function(d)
    ll := [];
    for b in [0..3] do
        c, r := Quotrem(b^2 - d, 8);
        if r eq 0 then
            Append(~ll, [2, b, c]);
        end if;
    end for;
    return ll;
end function;

// qua
// INPUT: a vector A, a vector B, a matrix M, a list of vector lis
// OUTPUT: the intersection product A.M.Transpose(B) modulo 
// the subspace <E : E in lis>

qua := function(A,B,M,lis)
 K := Rationals();
 M := Matrix(K,M);
 n := Nrows(M);
 if #lis eq 0 then
  return (Matrix(K,1,n,Eltseq(A))*M*Matrix(K,n,1,Eltseq(B)))[1,1];
 end if;
 E := ToricLattice(n);
 N := Matrix(K,lis)*M*Transpose(Matrix(K,lis));
 u := Solution(N,Matrix(K,1,n,Eltseq(A))*M*Transpose(Matrix(K,lis)));
 A1 := E!Eltseq(A) - &+[E!lis[i]*Eltseq(u)[i] : i in [1..#lis]];
 u := Solution(N,Matrix(K,1,n,Eltseq(B))*M*Transpose(Matrix(K,lis)));
 B1 := E!Eltseq(B) - &+[E!lis[i]*Eltseq(u)[i] : i in [1..#lis]];
 return (Matrix(K,1,n,Eltseq(A1))*M*Matrix(K,n,1,Eltseq(B1)))[1,1];
end function;

