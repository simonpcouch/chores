# The prompt directory

The chores package's prompt directory is a directory of markdown files
that is automatically registered with the chores package on package
load. `directory_*()` functions allow users to interface with the
directory, making new "chores" available:

- `directory_path()` returns the path to the prompt directory.

- `directory_set()` changes the path to the prompt directory (by setting
  the option `chores.dir`).

- `directory_list()` enumerates all of the different prompts that
  currently live in the directory (and provides clickable links to
  each).

[Functions prefixed
with](https://simonpcouch.github.io/chores/reference/prompt.md)
`prompt*()` allow users to conveniently create, edit, and delete the
prompts in chores' prompt directory.

## Usage

``` r
directory_load(dir = directory_path())

directory_list()

directory_path()

directory_set(dir)
```

## Arguments

- dir:

  Path to a directory of markdown files–see `Details` for more.

## Value

- `directory_path()` returns the path to the prompt directory (which is
  not created by default unless explicitly requested by the user).

- `directory_set()` return the path to the new prompt directory.

- `directory_list()` returns the file paths of all of the prompts that
  currently live in the directory (and provides clickable links to
  each).

- `directory_load()` returns `NULL` invisibly.

## Format of the prompt directory

Prompts are markdown files with the name `chore-interface.md`, where
interface is one of "replace", "prefix" or "suffix". An example
directory might look like:

    /
    |-- .config/
    |   |-- chores/
    |       |-- proofread-replace.md
    |       |-- summarize-prefix.md

In that case, chores will register two custom helpers when you call
[`library(chores)`](https://github.com/simonpcouch/chores). One of them
is for the "proofread" chore and will replace the selected text with a
proofread version (according to the instructions contained in the
markdown file itself). The other is for the "summarize" chore and will
prefix the selected text with a summarized version (again, according to
the markdown file's instructions). Note:

- Files without a `.md` extension are ignored.

- Files with a `.md` extension must contain only one hyphen in their
  filename, and the text following the hyphen must be one of `replace`,
  `prefix`, or `suffix`.

To load custom prompts every time the package is loaded, place your
prompts in `directory_path()`. To change the prompt directory without
loading the package, just set the `chores.dir` option with
`options(chores.dir = some_dir)`. To load a directory of files that's
not the prompt directory, provide a `dir` argument to
`directory_load()`.

## See also

The "Custom helpers" vignette, at
[`vignette("custom", package = "chores")`](https://simonpcouch.github.io/chores/articles/custom.md),for
more on adding your own helper prompts, sharing them with others, and
using prompts from others.

## Examples

``` r
# choose a path for the prompt directory
tmp_dir <- withr::local_tempdir()
directory_set(tmp_dir)
#> Error in directory_set(tmp_dir): `dir` doesn't exist.
#> ℹ If desired, create it with `dir.create("/tmp/RtmpKVzW6G/file19f9ef9b6c9",
#>   recursive = TRUE)`.

# print out the current prompt directory
directory_path()
#> [1] "~/.config/chores"

# list out prompts currently in the directory
directory_list()

# create a prompt in the prompt directory
prompt_new("boop", "replace")

# view updated list of prompts
directory_list()
```
