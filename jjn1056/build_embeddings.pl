#! env perl

# Written by John Napiorkowski
#   https://dev.to/jjn1056/using-postgresql-pgvector-for-ai-part-2-using-vectors-for-natural-language-processing-b40
# Hacked by Jay Hannah

use 5.28.0;
# use DBI;
use AI::Embedding;
use Data::Printer;

$ENV{OPENAI_API_KEY} || die "You need to set ENV var OPENAI_API_KEY";

die "curl works fine, AI::Embedding is broken apparently. Migrate to OpenAPI::API?";
# curl https://api.openai.com/v1/embeddings \
#   -H "Content-Type: application/json" \
#   -H "Authorization: Bearer $OPENAI_API_KEY" \
#   -d '{
#     "input": "Your text string goes here",
#     "model": "text-embedding-ada-002"
#   }'

# my $dbh = DBI->connect(
#   'DBI:Pg:dbname=[DB]',
#   '[USER]',
#   '[PASSWORD',
# ) || die "Can't connect to DB";

# Here's the table
# CREATE TABLE meals (
#    id SERIAL PRIMARY KEY,
#    name VARCHAR(100) NOT NULL,
#    vector_info VECTOR(1536) NOT NULL
# );

my $embedding_api = AI::Embedding->new(
  api => 'OpenAI',
  key => $ENV{OPENAI_API_KEY},
);

# my $insert_stmt = $dbh->prepare('INSERT INTO meals (name, vector_info) VALUES (?, ?)');
foreach my $meal (<DATA>) {
  chomp($meal);
  print "Getting Embedding info for ..$meal..\n";
  my $embedding = $embedding_api->embedding($meal, [1]);
  p $embedding_api;
  die $embedding_api->error unless $embedding_api->success;

  # $insert_stmt->execute($meal, "[${embedding}]")
  #   or die "Couldn't execute statement: $DBI::errstr";

  last;
}
#$insert_stmt->finish();
#$dbh->disconnect();

