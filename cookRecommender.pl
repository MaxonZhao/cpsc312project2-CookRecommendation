% Parse a valid formatted sentence.
parse_sentence(L0, L5, Ind) :-
    subject(L0, L1, Ind), 
    verb(L1, L2, Ind),
    prep(L2, L3, Ind),
    end(L3, L4, Ind),
    nouns(L4, L5, Ind).

subject(["I" | L], L, _).
verb(["cook" | L], L, _).
verb(["make" | L], L, _).

prep(["with" | L], L, _).

nouns(L0, L2, Ind) :-
    noun(L0, L1, Ind),
    nouns(L1, L2, Ind).

nouns(["and" | L0], L2, Ind) :-
    noun(L0, L1, Ind),
    nouns(L1, L2, Ind).

nouns(L, L, _).

end([], [], _) :- !, fail.
end(L, L, _) :- !.

noun([IngName | L], L, Ind) :- dish(Ind, Ing), name(Ing, IngName).

% question(Question, QR, Ind) is true if Ind is  an answer to Question
question(["What", "can" | L0], L1, Ind) :- 
    parse_sentence(L0, L1, Ind).

% ask(Q, A) gives answer A to question Q
ask(Q, A) :- 
    question(Q, [], A).


% The Database of Facts to be Queried

% Pancakes 
dish(pancakes, flour).
dish(pancakes, milk).

% Oatmeal Cookies 
dish(oatmeal_cookies, oats).
dish(oatmeal_cookies, flour).

% Cornbread 
dish(cornbread, flour).
dish(cornbread, cornmeal).

% Spaghetti Carbonara 
dish(spaghetti_carbonara, pasta).
dish(spaghetti_carbonara, cheese).

% Apple Crisp 
dish(apple_crisp, apples).
dish(apple_crisp, flour).

% Orange Chicken 
dish(orange_chicken, oranges).
dish(orange_chicken, chicken).

% Banana Bread 
dish(banana_bread, bananas).
dish(banana_bread, flour).

% Smoothie 
dish(smoothie, banana).
dish(smoothie, apples).
dish(smoothie, oranges).
dish(smoothie, berries).
dish(smoothie, avocado).
dish(smoothie, milk).
dish(smoothie, yogurt).

% Avocado Toast 
dish(avocado_toast, avocado).
dish(avocado_toast, cheese).

% Caesar Salad 
dish(caesar_salad, lettuce).
dish(caesar_salad, cheese).

% Stuffed Chicken 
dish(stuffed_chicken, chicken).
dish(stuffed_chicken, cheese).
dish(stuffed_chicken, spinach).

% Veggie Soup 
dish(veggie_soup, broccoli).
dish(veggie_soup, carrot).
dish(veggie_soup, tomatoes).
dish(veggie_soup, beans).

% Grilled Chicken 
dish(grilled_chicken, chicken).

% Mixed Stir Fry 
dish(mixed_stir_fry, beef).
dish(mixed_stir_fry, broccoli).
dish(mixed_stir_fry, carrot).
dish(mixed_stir_fry, chicken).

% Chili 
dish(chili, beans).
dish(chili, beef).
dish(chili, yogurt).
dish(chili, cheese).

% Baked Salmon on Rice
dish(baked_salmon, salmon).
dish(baked_salmon, rice).

% Tofu Curry 
dish(tofu_curry, tofu).
dish(tofu_curry, rice).
dish(tofu_curry, carrot).

% Pizza 
dish(pizza, flour).
dish(pizza, cheese).

% Parfait 
dish(parfait, berries).
dish(parfait, oats).
dish(parfait, bananas).
dish(parfait, milk).
dish(parfait, yogurt).

% Cornmeal-crusted fish tacos
dish(cornmeal_fish_tacos, cornmeal).
dish(cornmeal_fish_tacos, salmon).
dish(cornmeal_fish_tacos, lettuce).
dish(cornmeal_fish_tacos, beans).
dish(cornmeal_fish_tacos, cheese). 

