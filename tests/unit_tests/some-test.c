#include "libkm/io/printf.h"
#include "{PROJECT_NAME}/{PROJECT_NAME}.h"

#include <criterion/criterion.h>

#define TEST_SIZE 1024

char* someVariable;

void suitesetup(void)
{
	someVariable = malloc(sizeof(char) * TEST_SIZE);
	cr_assert(someVariable != NULL);
}

void suiteteardown(void) {
	free(someVariable);
	someVariable = NULL;
}

TestSuite(TestGroup, .init=suitesetup, .fini=suiteteardown);

Test(TestGroup, some_test)
{
	cr_expect(some_function(!!someVariable) == true);
}

Test(TestGroup, some_other_test)
{
	cr_assert_neq(someVariable, NULL);
}
