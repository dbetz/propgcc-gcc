// { dg-options "-std=c++0x" }

typedef decltype(sizeof(char)) size_type;

template<class T, size_type N>
constexpr size_type size(T (&)[N]) { return N; }

double array_double[] = { 1.0, 2.0, 3.0 };

constexpr auto sz_d = size(array_double);

static_assert(sz_d == 3, "Array size failure");

void f(bool (&param)[2]) {
  static_assert(size(param) == 2, "Array size failure"); // Line 13
  short data[] = {-1, 2, -45, 6, 88, 99, -345};
  static_assert(size(data) == 7, "Array size failure");
}
