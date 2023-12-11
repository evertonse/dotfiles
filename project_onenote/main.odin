package main

import "core:os"
import "core:fmt"

void :: byte;

main :: proc() {
  
  lol :: proc() -> (s: int) {
    fmt.println("Another print");
    s = 2;
    return;
  }
  arr : rawptr = cast(rawptr) cast(uintptr) 0xcafebabe; 
  for i in 1..=10 {
    arr :=  cast(^byte)arr;
    fmt.println(^arr[i] , i);
        
  }
  fmt.println(arr);

	program := "+ + * 😃 - /"
	accumulator := 0

	for token in program {
		switch token {
		case '+': accumulator += 1
		case '-': accumulator -= 1
		case '*': accumulator *= 2
		case '/': accumulator /= 2
		case '😃': accumulator *= accumulator
		case: // Ignore everything else
		}
	}

  fmt.println(lol());
  os.exit(69);
	//
	// fmt.printf("The program \"%s\" calculates the value %d\n",
	//            program, accumulator)
 //  arr : [123][123]f32 = 1; 
 //  arr *= 3;
 //  for i in arr {
 //      for j in i {
 //    }
	//   fmt.printf("%d\n", i);
 //  }

}


