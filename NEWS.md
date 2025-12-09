# chores (development version)

* Adjusted the default recommended models in documentation (#98).

    - **Local models**: At the time of chores' last release, open-weights models that could reasonably run on a high-end laptop didn't do the trick for powering chores helpers. The Qwen3 4B Instruct 2507 release changed this; the model provides high-accuracy responses with low latency on high-end laptops. See the "Getting started with chores" vignette for more information.
    - **OpenAI**: GPT-4o and GPT-4o-mini transitioned to GPT 4.1 and GPT 4.1 mini, respectively.
    - **Anthropic**: Claude Sonnet 3.5 -> Claude Sonnet 3.7. Note that Sonnet 3.7 is not the newest available minimally-thinking model from Anthropic. The newer models like Sonnet and Haiku 4.5 tend to introduce backticks in responses and struggle to strictly follow the requested output format.

* Reduced the cli helper prompt from ~4,100 to ~2,300 tokens for compatibility with default context window lenth of ollama and LM Studio, 4096. Previously, those applications would silently truncate the prompt, resulting in the model not receiving access to critical instructions about response format and appearing to ignore it entirely. The other default helper prompts were already well below the default limit.

* Introduced `chores.chat` and `chores.dir` as the preferred option names, following standard R package option naming conventions. The legacy options `.chores_chat` and `.chores_dir` continue to work and will not be deprecated (#99).

* Bumped the minimum version of the streamy package to 0.2.1, which will resolve an issue where some newlines were removed from multi-line file writes in Positron (#96).

# chores 0.2.0

* In the helper selection app, clicking a helper in the selectize will now 
  submit the selected choice. Previously, the user would have to click the 
  helper to select it _and then_ submit the selected choice by pressing 
  Return/Enter (#87). This change aligns behavior in the UI when selecting 
  helpers with a mouse click versus the up/down arrows.

* Users no longer need to call `directory_load()` manually after adding new
  custom helpers; the helper selection app will refresh the list of available
  helpers on app launch (#88).
  
# chores 0.1.0

* Initial CRAN submission.

## Notable changes pre-CRAN submission

Early adopters of the package will note a few changes made shortly before the 
release of the package to CRAN:

* The package was renamed from pal to chores, and the grammar surrounding the 
  package shifted a bit in the process: "a pal from the pal package with a 
  given role" is now "a helper from the chores package for a given chore."

* The configuration options `.pal_fn` and `.pal_args` have been 
  transitioned to one option, `.chores_chat`. That option takes an ellmer Chat, 
  e.g. `options(.chores_chat = ellmer::chat_claude())`.

* There is no longer a default ellmer model. Early in the development
  of chores, if you had an `ANTHROPIC_API_KEY` set up, the addin would
  "just work." While this was convenient for Claude users, but it means that the 
  package spends money on the users behalf without any explicit opt-in.
