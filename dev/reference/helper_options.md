# Options used by the chores package

The chores package makes use of two notable user-facing options:

- `chores.chat` determines the underlying LLM powering each helper. See
  the "Choosing a model" section of
  [`vignette("chores", package = "chores")`](https://simonpcouch.github.io/chores/dev/articles/chores.md)
  for more information. The legacy option `.chores_chat` is also
  supported.

- `chores.dir` is the directory where helper prompts live. See the
  helper
  [directory](https://simonpcouch.github.io/chores/dev/reference/directory.md)
  help-page for more information. The legacy option `.chores_dir` is
  also supported.
