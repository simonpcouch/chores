# Initialize a Helper object

**Users typically should not need to call this function.**

- Create new helpers that will automatically be registered with this
  function with
  [`prompt_new()`](https://simonpcouch.github.io/chores/reference/prompt.md).

- The [chores
  addin](https://simonpcouch.github.io/chores/reference/dot-init_addin.md)
  will initialize needed helpers on-the-fly.

## Usage

``` r
.init_helper(chore = NULL, .chores_chat = getOption(".chores_chat"))
```

## Arguments

- chore:

  The identifier for a helper prompt. By default one of
  ["cli"](https://simonpcouch.github.io/chores/reference/cli_helper.md),
  ["testthat"](https://simonpcouch.github.io/chores/reference/testthat_helper.md)
  or
  ["roxygen"](https://simonpcouch.github.io/chores/reference/roxygen_helper.md),
  though custom helpers can be added with
  [`prompt_new()`](https://simonpcouch.github.io/chores/reference/prompt.md).

- .chores_chat:

  An ellmer Chat, e.g. `function() ellmer::chat_claude()`. Defaults to
  the option by the same name, so e.g. set
  `options(.chores_chat = ellmer::chat_claude())` in your `.Rprofile` to
  configure chores with ellmer every time you start a new R session.

## Value

A Helper object, which is a subclass of an ellmer chat.

## Examples

``` r
# requires an API key and sets options
if (FALSE) { # \dontrun{
# to create a chat with claude:
.init_helper(.chores_chat = ellmer::chat_claude())

# or with OpenAI's GPT-4.1-mini:
.init_helper(.chores_chat = ellmer::chat_openai(model = "gpt-4.1-mini"))

# to set OpenAI's GPT-4.1-mini as the default model powering chores, for example,
# set the following option (possibly in your .Rprofile, if you'd like
# them to persist across sessions):
options(
  .chores_chat = ellmer::chat_openai(model = "gpt-4.1-mini")
)
} # }
```
