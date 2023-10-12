# shared_pantry

Probably the Firebase key: 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
Know which household items are currently in the house. Add more pantries: personal, for your club etc.

## TO-DOs

[] Registration on first opening the app. Can be skipped.
[] Firebase basic structure. User is created in first_startup_screen and can be registered (registered is used later for shared pantries)

[] Localization for EN/GER
[] Pre-available Pantries, Categories and Items

[] Make a plan for the UX
[] Make a theme and apply it



## Questions
--


JSON Pantry Model
{
 pantry: "Pantry Title",
 pantry_id: "uniquePantryId",
 users: [
  "user_id",
  "user_id",
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
{
 id: "user_id",
 email: test@test.de,
 user_name: "name",
 subscribed_pantries: 
   [
      {
         pantry_id: "uniquePantryId",
         isSelected: bool
      },
      {
         pantry_id: "uniquePantryId",
         isSelected: bool
      },
   ]
}