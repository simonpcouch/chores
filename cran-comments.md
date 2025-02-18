**Notes for CRAN maintainers**

There's 1 R CMD check NOTE, as this is a new release.

While there are not formal references for the methods implemented in this package, relevant software is mentioned in single quotes in the Description.

The core functionality in this package requires both an API key and interactivity with the RStudio API, so many of the examples in the package's documentation are wrapped in `\dontrun{}` with notes on prerequisites. I've ensured that test coverage is as complete as possible, though many of those tests focus on unexported internals to allow for mocking inputs.

Thank you all for your work.
