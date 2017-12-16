#ifdef GCC
#line 2 "calcmain"
#endif

#include "main.h"
//#include "lex.h"

int main (int len_args, const char* const* const args) {

  stack_t* s = stack_new();

  char* a = stack_see(s);
  dealloc_printf(a);

  stack_push(s, number_new(6));
  stack_push(s, number_new(73));

  a = stack_see(s);
  dealloc_printf(a);

  stack_destruct(s);

  //return 0;

  if (1 == len_args) {
    interpret();

  } else {
    (void) args;
    return EXIT_FAILURE;
  }

  return EXIT_SUCCESS;
}
