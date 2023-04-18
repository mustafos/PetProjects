#include "fractions.hpp"
#include "frac_complex.hpp"

int main()
{
    FractionComplex a, b;
    a.re = Fraction(2, 3);
    a.im = Fraction(5, 7);
    b.re = Fraction(3, 2);
    b.im = Fraction(9, 5);

    FractionComplex c;
    c = fraction_complex_plus(a + b);

    fraction_complex_print(c);

    return 0;
}
