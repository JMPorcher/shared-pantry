  ACTIONS THAT TRIGGER DATABASE CHANGES


  VERSION WITHOUT OTHER USERS:
- User creates account
  [X] User is added to /users
- [X] User adds new PANTRY
    Add to database:
      [X] added to /pantries
      [X] added to /users/user/pantries
      [X] User is added to /users/user/pantries/pantry/users
      [X] User is added to /users/user/pantries/pantry/moderators
    Read from database:
- User adds CATEGORY
  [] added to /pantries/pantry
  [] change is logged in PANTRY history
- User adds ITEM
  [] added to /pantries/pantry/category
  [] change is logged in PANTRY history

- User deletes account
  - All their PANTRIES are deleted
- User deletes/leaves PANTRY
  - PANTRY is deleted from /pantries
- User deletes CATEGORY
  - deleted from /pantries/pantry
  - change is logged in PANTRY history
- User deletes ITEM
  - deleted from /pantries/pantry/category
  - change is logged in PANTRY history

- User switches/buys ITEM
  - ITEM's status is switched in /pantries/pantry/category
  - change is logged in PANTRY history
- User creates account
  - User is added to /users
- User adds new PANTRY
  - added to /pantries
  - added to /users/user/pantries
  - User is added to /users/user/pantries/pantry/users
  - User is added to /users/user/pantries/pantry/moderators
- User adds CATEGORY
  - added to /pantries/pantry
  - others are notified
  - change is logged in PANTRY history
- User adds ITEM
  - added to /pantries/pantry/category
  - others are notified
  - change is logged in PANTRY history
- Additional user is added to PANTRY
  - User is added to /pantries/pantry/users
  - others are notified
  - change is logged in PANTRY history
- User grants moderator rights to other users
  - other users are added to MODERATORS list

- User deletes account
  - User is deleted from their PANTRIES' user lists
  - change is logged in PANTRY history
  - If they are the only User their PANTRIES are deleted altogether
- User deletes/leaves PANTRY
  - Same as User deletes account
- User deletes CATEGORY
  - deleted from /pantries/pantry
  - others are notified
  - change is logged in PANTRY history
- User deletes ITEM
  - deleted from /pantries/pantry/category
  - others are notified
  - change is logged in PANTRY history

- User switches/buys ITEM
  - ITEM's status is switched in /pantries/pantry/category
  - others are notified
  - change is logged in PANTRY history


