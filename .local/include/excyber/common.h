#pragma once
#include <stdint.h>
#include <stdio.h>  
#include <assert.h>  

#include <math.h>

// I saw this typing in rust and casey's stream, i really like it
typedef float	 f32;
typedef double   f64;

typedef __uint128_t u128;
typedef uint64_t u64;
typedef uint32_t u32;
typedef uint16_t u16;
typedef uint8_t  u8;
typedef uint8_t  byte;


typedef int64_t  i64;
typedef int32_t  i32;
typedef int16_t  i16;
typedef int8_t   i8;


#define HEADER 	"\033[95m"
#define OKBLUE 	"\033[94m"
#define OKCYAN 	"\033[96m"
#define OKGREEN	"\033[92m"
#define WARNING	"\033[93m"
#define FAIL 		"\033[91m"
#define ENDC 		"\033[0m"
#define PRINTBOLD 		"\033[1m"
#define UNDERLINE "\033[4m"

#define RED(msg) 	FAIL 	msg ENDC
#define GREEN(msg)	OKGREEN msg ENDC


#define RGBA_U32_RED(color)   (((color)&0x000000FF)>>(8*0))
#define RGBA_U32_GREEN(color) (((color)&0x0000FF00)>>(8*1))
#define RGBA_U32_BLUE(color)  (((color)&0x00FF0000)>>(8*2))
#define RGBA_U32_ALPHA(color) (((color)&0xFF000000)>>(8*3))
#define RGBA_U32_PACK(r, g, b, a) ((((r)&0xFF)<<(8*0)) | (((g)&0xFF)<<(8*1)) | (((b)&0xFF)<<(8*2)) | (((a)&0xFF)<<(8*3)))

// To be used when inside function and the data "persists" trough multiple calls (makes it ease to find later)
#define local_persistent static
#define filescope static
#define notimplemented(msg) assert(0 && msg "Not Implemented.")  
#define todo(msg) assert(0 && msg "To Do ! ")  

// Lower case macro are supposed to function like keyword, UPPERCASE macros are constans or simply macros taking function 

// Force inline and no-inline macros
//------------------------------------------------------------------------------------------------//

#if defined(__GNUC__) || defined(__GNUG__)
    #define force_inline inline __attribute__((always_inline))
    #define force_noinline  __attribute__((noinline))
#elif defined(_MSC_VER)
    #define force_inline  __forceinline
    #define force_noinline  __declspec(noinline)
#endif

#if defined(__GNUC__) || defined(__GNUG__)
#define force_restrict __restrict__
#elif defined(_MSC_VER)
#define force_restrict  __restrict
#endif

//------------------------------------------------------------------------------------------------//
#ifdef __cplusplus

#include <string>  
#include <iostream>  
#include <sstream>  
#include <cmath>

  // https://www.reddit.com/r/ProgrammerTIL/comments/58c6dx/til_how_to_defer_in_c/
  template <typename F>
  struct saucy_defer {
    F f;
    saucy_defer(F f) : f(f) {}
    ~saucy_defer() { f(); }
  };

  template <typename F>
  saucy_defer<F> defer_func(F f) {
    return saucy_defer<F>(f);
  }

  #ifndef defer
  #define DEFER_1(x, y) x##y
  #define DEFER_2(x, y) DEFER_1(x, y)
  #define DEFER_3(x)    DEFER_2(x, __COUNTER__)
  #define defer(code)   auto DEFER_3(_defer_) = efer_func([&](){code;})
  #endif

#endif

#ifndef as
#define as(Type) (Type)
#endif

// Why would a signed sizeof be more useful?
#ifndef size_of
#define size_of(x) (isize)(sizeof(x))
#endif

#ifndef count_of
#define count_of(x) ((size_of(x)/size_of(0[x])) / ((isize)(!(size_of(x) % size_of(0[x])))))
#endif

#ifndef offset_of
#define offset_of(Type, element) ((isize)&(((Type *)0)->element))
#endif

#if !defined(force_inline)
	#if defined(_MSC_VER)
		#if _MSC_VER < 1300
		#define force_inline
		#else
		#define force_inline __forceinline
		#endif
	#else
		#define force_inline __attribute__ ((__always_inline__))
	#endif
#endif

#if !defined(no_inline)
	#if defined(_MSC_VER)
		#define no_inline __declspec(noinline)
	#else
		#define no_inline __attribute__ ((noinline))
	#endif
#endif


#if !defined(thread_local)
	#if defined(_MSC_VER) && _MSC_VER >= 1300
		#define thread_local __declspec(thread)
	#else
		#define thread_local thread_local
	#endif
#endif

#ifndef null 
	#if defined(__cplusplus)
		#if __cplusplus >= 201103L
			#define null nullptr
		#else
			#define null 0
		#endif
	#else
		#define null  ((void *)0)
	#endif
#endif

#ifndef U8_MIN
#define U8_MIN 0u
#define U8_MAX 0xffu
#define I8_MIN (-0x7f - 1)
#define I8_MAX 0x7f

#define U16_MIN 0u
#define U16_MAX 0xffffu
#define I16_MIN (-0x7fff - 1)
#define I16_MAX 0x7fff

#define U32_MIN 0u
#define U32_MAX 0xffffffffu
#define I32_MIN (-0x7fffffff - 1)
#define I32_MAX 0x7fffffff

#define U64_MIN 0ull
#define U64_MAX 0xffffffffffffffffull
#define I64_MIN (-0x7fffffffffffffffll - 1)
#define I64_MAX 0x7fffffffffffffffll
#if defined(ARCH_32_BIT)
	#define USIZE_MIX U32_MIN
	#define USIZE_MAX U32_MAX

	#define ISIZE_MIX I32_MIN
	#define ISIZE_MAX I32_MAX
#elif defined(ARCH_64_BIT)
	#define USIZE_MIX U64_MIN
	#define USIZE_MAX U64_MAX

	#define ISIZE_MIX I64_MIN
	#define ISIZE_MAX I64_MAX
#else
	#warning Unknown architecture size. This library only supports 32 bit and 64 bit architectures.
#endif

#if !defined(M_PI)
  #define M_PI   3.14159265358979323846 
#endif

#define F32_MIN 1.17549435e-38f
#define F32_MAX 3.40282347e+38f

#define F64_MIN 2.2250738585072014e-308
#define F64_MAX 1.7976931348623157e+308

#endif

#ifndef unused
	#if defined(_MSC_VER)
		#define unused(x) (__pragma(warning(suppress:4100))(x))
	#elif defined (__GCC__)
		#define unused(x) __attribute__((__unused__))(x)
	#else
		#define unused(x) ((void)(size_of(x)))
	#endif
#endif

#ifndef kilobytes
#define kilobytes(x) ((x) * (i64)(1024))
#define megabytes(x) (kilobytes(x) * (i64)(1024))
#define gigabytes(x) (megabytes(x) * (i64)(1024))
#define terabytes(x) (gigabytes(x) * (i64)(1024))
#endif
