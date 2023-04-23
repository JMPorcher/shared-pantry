# shared_pantry

Probably the Firebase key: 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
Know which household items are currently in the house. Add more pantries: personal, for your club etc.

## TO-DOs

[X] save opened/closed state for category tiles
--> Used ExpansionTile's initiallyExpanded parameter that gets triggered every time the list is rebuilt. The parameter gets fed by the isExpanded boolean in the provider.
[X] Move "add category" button from list_screen.dart bottom to top, "Add first category" label if there are none yet
--> Button moved to expandable_category_list.dart

[X] Does the **Pantry class** need something else at this point?
--> nah
[X] Add Pantry to Provider
[X] PageView for Pantries
[X] Add Pantry title to AppBar
[X] Make it possible to add Pantry
[] Implement PageController so the PageView switches to the new page upon adding
[X] Make it possible to remove and rename Pantry

[] Adjust ShoppingList for Pantries


[] Welcome screen "Add your first pantry"

[] Delete option for Pantries: personal is archivable/deletable, shared can be erased by Pantry starter or left by every other user
[] Firebase basic structure (I'm scared man)
[] Firebase groups





HOW TO STORE THIS IN FIREBASE???
JSON Format Categories and Lists:
[
  {
    category_title: "Category 1",
    list: [
      {"item" : bool}
      {"item" : bool}
    ]     
  },
  {
    category_title: "Category 2",
    list: [
      {"item" : bool}
      {"item" : bool}
    ]     
  },
]