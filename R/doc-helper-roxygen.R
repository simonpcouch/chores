#' The roxygen helper
#'
#' @description
#'
#' The roxygen helper prefixes the selected function with a minimal roxygen2
#' documentation template. The helper is instructed to only generate a subset
#' of a complete documentation entry, to be then completed by a developer:
#'
#' * Stub `@param` descriptions based on defaults and inferred types
#' * Stub `@returns` entry that describes the return value as well as important
#'   errors and warnings users might encounter.
#'
#'
#' @section Cost:
#'
#' The system prompt from a roxygen helper includes something like 1,000 tokens.
#' Add in 200 tokens for the code that's actually highlighted
#' and also sent off to the model and you're looking at 1,200 input tokens.
#' The model returns maybe 10 to 15 lines of relatively barebones royxgen
#' documentation, so we'll call that 200 output tokens per refactor.
#'
#' As of the time of writing (October 2024), the recommended chores model Claude
#' Sonnet 3.5 costs $3 per million input tokens and $15 per million output
#' tokens. So, using the recommended model,
#' **roxygen helpers cost around $4 for every 1,000 generated roxygen documentation
#' entries**. GPT-4o Mini, by contrast, doesn't tend to infer argument types
#' correctly as often and
#' often fails to line-break properly, but _does_ usually return syntactically
#' valid documentation entries, and it would cost around
#' 20 cents per 1,000 generated roxygen documentation entries.
#'
#' @section Gallery:
#'
#' This section includes a handful of examples "from the wild"
#' and are generated with the recommended model, Claude Sonnet 3.5.
#'
#' Documenting a function factory:
#'
#' ```r
#' deferred_method_transform <- function(lambda_expr, transformer, eval_env) {
#'   transformer <- enexpr(transformer)
#'   force(eval_env)
#'
#'   unique_id <- new_id()
#'   env_bind_lazy(
#'     generators,
#'     !!unique_id := inject((!!transformer)(!!lambda_expr)),
#'     eval.env = eval_env
#'   )
#'
#'   inject(
#'     function(...) {
#'       (!!generators)[[!!unique_id]](self, private, ...)
#'     }
#'   )
#' }
#' ```
#'
#' Returns:
#'
#' ```r
#' #' #' Transform a deferred method
#' #'
#' #' @description
#' #' A short description...
#' #'
#' #' @param lambda_expr A lambda expression to transform.
#' #' @param transformer A transformer function or expression.
#' #' @param eval_env The environment in which to evaluate the transformer.
#' #'
#' #' @returns
#' #' A function that, when called, will evaluate the transformed lambda expression.
#' #' The returned function accepts `...` arguments which are passed to the generated function.
#' #'
#' #' @export
#' ```
#'
#' A function that may raise a condition:
#'
#' ```r
#' set_default <- function(value, default, arg = caller_arg(value)) {
#'   if (is.null(value)) {
#'     if (!is_testing() || is_snapshot()) {
#'       cli::cli_inform("Using {.field {arg}} = {.val {default}}.")
#'     }
#'     default
#'   } else {
#'     value
#'   }
#' }
#' ```
#'
#' Returns:
#'
#' ```r
#' #' Set default value
#' #'
#' #' @description
#' #' A short description...
#' #'
#' #' @param value A value to check.
#' #' @param default The default value to use if `value` is NULL.
#' #' @param arg Optional. The name of the argument being set.
#' #'
#' #' @returns
#' #' Returns `value` if it's not NULL, otherwise returns `default`.
#' #' Informs the user when using the default value.
#' #'
#' #' @export
#' ```
#'
#' A function with some tricky indexing:
#'
#' ```r
#' find_index <- function(left, e_right) {
#'   if (!is.list(e_right) || !has_name(e_right, "index") || !is.numeric(e_right$index)) {
#'     return(NA)
#'   }
#'
#'   matches_idx <- map_lgl(left, function(e_left) e_left$index == e_right$index)
#'   if (sum(matches_idx) != 1) {
#'     return(NA)
#'   }
#'   which(matches_idx)[[1]]
#' }
#' ```
#'
#' Returns:
#'
#' ```
#' #' Find matching index
#' #'
#' #' @description
#' #' A short description...
#' #'
#' #' @param left A list of elements, each expected to have an 'index' field.
#' #' @param e_right A list with an 'index' field to search for in `left`.
#' #'
#' #' @returns
#' #' The numeric index in `left` where `e_right$index` matches, or NA if not found
#' #' or if inputs are invalid. Returns NA if multiple matches are found.
#' #'
#' #' @export
#' ```
#'
#' @templateVar chore roxygen
#' @template manual-interface
#'
#' @name roxygen_helper
NULL