__DATA__
French Croissant with Jam and Coffee
American Pancakes with Maple Syrup
Japanese Tamago Kake Gohan (Rice with Raw Egg)
Indian Masala Dosa with Coconut Chutney
Mexican Huevos Rancheros
Italian Frittata with Fresh Vegetables
English Full Breakfast (Bacon, Eggs, Sausage, Beans, and Toast)
Mediterranean Shakshuka with Crusty Bread
Chinese Dim Sum Platter
Turkish Menemen (Eggs with Tomatoes and Peppers)
Thai Green Curry with Jasmine Rice
Greek Gyro Wrap with Tzatziki Sauce
Moroccan Couscous with Vegetables and Chickpeas
Vietnamese Banh Mi Sandwich
Brazilian Feijoada (Black Bean Stew) with Rice
Korean Bibimbap with Kimchi
Italian Margherita Pizza
Indian Chicken Tikka Masala with Naan
Spanish Paella with Seafood and Saffron
French Coq au Vin (Chicken in Red Wine Sauce)
Mexican Enchiladas with Guacamole and Rice
Lebanese Shawarma Plate
Japanese Sushi Rolls
Mexican Guacamole with Tortilla Chips
Thai Spring Rolls with Peanut Sauce
Spanish Tapas Platter
Indian Samosas with Chutney
American Apple Pie with Vanilla Ice Cream
French Crème Brûlée
Italian Tiramisu
Japanese Matcha Green Tea Ice Cream
Indian Gulab Jamun
Brazilian Brigadeiros (Chocolate Truffles)
Greek Spanakopita (Spinach and Feta Pie)
Chinese Potstickers with Dipping Sauce
Mexican Queso Fundido (Melted Cheese Dip)
Japanese Edamame with Sea Salt
Moroccan Hummus with Pita Bread
Thai Massaman Curry with Jasmine Rice
Italian Spaghetti Carbonara
Indian Butter Chicken with Naan
Mexican Chicken Enchiladas with Red Sauce
Chinese Kung Pao Chicken with Fried Rice
Greek Greek Salad
Indian Vegetable Biryani
Brazilian Pão de Queijo (Cheese Bread)
Japanese Miso Soup
Italian Caprese Salad
Mexican Tacos Al Pastor
Thai Pad Thai
Spanish Gazpacho (Cold Tomato Soup)
Indian Aloo Gobi (Potato and Cauliflower Curry)
French Escargot (Snails)
Chinese General Tso's Chicken
Brazilian Moqueca (Fish Stew)
Japanese Tempura (Deep-Fried Vegetables and Seafood)
Mexican Chiles en Nogada (Stuffed Poblano Peppers)
Italian Risotto with Porcini Mushrooms
Indian Chana Masala (Chickpea Curry)
Thai Tom Yum Soup (Hot and Sour Soup)
Greek Moussaka (Eggplant Casserole)
Japanese Okonomiyaki (Cabbage Pancake)
Brazilian Coxinha (Chicken Croquette)
Spanish Patatas Bravas (Fried Potatoes with Spicy Sauce)
Indian Rogan Josh (Lamb Curry)
Italian Ossobuco alla Milanese (Veal Shank Stew)
Mexican Mole Poblano (Chocolate Chili Sauce)
Thai Som Tum (Green Papaya Salad)
French Boeuf Bourguignon (Beef Stew)
Indian Saag Paneer (Spinach with Cheese)
Italian Ravioli with Sage Butter Sauce
Chinese Mapo Tofu (Spicy Tofu)
Brazilian Acarajé (Black-Eyed Pea Fritters)
Japanese Tonkatsu (Breaded Pork Cutlet)
Mexican Ceviche (Marinated Seafood)
Thai Red Curry with Coconut Milk
Greek Moussaka (Eggplant Casserole)
Italian Osso Buco (Braised Veal Shanks)
Indian Malai Kofta (Cheese and Vegetable Dumplings)
Spanish Tortilla Española (Potato Omelette)
Japanese Yakitori (Grilled Skewered Chicken)
Brazilian Picanha (Grilled Beef Steak)
Mexican Chilaquiles (Tortilla Casserole)
Thai Green Papaya Salad
French Ratatouille (Vegetable Stew)
Indian Rogan Josh (Lamb Curry)
Italian Lasagna with Bolognese Sauce
Chinese Sweet and Sour Pork
Brazilian Brigadeiro Cake (Chocolate Cake)
Japanese Okonomiyaki (Cabbage Pancake)
Mexican Tamales
Thai Panang Curry
Greek Pastitsio (Baked Pasta Casserole)
Indian Chicken Biryani
Italian Gnocchi with Pesto Sauce
Chinese Kung Pao Tofu
Brazilian Moqueca (Fish Stew)
Japanese Udon Noodle Soup
Mexican Pozole (Hominy Stew)
Thai Pineapple Fried Rice
French Baguette with Brie and Grapes
American Cobb Salad with Ranch Dressing
Japanese Chirashi Sushi Bowl
Indian Aloo Paratha with Raita
Mexican Molletes (Open-Faced Bean Sandwiches)
Italian Orecchiette Pasta with Broccoli Rabe
English Fish and Chips with Tartar Sauce
Moroccan Lamb Tagine with Couscous
Brazilian Carne de Sol (Sun-Dried Beef)
Thai Green Papaya Salad
Greek Souvlaki with Tzatziki Sauce
Vietnamese Pho (Beef Noodle Soup)
Spanish Churros with Chocolate Sauce
Russian Borscht (Beet Soup) with Sour Cream
Jamaican Jerk Chicken with Rice and Peas
Korean Japchae (Stir-Fried Glass Noodles)
Lebanese Falafel with Hummus
Turkish Iskender Kebab
Nigerian Jollof Rice with Fried Plantains
Peruvian Lomo Saltado (Beef Stir-Fry)
Malaysian Nasi Lemak (Coconut Rice with Sambal)
Swiss Raclette (Melted Cheese Dish)
Indonesian Nasi Goreng (Fried Rice)
Egyptian Koshari (Lentil and Rice Dish)
Cuban Ropa Vieja (Shredded Beef Stew)
Swedish Meatballs with Lingonberry Sauce
Thai Tom Kha Gai (Chicken Coconut Soup)
Nigerian Egusi Soup with Fufu
Portuguese Pastel de Nata (Egg Custard Tart)
Hungarian Goulash with Dumplings
Jamaican Ackee and Saltfish
Malaysian Char Kway Teow (Stir-Fried Noodles)
Pakistani Biryani (Rice Dish with Meat)
Israeli Falafel Pita Sandwich
Swedish Gravlax (Cured Salmon)
Argentinean Asado (Barbecue)
Thai Larb Gai (Minced Chicken Salad)
Egyptian Ful Medames (Fava Bean Stew)
Vietnamese Goi Cuon (Fresh Spring Rolls)
Spanish Gambas al Ajillo (Garlic Shrimp)
Nigerian Suya (Grilled Spicy Skewered Meat)
Turkish Baklava (Layered Pastry with Nuts)
Syrian Muhammara (Red Pepper and Walnut Dip)
Jamaican Curry Goat with Rice and Peas
Filipino Lechon (Roast Pig)
Malaysian Roti Canai with Curry Sauce
Ethiopian Doro Wat (Chicken Stew)
Peruvian Ceviche (Marinated Seafood)
Israeli Shakshuka (Eggs in Tomato Sauce)
Moroccan Pastilla (Sweet and Savory Pie)