% Pasta Primavera 
dish(primavera, pasta).
dish(primavera, lettuce).
dish(primavera, spinach).
dish(primavera, broccoli).
dish(primavera, carrot).
dish(primavera, cheese).

% Avocado and Tomato Sandwich 
dish(avocado_tomato_sandwich, flour).
dish(avocado_tomato_sandwich, avocado).
dish(avocado_tomato_sandwich, tomatoes).
dish(avocado_tomato_sandwich, lettuce).
dish(avocado_tomato_sandwich, cheese).

% Veggie Fried Rice 
dish(veggie_fried_rice, rice).
dish(veggie_fried_rice, tofu).
dish(veggie_fried_rice, spinach).
dish(veggie_fried_rice, broccoli).
dish(veggie_fried_rice, carrot).
dish(veggie_fried_rice, tomatoes).

% Salmon and Avocado Sushi Rolls 
dish(salmon_avocado_roll, rice).
dish(salmon_avocado_roll, salmon).
dish(salmon_avocado_roll, avocado).

% Broccoli Casserole
dish(broccoli_casserole, broccoli).
dish(broccoli_casserole, cheese).
dish(broccoli_casserole, milk).
dish(broccoli_casserole, pasta).
dish(broccoli_casserole, spinach).

% Apple Salad
dish(apple_salad, apples).
dish(apple_salad, spinach).
dish(apple_salad, lettuce).

% Orange Beef Stir Fry
dish(orange_beef, beef).
dish(orange_beef, oranges).

% Banana Oat Pancakes
dish(banana_oat_pancakes, banana).
dish(banana_oat_pancakes, oats).
dish(banana_oat_pancakes, flour).
dish(banana_oat_pancakes, milk).

% Tofu Spring Rolls
dish(tofu_spring_rolls, tofu).
dish(tofu_spring_rolls, lettuce).
dish(tofu_spring_rolls, carrot).

% Fettucine Alfredo
dish(fettucine_alfredo, cheese).
dish(fettucine_alfredo, milk).
dish(fettucine_alfredo, pasta).

% spicy(gongpaochiken).
% sweet(gongpaochiken).
% sour(gongpaochiken).
% creamy(gongpaochiken).

ingredient(Ing, _) :- foodgroup(Ing, _).

foodgroup(flour, grains).
foodgroup(rice, grains).
foodgroup(oats, grains).
foodgroup(cornmeal, grains).
foodgroup(pasta, grains).

foodgroup(apples, fruits).
foodgroup(oranges, fruits).
foodgroup(bananas, fruits).
foodgroup(berries, fruits).
foodgroup(avocado, fruits).

foodgroup(lettuce, vegetables).
foodgroup(spinach, vegetables).
foodgroup(broccoli, vegetables).
foodgroup(carrot, vegetables).
foodgroup(tomatoes, vegetables).

foodgroup(chicken, protein).
foodgroup(beef, protein).
foodgroup(beans, protein).
foodgroup(salmon, protein).
foodgroup(tofu, protein).

foodgroup(milk, dairy).
foodgroup(cheese, dairy).
foodgroup(yogurt, dairy).

name(flour, "flour").
name(rice, "rice").
name(oats, "oats").
name(cornmeal, "cornmeal").
name(pasta, "pasta").

name(apples, "apples").
name(oranges, "oranges").
name(bananas, "bananas").
name(berries, "berries").
name(avocado, "avocado").

name(lettuce, "lettuce").
name(spinach, "spinach").
name(broccoli, "broccoli").
name(carrot, "carrot").
name(tomatoes, "tomatoes").

name(chicken, "chicken").
name(beef, "beef").
name(beans, "beans").
name(salmon, "salmon").
name(tofu, "tofu").

name(milk, "milk").
name(cheese, "cheese").
name(yogurt, "yogurt").



parseOption("1", Selections) :-
    pickIngredients(Selections).
parseOption("2", Ans) :-
    q(Ans).
parseOption(_, _) :-
    write('Invalid option.'),
    nl.

