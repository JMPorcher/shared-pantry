# shared_pantry

Probably the Firebase key: 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
Know which household items are currently in the house. Add more pantries: personal, for your club etc.

## TO-DOs

[X] save opened/closed state for category tiles
--> Used ExpansionTile's initiallyExpanded parameter that gets triggered every time the list is rebuilt. The parameter gets fed by the isExpanded boolean in the provider.
[X] Move "add category" button from list_screen.dart bottom to top, "Add first category" label if there are none yet
--> Button moved to expandable_category_list.dart

[X] Add Pantry to Provider
[X] PageView for Pantries
[X] Add Pantry title to AppBar
[X] Make it possible to add Pantry
[X] Implement PageController so the PageView switches to the new page upon adding 
--> implemented, but animation seems wonky
[X] Make it possible to remove and rename Pantry

[X] Adjust ShoppingList for Pantries, with checkboxes vor which Pantries to include.


[X] Welcome screen "Add your first pantry"

[] Move AppBar from pantry to overall scaffold
--> Really necessary?

[] Registration on first opening the app. Can be skipped.
[] Registration can be done through FloatingActionButton at any time.

[] Firebase basic structure (I'm scared man)
[] Firebase groups

[] Localization for EN/GER
[] Pre-available Pantries, Categories and Items

[] Make a plan for the UX
[] Make a theme and apply it


## Questions
- How does Firebase store users? Do I get to structure that?
- Do I store the user in a different provider? Or the same as PantryProvider or not at all?




HOW TO STORE THIS IN FIREBASE???

How to add users
JSON Pantry Model
{
 pantry: "Pantry Title",
 pantry_id: "pantryHash",
 users: [
  "user_id_hash",
  "user_id_hash",
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
  ]
}

JSON User Model
How does Firebase structure a user? Do I get to decide?
{
 id: "user_id_hash",
 phone_number: 123456789,
 user_name: "name",
 subscribed_pantries: 
   [
     pantry_id: "pantryHash",
     pantry_id: "pantryHash",
   ]
}