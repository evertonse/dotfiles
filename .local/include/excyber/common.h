#pragma once
#include <stdint.h>
#include <stddef.h>
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
typedef size_t usize;
typedef ptrdiff_t isize;


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
		#if _MSC_VER < 1300
      #define force_inline
    #else
      #define force_inline  __forceinline
      #define force_noinline  __declspec(noinline)
    #endif
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
  // __linux__       Defined on Linux
  //   __sun           Defined on Solaris
  //   __FreeBSD__     Defined on FreeBSD
  //   __NetBSD__      Defined on NetBSD
  //   __OpenBSD__     Defined on OpenBSD
  //   __APPLE__       Defined on Mac OS X
  //   __hpux          Defined on HP-UX
  //   __osf__         Defined on Tru64 UNIX (formerly DEC OSF1)
  //   __sgi           Defined on Irix
  //   _AIX            Defined on AIX
  //   _WIN32          Defined on Windows

inline const char*
arch_build() { //Get current architecture, detectx nearly every architecture. Coded by Freak
  #if defined(__x86_64__) || defined(_M_X64)
  return "x86_64";
  #elif defined(i386) || defined(__i386__) || defined(__i386) || defined(_M_IX86)
  return "x86_32";
  #elif defined(__ARM_ARCH_2__)
  return "ARM2";
  #elif defined(__ARM_ARCH_3__) || defined(__ARM_ARCH_3M__)
  return "ARM3";
  #elif defined(__ARM_ARCH_4T__) || defined(__TARGET_ARM_4T)
  return "ARM4T";
  #elif defined(__ARM_ARCH_5_) || defined(__ARM_ARCH_5E_)
  return "ARM5"
  #elif defined(__ARM_ARCH_6T2_) || defined(__ARM_ARCH_6T2_)
  return "ARM6T2";
  #elif defined(__ARM_ARCH_6__) || defined(__ARM_ARCH_6J__) || defined(__ARM_ARCH_6K__) || defined(__ARM_ARCH_6Z__) || defined(__ARM_ARCH_6ZK__)
  return "ARM6";
  #elif defined(__ARM_ARCH_7__) || defined(__ARM_ARCH_7A__) || defined(__ARM_ARCH_7R__) || defined(__ARM_ARCH_7M__) || defined(__ARM_ARCH_7S__)
  return "ARM7";
  #elif defined(__ARM_ARCH_7A__) || defined(__ARM_ARCH_7R__) || defined(__ARM_ARCH_7M__) || defined(__ARM_ARCH_7S__)
  return "ARM7A";
  #elif defined(__ARM_ARCH_7R__) || defined(__ARM_ARCH_7M__) || defined(__ARM_ARCH_7S__)
  return "ARM7R";
  #elif defined(__ARM_ARCH_7M__)
  return "ARM7M";
  #elif defined(__ARM_ARCH_7S__)
  return "ARM7S";
  #elif defined(__aarch64__) || defined(_M_ARM64)
  return "ARM64";
  #elif defined(mips) || defined(__mips__) || defined(__mips)
  return "MIPS";
  #elif defined(__sh__)
  return "SUPERH";
  #elif defined(__powerpc) || defined(__powerpc__) || defined(__powerpc64__) || defined(__POWERPC__) || defined(__ppc__) || defined(__PPC__) || defined(_ARCH_PPC)
  return "POWERPC";
  #elif defined(__PPC64__) || defined(__ppc64__) || defined(_ARCH_PPC64)
  return "POWERPC64";
  #elif defined(__sparc__) || defined(__sparc)
  return "SPARC";
  #elif defined(__m68k__)
  return "M68K";
  #else
  return "UNKNOWN";
  #endif
}

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

#if defined(__i386__) || UINTPTR_MAX == 0xffFFffFF
	#define USIZE_MIX U32_MIN
	#define USIZE_MAX U32_MAX

	#define ISIZE_MIX I32_MIN
	#define ISIZE_MAX I32_MAX
#elif defined(__amd64__) || defined(__X86_64__) || UINTPTR_MAX == 0xffFFffFFffFFffFF
	#define USIZE_MIX U64_MIN
	#define USIZE_MAX U64_MAX

	#define ISIZE_MIX I64_MIN
	#define ISIZE_MAX I64_MAX
#else
	#warning Unknown platform - does not look either like 32-bit or 64-bit
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
