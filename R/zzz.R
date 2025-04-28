# nocov start

.onLoad <- function(libname, pkgname) {
  chores_env <- chores_env()
  withr::local_options(.helper_on_load = TRUE)

  directory_load(system.file("prompts", package = "chores"))

  load_chores_directory()
}

# nocov end
