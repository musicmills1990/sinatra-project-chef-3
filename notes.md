
There will be three models: Users, Recipes, and Kitchens.

Users will save a users kitchen inventory, allow them to log in and out.

Kitchens will allow users to add to their inventory, edit their inventory, delete items out of their inventory. A user cannot add to, edit, or delete items out of another user’s kitchen.

Recipes will display the instructions to make a dish (if possible it would be awesome to embed a instructional cooking video from youtube), new recipes can be added by users, a user that creates a recipe can edit or delete their own recipe. A recipe will appear available to a user if they have the ingredients it requires in their kitchen inventory. A user should be able to add a new recipe without having the ingredients it requires in their kitchen. So maybe there will be three options to view for a user: “Useful Recipes”, “All recipes”, and “My recipes”.

So some version 1.0 basic functionality:
to  match recipes to user’s based on their kitchen inventory, for the purposes of this very basic version of this app I’m going to skip ingredient amount matching. If a user lists “chicken” and “black beans” in their kitchen inventory, and a recipe calls for chicken and black beans, it will appear to them, and in the recipe instructions it will list the quantity required. If the user doesn’t have enough for the recipe they’ll have to discover that out for themselves for this version.
You’ll have to make three different new forms for adding items to the kitchen page, and in the view it’ll be three different variables that add buttons to the three sections “fridge & freezer”, “pantry” and “spice cabinet”
On the kitchen items list, I’m not sure how to delete multiple items off the list. I’d like it to be hit the delete button, and all of the click buttons clear and you click all of the ones you want to delete and hit a confirm delete button and it deletes the ones you selected. Or a delete button auto-generates next to each item and it redirects you right back to the page.
I think for simplicity’s sake, I’m going to skip building the “kitchen-recipes” function for now, unless I’m able to figure it out. I would need a lot of join tables and other complicated functions in order to match the items in your kitchen to the recipes. For the sinatra requirements I think I can start with a v0.1.0 that just has a kitchen database and a recipe database, then I have to style it anyway so don’t bite off more than I can chew.


Okay data and relationships:

Models:
User will have many Recipes
A Recipe belongs to a User
Will a kitchen be it's own model? Yes because Kitchen == Inventory items
so in the same way that you have mulitple tweets, you can have multiple "kitchens" that indicate the multiple items in your kitchen
Okay maybe a better class name is Ingredients

Also, I think the best way to proceed rather than worrying from the beginning how to connect the many-to-many relationship (or perhaps more complex relationship than that, since one Recipe object would need to match multiple Ingredient objects...) of the Ingredients class and Recipe class, start with a User has many Ingredients AND Recipes (so for the purposes of this they'll only be adding their own recipes or looking at other people's recipes), and both ingredients and recipes will simply belong to a User.

So I Believe each table is going to need the following:

User
:username
:email
:password_digest

ingredients
:fridge_freezer_item
:pantry_item
:spice_cabinet_item
:user_id

recipes
:content
:user_id


-I have the right logic for my username/password login and signup but how do I make it so that only one user can use their exact username?
