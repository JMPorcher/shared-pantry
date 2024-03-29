[] Transition Overview -> Pantry Screen: 
    [x] Remove tap area, make entire Card clickable
    [] Make an arrow appear briefly
[] Make add buttons look like the elements they produce
    [x] Add Pantry
    [X] Add Category
[x] Overview Header
[x] Shopping List Header
[x] Short info shopping screen
[] Self-explaining toggles Pantry Screen
[] Gather checked-off items at the end of shopping list?
[] Rebuild Expansion Tiles with AnimatedContainer custom tiles


# shared_pantry

Know which household items are currently in the house. Add more pantries: personal, for your club etc.

## TO-DOs

[] Registration on first opening the app. Can be skipped. User will
[] Firebase basic structure. User is created in first_startup_screen and can be registered (registered is used later for shared pantries)


[] PANTRY ASSISTANT: Pre-available Pantries, Categories and Items
    [] Compile lists of categories and items
    [] Design dialogs/interface
[] REGISTRATION PROCESS: 
    [] Design first opening screens
    [] Assign user on first startup
    [] Design registration screen, implement in Profile screen
[] PANTRY CARD DESIGN
    [] Draw design for OverviewScreen
    [] Draw design for PantryScreen

[] Make a plan for the UX
[] Localization for EN/GER


## Questions
--


JSON Pantry Model
{
 pantry: "Pantry Title",
 pantry_id: "uniquePantryId",
 users: [
  "generated_user_id",
  "generated_user_id",
 ],
 moderators: [
  "generated_user_id",
  "generated_user_id",
 ],
 categories: [
    {
      category: "Category 1",
      items: [
        {"item" : bool}
        {"item" : bool}
      ]     
    },
    {
      category: "Category 2",
      items: [
        {"item" : bool}
        {"item" : bool}
      ]     
    },
  ],
  activityHistory: {
    [
      {
        "time_stamp" : String
        "generated_user_id" : "item"
      },
        "time_stamp" : String
        "generated_user_id" : "item"
      },
    ]
  }
}

JSON User Model
{
 email: test@test.de,
 user_name: "name",
 subscribed_pantries: 
   [
      {
         pantry_id: "uniquePantryId",
         isSelected: bool,
         isSelectedForShopping: bool,
         isSelectedForPushNotifications: bool
      },
      {
         pantry_id: "uniquePantryId",
         isSelected: bool,
         isSelectedForShopping: bool,
         isSelectedForPushNotifications: bool
      },
   ]
}



Buttons:
- AddItemButtons
- All-purpose button

TextFields:
- QuickAddItem
- AddItem

Other:
- switches

Composed widgets:
- Category tile
- Category listview
- 