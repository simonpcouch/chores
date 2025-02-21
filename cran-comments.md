**Notes for CRAN maintainers**

There's 1 R CMD check NOTE, as this is a new release.

> If there are references describing the methods in your package...

Unfortunately, there are not formal references for the methods implemented in this package. Relevant software is mentioned in single quotes in the Description.

> Please add \value to .Rd files regarding exported methods and explain the functions results in the documentation.

Added docs on return value for this missing functions, thanks!

> Please ensure that your functions do not write by default or in your examples/vignettes/tests in the user's home filespace... In your examples/vignettes/tests you can write to tempdir().

Thanks, examples/tests/vignettes now use a tempdir.

Thank you all for your work.
