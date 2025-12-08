#' Initialize a Helper object
#'
#' @description
#' **Users typically should not need to call this function.**
#'
#' * Create new helpers that will automatically be registered with this function
#' with [prompt_new()].
#' * The [chores addin][.init_addin()] will initialize needed helpers on-the-fly.
#'
#' @param chore The identifier for a helper prompt. By default one
#' of `r glue::glue_collapse(paste0("[", glue::double_quote(default_chores), "]", "[", default_chores, "_helper", "]"), ", ", last = " or ")`,
#' though custom helpers can be added with [prompt_new()].
#' @param .chores_chat An ellmer Chat, e.g.
#' `ellmer::chat_claude()`. Defaults to the `chores.chat` option,
#' so e.g. set
#' `options(chores.chat = ellmer::chat_claude(model = "claude-3-7-sonnet-20250219"))`
#'  in your
#' `.Rprofile` to configure chores with ellmer every time you start a new R session.
#'
#' @returns
#' A Helper object, which is a subclass of an ellmer chat.
#'
#' @examples
#' # requires an API key and sets options
#' \dontrun{
#' # to create a chat with claude:
#' .init_helper(.chores_chat = ellmer::chat_claude(model = "claude-3-7-sonnet-20250219"))
#'
#' # or with OpenAI's GPT-4o-mini:
#' .init_helper(.chores_chat = ellmer::chat_openai(model = "gpt-4o-mini"))
#'
#' # to set OpenAI's GPT-4o-mini as the default model powering chores, for example,
#' # set the following option (possibly in your .Rprofile, if you'd like
#' # them to persist across sessions):
#' options(
#'   chores.chat = ellmer::chat_openai(model = "gpt-4o-mini")
#' )
#' }
#' @export
.init_helper <- function(
  chore = NULL,
  .chores_chat = get_chores_chat()
) {
  check_chore(chore, allow_default = TRUE)
  if (!chore %in% list_helpers()) {
    cli::cli_abort(c(
      "No helpers for chore {.arg {chore}} registered.",
      "i" = "See {.fn prompt_new}."
    ))
  }

  Helper$new(chore = chore, .chores_chat = .chores_chat)
}

default_chores <- c("cli", "testthat", "roxygen")
