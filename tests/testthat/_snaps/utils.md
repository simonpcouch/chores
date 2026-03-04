# .helper_last is up to date with most recent helper

    Code
      env_get(chores_env(), ".helper_last")
    Message
      
      -- A cli chore helper using gemini-3-flash-preview. 

---

    Code
      env_get(chores_env(), ".helper_last_cli")
    Message
      
      -- A cli chore helper using gemini-3-flash-preview. 

---

    Code
      env_get(chores_env(), ".helper_last")
    Message
      
      -- A cli chore helper using gpt-4.1-mini. 

# chore checks error informatively

    Code
      check_chore("hey there")
    Condition
      Error:
      ! `chore` must be a single string containing only letters and digits.

---

    Code
      check_chore(identity)
    Condition
      Error:
      ! `chore` must be a single string, not a function.

