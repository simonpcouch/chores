# Working with helper prompts

The chores package provides a number of tools for working on system
*prompts*. System prompts are what instruct helpers on how to behave and
provide information to live in the models' "short-term memory."

`prompt_*()` functions allow users to conveniently create, edit, remove,
the prompts in chores' "[prompt
directory](https://simonpcouch.github.io/chores/reference/directory.md)."

- `prompt_new()` creates a new markdown file that will automatically
  create a helper with the specified chore, prompt, and interface on
  package load. Specify a `contents` argument to prefill with contents
  from a markdown file on your computer or the web.

- `prompt_edit()` and `prompt_remove()` open and delete, respectively,
  the file that defines the given chore's system prompt.

The prompts you create with these functions will be automatically loaded
when you next trigger the helper addin.

## Usage

``` r
prompt_new(chore, interface, contents = NULL)

prompt_remove(chore)

prompt_edit(chore)
```

## Arguments

- chore:

  A single string giving a descriptor of the helper's functionality.
  Cand only contain letters and numbers.

- interface:

  One of `"replace"`, `"prefix"`, or `"suffix"`, describing how the
  helper will interact with the selection. For example, the [cli
  helper](https://simonpcouch.github.io/chores/reference/cli_helper.md)
  `"replace"`s the selection, while the [roxygen
  helper](https://simonpcouch.github.io/chores/reference/roxygen_helper.md)
  `"prefixes"` the selected code with documentation.

- contents:

  Optional. Path to a markdown file with contents that will "pre-fill"
  the file. Anything file ending in `.md` or `.markdown` that can be
  read with [`readLines()`](https://rdrr.io/r/base/readLines.html) is
  fair game; this could be a local file, a "raw" URL to a GitHub Gist or
  file in a GitHub repository, etc.

## Value

Each `prompt_*()` function returns the file path to the created, edited,
or removed filepath, invisibly.

## See also

The
[directory](https://simonpcouch.github.io/chores/reference/directory.md)
help-page for more on working with prompts in batch using
`directory_*()` functions, and
[`vignette("custom", package = "chores")`](https://simonpcouch.github.io/chores/articles/custom.md)
for more on sharing helper prompts and using prompts from others.

## Examples

``` r
if (interactive()) {
# create a new helper for chore `"boop"` that replaces the selected text:
prompt_new("boop")

# after closing the file, reopen with:
prompt_edit("boop")

# remove the prompt (next time the package is loaded) with:
prompt_remove("boop")

# pull prompts from files on local drives or the web with
# `prompt_new(contents)`. for example, here is a GitHub Gist:
# paste0(
#  "https://gist.githubusercontent.com/simonpcouch/",
#  "daaa6c4155918d6f3efd6706d022e584/raw/ed1da68b3f38a25b58dd9fdc8b9c258d",
#  "58c9b4da/summarize-prefix.md"
# )
#
# press "Raw" and then supply that URL as `contents` (you don't actually
# have to use the paste0() to write out the URL--we're just keeping
# the characters per line under 80):
prompt_new(
  chore = "summarize",
  interface = "prefix",
  contents =
    paste0(
      "https://gist.githubusercontent.com/simonpcouch/",
      "daaa6c4155918d6f3efd6706d022e584/raw/ed1da68b3f38a25b58dd9fdc8b9c258d",
      "58c9b4da/summarize-prefix.md"
    )
)
}
```
