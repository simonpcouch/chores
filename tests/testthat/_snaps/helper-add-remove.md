# helper addition and removal works

    Code
      helper_echo
    Message
      
      -- A echotest chore helper using claude-haiku-4-5. 

# helper addition with bad inputs

    Code
      .helper_add(chore = identity, prompt = "hey")
    Condition
      Error in `.helper_add()`:
      ! `chore` must be a single string, not a function.

---

    Code
      .helper_add(chore = "sillyhead", prompt = "hey", interface = "no")
    Condition
      Error in `.helper_add()`:
      ! `interface` should be one of "replace", "prefix", or "suffix".

---

    Code
      .helper_add(chore = "sillyhead", prompt = "hey", interface = NULL)
    Condition
      Error in `.helper_add()`:
      ! `interface` should be one of "replace", "prefix", or "suffix".

# helper remove with bad inputs

    Code
      .helper_remove(chore = identity)
    Condition
      Error in `.helper_remove()`:
      ! `chore` must be a single string, not a function.

---

    Code
      .helper_remove(chore = "notAnActiveHelper")
    Condition
      Error in `.helper_remove()`:
      ! No active helper with the given `chore`.

