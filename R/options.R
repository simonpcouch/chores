#' Options used by the chores package
#'
#' @description
#' The chores package makes use of two notable user-facing options:
#'
#' * `chores.chat` determines the underlying LLM powering each helper.
#'   See the "Choosing a model" section of `vignette("chores", package = "chores")`
#'   for more information. The legacy option `.chores_chat` is also supported.
#' * `chores.dir` is the directory where helper prompts live. See the helper [directory]
#'   help-page for more information. The legacy option `.chores_dir` is also supported.
#'
#' @name helper_options
#' @aliases chores.chat
#' @aliases .chores_chat
#' @aliases chores.dir
#' @aliases .chores_dir
NULL
