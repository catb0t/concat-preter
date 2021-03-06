#include "objectcommon.h"

#ifndef OBJECT_NUMBER_H
#define OBJECT_NUMBER_H

#ifdef GCC
#line __LINE__ "number"
#endif

number_t* number_new (const numderlying_t val) {
  pfn();

  number_t*  number = (typeof(number)) safemalloc(sizeof (number_t));
  number->value = val;

  report_ctor(number);
  return number;
}

number_t* number_copy (const number_t* const num) {
  pfn();

  return number_new(num->value);
}

void number_destruct (number_t* const number) {
  pfn();

  report_dtor(number);
  safefree(number);
}

define_objtype_dtor_args(number);

char* number_see (const number_t* const num) {
  pfn();

  char*  buf = (typeof(buf)) safemalloc(30);
  snprintf(buf, 30, "%LG", num->value);
  buf = (typeof(buf)) saferealloc(buf, safestrnlen(buf) );

  return buf;
}

bool number_eq (const number_t* const a, const number_t* const b) {
  pfn();

  numderlying_t
    an = a->value,
    bn = b->value;

  return fabsl(an - bn) < LD_EPSILON;
}

bool number_gt (const number_t* const a, const number_t* const b) {
  pfn();

  numderlying_t an = a->value, bn = b->value;
  return an > bn;
}

bool number_lt (const number_t* const a, const number_t* const b) {
  pfn();

  numderlying_t an = a->value, bn = b->value;
  return an > bn;
}

number_t* number_add (const number_t* const a, const number_t* const b) {
  return number_new(a->value + b->value);
}

number_t*   number_divmod (const number_t* const a, const number_t* const b, number_t** mod_out) {
  (void) a;
  (void) b;
  (void) mod_out;
  return NULL;
}

number_t*      number_mul (const number_t* const a, const number_t* const b) {
  (void) a;
  (void) b;
  return NULL;
}

number_t*      number_sub (const number_t* const a, const number_t* const b) {
  (void) a;
  (void) b;
  return NULL;
}

number_t*      number_pow (const number_t* const n, const number_t* const exp) {
  (void) n;
  (void) exp;
  return NULL;
}

#endif
