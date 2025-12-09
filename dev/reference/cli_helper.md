# The cli helper

A couple years ago, the tidyverse team began migrating to the cli R
package for raising errors, transitioning away from base R (e.g.
[`stop()`](https://rdrr.io/r/base/stop.html)), rlang (e.g.
[`rlang::abort()`](https://rlang.r-lib.org/reference/abort.html)), glue,
and homegrown combinations of them. cli's new syntax is easier to work
with as a developer and more visually pleasing as a user.

In some cases, transitioning is as simple as Finding + Replacing
[`rlang::abort()`](https://rlang.r-lib.org/reference/abort.html) to
[`cli::cli_abort()`](https://cli.r-lib.org/reference/cli_abort.html). In
others, there's a mess of ad-hoc pluralization,
[`paste0()`](https://rdrr.io/r/base/paste.html)s, glue interpolations,
and other assorted nonsense to sort through. Total pain, especially with
thousands upon thousands of error messages thrown across the tidyverse,
r-lib, and tidymodels organizations.

The cli helper helps you convert your R package to use cli for error
messages.

## Cost

The system prompt for a cli helper includes something like 2,400 tokens.
Add in (a generous) 100 tokens for the code that's actually highlighted
and also sent off to the model and you're looking at 2,500 input tokens.
The model returns approximately the same number of output tokens as it
receives, so we'll call that 100 output tokens per refactor.

As of the time of writing (October 2024), the recommended chores model
Claude Sonnet 3.5 costs \$3 per million input tokens and \$15 per
million output tokens. So, using the recommended model, **cli helpers
cost around \$9 for every 1,000 refactored pieces of code**. GPT-4o
Mini, by contrast, doesn't tend to get cli markup classes right but
*does* return syntactically valid calls to cli functions, and it would
cost around 45 cents per 1,000 refactored pieces of code.

## Gallery

This section includes a handful of examples ["from the
wild"](https://github.com/tidymodels/tune/blob/f8d734ac0fa981fae3a87ed2871a46e9c40d509d/R/checks.R)
and are generated with the recommended model, Claude Sonnet 3.5.

At its simplest, a one-line message with a little bit of markup:

    rlang::abort("`save_pred` can only be used if the initial results saved predictions.")

Returns:

    cli::cli_abort("{.arg save_pred} can only be used if the initial results saved predictions.")

Some strange vector collapsing and funky line breaking:

    extra_grid_params <- glue::single_quote(extra_grid_params)
    extra_grid_params <- glue::glue_collapse(extra_grid_params, sep = ", ")

    msg <- glue::glue(
      "The provided `grid` has the following parameter columns that have ",
      "not been marked for tuning by `tune()`: {extra_grid_params}."
    )

    rlang::abort(msg)

Returns:

    cli::cli_abort(
      "The provided {.arg grid} has parameter columns that have not been
       marked for tuning by {.fn tune}: {.val {extra_grid_params}}."
    )

A message that probably best lives as two separate elements:

    rlang::abort(
      paste(
        "Some model parameters require finalization but there are recipe",
        "parameters that require tuning. Please use ",
        "`extract_parameter_set_dials()` to set parameter ranges ",
        "manually and supply the output to the `param_info` argument."
      )
    )

Returns:

    cli::cli_abort(
      c(
        "Some model parameters require finalization but there are recipe
         parameters that require tuning.",
        "i" = "Please use {.fn extract_parameter_set_dials} to set parameter
               ranges manually and supply the output to the {.arg param_info}
               argument."
      )
    )

Gnarly ad-hoc pluralization:

    msg <- "Creating pre-processing data to finalize unknown parameter"
    unk_names <- pset$id[unk]
    if (length(unk_names) == 1) {
      msg <- paste0(msg, ": ", unk_names)
    } else {
      msg <- paste0(msg, "s: ", paste0("'", unk_names, "'", collapse = ", "))
    }
    rlang::inform(msg)

Returns:

    cli::cli_inform(
      "Creating pre-processing data to finalize unknown parameter{?s}: {.val {unk_names}}"
    )

Some [`paste0()`](https://rdrr.io/r/base/paste.html) wonk:

    rlang::abort(paste0(
      "The workflow has arguments to be tuned that are missing some ",
      "parameter objects: ",
      paste0("'", pset$id[!params], "'", collapse = ", ")
    ))

Returns:

    cli::cli_abort(
      "The workflow has arguments to be tuned that are missing some
       parameter objects: {.val {pset$id[!params]}}"
    )

The model is instructed to only return a call to a cli function, so
erroring code that's run conditionally can get borked:

    cls <- paste(cls, collapse = " or ")
    if (!fine) {
      msg <- glue::glue("Argument '{deparse(cl$x)}' should be a {cls} or NULL")
      if (!is.null(where)) {
        msg <- glue::glue(msg, " in `{where}`")
      }
      rlang::abort(msg)
    }

Returns:

    cli::cli_abort(
      "Argument {.code {deparse(cl$x)}} should be {?a/an} {.cls {cls}} or {.code NULL}{?in {where}}."
    )

Note that `?in where` is not valid cli markup.

Sprintf-style statements aren't an issue:

    abort(sprintf("No such '%s' function: `%s()`.", package, name))

Returns:

    cli::cli_abort("No such {.pkg {package}} function: {.fn {name}}.")

## Interfacing manually with the cli helper

Chore helpers are typically interfaced with via the chores addin. To
call the cli helper directly, use:

    helper_cli <- .init_helper("cli")

Then, to submit a query, run:

    helper_cli$chat({x})
