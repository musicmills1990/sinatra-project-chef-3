
There will be three models: Users, Recipes, and Kitchens(now called Ingredients).

Users will save a users kitchen inventory, allow them to log in and out.

Kitchens will allow users to add to their inventory, edit their inventory, delete items out of their inventory. A user cannot add to, edit, or delete items out of another user’s kitchen.

Recipes will display the instructions to make a dish (if possible it would be awesome to embed a instructional cooking video from youtube), new recipes can be added by users, a user that creates a recipe can edit or delete their own recipe. A recipe will appear available to a user if they have the ingredients it requires in their kitchen inventory. A user should be able to add a new recipe without having the ingredients it requires in their kitchen. So maybe there will be three options to view for a user: “Useful Recipes”, “All recipes”, and “My recipes”.

So some version 1.0 basic "MVP" functionality:
to  match recipes to user’s based on their kitchen inventory, for the purposes of this very basic version of this app I’m going to skip ingredient quantity matching. If a user lists “chicken” and “black beans” in their kitchen inventory, and a recipe calls for chicken and black beans, it will appear to them, and in the recipe instructions it will list the quantity required. If the user doesn’t have enough for the recipe they’ll have to discover that out for themselves for this version.
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
^^ figured this out: uniqueness: true in the inherited model Users


Things I want:

- I want to be able to create delete buttons that will sit next to each item on the list*
- I'd like line 5 of ingredients_controller to work such that a user only see their own ingredient objects.
- I obviously would like to also be able to create multiple buttons within each section of the ingredient new form**

*Obviously the better version of this is to be able to click a delete button that brings up selectors for each item and you can delete as many as you want.
**would this mean I need to have multiple ingredient objects nested inside of my form? You can't have an attribute as an array, can you?*

#because I'm having trouble creating multiple spaces for new ingredient items,
#I'd like to seed some suggestive data for the user to have available to just click if they have it in their fridge.
#Is it possible to seed data without adding it to the index page? Well, in theory if each user's ingredients page only showed their own
#ingredient objects, then if you make an admin user that has all of those ingredients already input.

#SO, answer is this: You have to write code that exposes ALL ingredients for the new form, but doesn't have the button clicked unless it's the
#current_user's ingredient object, and on the index page you can only see your own ingredients. Then "other users" will have put their ingredients
#in and those act as the suggestions for people to click, then we'll hopefully figure out the mulitple input lines on the forms at another time


√If I want to greet the current_user


Okay interesting issue regarding delete buttons...
-the way we've done delete before was to add a delete feature to a show page for an individual object, but if I want to delete just one item, each Ingredient object may be tied to 3 attributes: fridge_freezer_item, pantry_item, and spice_cabinet_item.. how do I delete just the attribute @ingredient.fridge_freezer_item without destroying the whole object? Still wondering if this is the right model setup for my ingredients....

Issues 12/8 11:45am

Ingredient side:
-New form buttons don't save those ingredients to the current_user's collection of items (confused conceptually about how this would work)
-Delete button is conceptually an issue (see notes above)
okay I might need to ask for help about this, for now I'm going to start building out my recipe side
-if you don't add one of the three categories to the new form, it adds an empty attribute to the list =/


Recipe side:
I needed to add more columns to the recipe table so a person could build their recipe in a more organize way than a single string, which would be ugly.
I still need to:
<<<1. add edit and delete features in the controller, but that's pretty easy.>>>> DONE.
2. look into that connection between user and recipes, and be able to display whose recipes are whose


Ok I'm about to dump my ingredients table and totally redo this stuff because I'm pretty sure I've dug myself into a hole with trying to organize the ingredients into those three categories, because now I can't delete one item without it being attached to the other two. Before I do this, let's look at the recipe current_user issue.
