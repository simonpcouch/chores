# initializing a helper

    Code
      .init_helper("cli")
    Message
      
      -- A cli chore helper using gemini-3-flash-preview. 

---

    Code
      .init_helper("testthat")
    Message
      
      -- A testthat chore helper using gemini-3-flash-preview. 

# can use other models

    Code
      .init_helper("cli", .chores_chat = ellmer::chat_openai(model = "gpt-4.1-mini"))
    Message
      
      -- A cli chore helper using gpt-4.1-mini. 

# errors informatively with bad chore

    Code
      .init_helper()
    Condition
      Error in `.init_helper()`:
      ! `chore` must be a single string, not `NULL`.

---

    Code
      .init_helper(NULL)
    Condition
      Error in `.init_helper()`:
      ! `chore` must be a single string, not `NULL`.

---

    Code
      .init_helper("beepBopBoop")
    Condition
      Error in `.init_helper()`:
      ! No helpers for chore `beepBopBoop` registered.
      i See `prompt_new()`.