% Start here
start(Ans) :-
  write('Hello, trying to figure out what to cook?'),
  write('\nSelect a mode'),
  write('\n1. Pick Ingredients (Disjuctive)'),
  write('\n2. Provide your ingredients with a sentence (Conjunctive)'),
  nl,
  read_line_to_string(user_input, St),
  parseOption(St, Ans).


% Logical workflow for the disjunctive mode
pickIngredients(Selections) :-
    grainsQ(GrainsA),
    fruitsQ(FruitsA),
    veggiesQ(VeggiesA),
    proteinsQ(ProteinsA),
    dairyQ(DairyA),
    append([GrainsA, FruitsA, VeggiesA, ProteinsA, DairyA], Selections),
    write(Selections),
    maplist(findall(Dish, dish(Dish, Ingredient), Dishes), Selections, Dishes, []),
    write(Dishes).
    % TODO: This is not working yet!
    
grainsQ(GrainsA) :-
    write('Which grains do you have?'),
    write('\n1. flour'),
    write('\n2. rice'),
    write('\n3. oats'),
    write('\n4. cornmeal'),
    write('\n5. pasta'),
    write('\nEnter the grains you have, separated by commas (ex. rice, oats.)'),
    write('\nIf you have none, just press enter'),
    write('\n:'),
    read_line_to_string(user_input, Input),
    split_string(Input, ",", " .?!", GrainsA).

fruitsQ(FruitsA) :-
    write('Which fruits do you have?'),
    write('\n1. apples'),
    write('\n2. oranges'),
    write('\n3. bananas'),
    write('\n4. berries'),
    write('\n5. avocado'),
    write('\nEnter the fruits, separated by commas (ex. apples, berries):'),
    write('\nIf you have none, just press enter'),
    write('\n:'),
    read_line_to_string(user_input, Input),
    split_string(Input, ",", " .?!", FruitsA).

veggiesQ(VeggiesA) :-
    write('Which veggies do you have?'),
    write('\n1. lettuce'),
    write('\n2. spinach'),
    write('\n3. broccoli'),
    write('\n4. carrot'),
    write('\n5. tomatoes'),
    write('\nEnter the veggies, separated by commas (ex. lettuce, carrot):'),
    write('\nIf you have none, just press enter'),
    write('\n:'),
    read_line_to_string(user_input, Input),
    split_string(Input, ",", " .?!", VeggiesA).

proteinsQ(ProteinsA) :-
    write('Which proteins do you have?'),
    write('\n1. chicken'),
    write('\n2. beef'),
    write('\n3. beans'),
    write('\n4. salmon'),
    write('\n5. tofu'),
    write('\nEnter the proteins, separated by commas (ex. beef, tofu):'),
    write('\nIf you have none, just press enter'),
    write('\n:'),
    read_line_to_string(user_input, Input),
    split_string(Input, ",", " .?!", ProteinsA).

dairyQ(DairyA) :-
    write('Which dairy products do you have?'),
    write('\n1. milk'),
    write('\n2. cheese'),
    write('\n3. yogurt'),
    write('\nEnter the dairy products, separated by commas (ex. milk, yogurt):'),
    write('\nIf you have none, just press enter'),
    write('\n:'),
    read_line_to_string(user_input, Input),
    split_string(Input, ",", " .?!", DairyA).

% Logical workflow for the conjunctive mode
q(Ans) :-
    write("Ask me: "), 
    flush_output(current_output), 
    read_line_to_string(user_input, St), 
    split_string(St, " -", " ,?.!-", Ln), % ignore punctuation
    ask(Ln, Ans).
q(Ans) :-
    write("No more answers\n"),
    q(Ans).


% sample queries:
% ?- ask(["What", "can", "I", "cook", "with", "flour", "and", "berries"], A).

% Citations
% geography.pl from lecture
% https://www.swi-prolog.org/pldoc/man?predicate=maplist/4
% https://www.swi-prolog.org/pldoc/man?predicate=findall/3
% https://stackoverflow.com/questions/60571367/prolog-how-to-verify-user-input