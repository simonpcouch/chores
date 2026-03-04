test_that("helper addition and removal works", {
  skip_if(identical(Sys.getenv("ANTHROPIC_API_KEY"), ""))
  skip_if_not_installed("withr")
  withr::local_options(
    chores.chat = ellmer::chat_claude(model = "claude-haiku-4-5"),
    .chores_chat = NULL
  )

  echo_prompt <- "Reply with exactly the user's input, unchanged. Do not add any other text."
  .helper_add("echotest", echo_prompt)

  expect_equal(env_get(chores_env(), ".helper_prompt_echotest"), echo_prompt)
  expect_true(is_function(env_get(chores_env(), ".helper_rs_echotest")))

  helper_echo <- .init_helper("echotest")
  expect_snapshot(helper_echo)
  expect_true(".helper_last_echotest" %in% names(chores_env()))

  res <- helper_echo$chat("abc123", echo = FALSE)
  expect_true(grepl("abc123", res))

  .helper_remove("echotest")

  expect_false(".helper_last_echotest" %in% names(chores_env()))
  expect_false(".helper_prompt_echotest" %in% names(chores_env()))
  expect_false(".helper_rs_echotest" %in% names(chores_env()))
})

test_that("helper addition with bad inputs", {
  expect_snapshot(
    error = TRUE,
    .helper_add(chore = identity, prompt = "hey")
  )

  expect_snapshot(
    error = TRUE,
    .helper_add(chore = "sillyhead", prompt = "hey", interface = "no")
  )
  expect_snapshot(
    error = TRUE,
    .helper_add(chore = "sillyhead", prompt = "hey", interface = NULL)
  )
})

test_that("helper remove with bad inputs", {
  expect_snapshot(
    error = TRUE,
    .helper_remove(chore = identity)
  )
  expect_snapshot(
    error = TRUE,
    .helper_remove(chore = "notAnActiveHelper")
  )
})
