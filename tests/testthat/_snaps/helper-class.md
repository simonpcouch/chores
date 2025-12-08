# fetch_chores_chat returns early with no option set

    Code
      .res <- fetch_chores_chat()
    Message
      ! chores requires configuring an ellmer Chat with the chores.chat option.
      i Set e.g. `options(chores.chat = ellmer::chat_claude(model = "claude-3-7-sonnet-20250219"))` in your '~/.Rprofile' and restart R.
      i See "Choosing a model" in `vignette("chores", package = "chores")` to learn more.

# fetch_chores_chat returns early with bad config

    Code
      .res <- fetch_chores_chat()
    Message
      ! The option chores.chat must be an ellmer Chat object, not a string.
      i See "Choosing a model" in `vignette("chores", package = "chores")` to learn more.

