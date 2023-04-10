% GUI SECTION %
:- use_module(library(pce)).
set_display :-
    getenv('DISPLAY', _), % Check if DISPLAY is already set
    !. % If so, do nothing
set_display :-
    process_create('sh', ['-c', 'export DISPLAY=154.5.139.248�888'], []),
    setenv('DISPLAY', '154.5.139.248:0').

collect(Query) :-
    new(D, dialog('Cook Recommendation System')),
    send(D, append(new(Label, label))),
    send(Label, value('Hello, trying to figure out what to cook?
    \nProvide your ingredients with a sentence (Conjunctive)
    \nSample: What can I cook with cheese and pasta?')),

    send(D, append(new(NameItem, text_item(query)))),
    send(D, append(button(ok, message(D, return,
                                    NameItem?selection)))),
    send(D, append(button(cancel, message(D, return, @nil)))),
    send(D, default_button(ok)),
    get(D, confirm, Rval),
    free(D),
    Rval \== @nil,
    split_string(Rval, " -" ,"?.!-", Query).

% NLP SECTION%
% Parse a valid formatted sentence.
parse_sentence(L0, L5, Ind) :-
    subject(L0, L1, Ind),
    verb(L1, L2, Ind),
    prep(L2, L3, Ind),
    end(L3, L4, Ind),
    nouns(L4, L5, Ind).

% Definitions for various sentence components
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


% DATABASE OF FACTS TO BE QUERIED %
% Pancakes
dish(pancakes, flour).
dish(pancakes, milk).
dish(pancakes, 0).

% Oatmeal Cookies
dish(oatmeal_cookies, oats).
dish(oatmeal_cookies, flour).
dish(oatmeal_cookies, 1).

% Cornbread
dish(cornbread, flour).
dish(cornbread, cornmeal).
dish(cornbread, 2).

% Spaghetti Carbonara
dish(spaghetti_carbonara, pasta).
dish(spaghetti_carbonara, cheese).
dish(spaghetti_carbonara, 3).

% Apple Crisp
dish(apple_crisp, apples).
dish(apple_crisp, flour).
dish(apple_crisp, 4).

% Orange chicken
dish(orange_chicken, oranges).
dish(orange_chicken, chicken).
dish(orange_chicken, 5).

% Banana Bread
dish(banana_bread, banana).
dish(banana_bread, flour).
dish(banana_bread, 6).

% Smoothie
dish(smoothie, banana).
dish(smoothie, apples).
dish(smoothie, oranges).
dish(smoothie, berries).
dish(smoothie, avocado).
dish(smoothie, milk).
dish(smoothie, yogurt).
dish(smoothie, 7).

% avocado Toast
dish(avocado_toast, avocado).
dish(avocado_toast, cheese).
dish(avocado_toast, 8).

% Caesar Salad
dish(caesar_salad, lettuce).
dish(caesar_salad, cheese).
dish(caesar_salad, 9).

% Stuffed chicken
dish(stuffed_chicken, chicken).
dish(stuffed_chicken, cheese).
dish(stuffed_chicken, spinach).
dish(stuffed_chicken, 10).

% Veggie Soup
dish(veggie_soup, broccoli).
dish(veggie_soup, carrot).
dish(veggie_soup, tomatoes).
dish(veggie_soup, beans).
dish(veggie_soup, 11).

% Grilled chicken
dish(grilled_chicken, chicken).
dish(grilled_chicken, 12).

% Mixed Stir Fry
dish(mixed_stir_fry, beef).
dish(mixed_stir_fry, broccoli).
dish(mixed_stir_fry, carrot).
dish(mixed_stir_fry, chicken).
dish(mixed_stir_fry, 13).

% Chili
dish(chili, beans).
dish(chili, beef).
dish(chili, yogurt).
dish(chili, cheese).
dish(chili, 14).

% Baked salmon on rice
dish(baked_salmon, salmon).
dish(baked_salmon, rice).
dish(baked_salmon, 15).

% tofu Curry
dish(tofu_curry, tofu).
dish(tofu_curry, rice).
dish(tofu_curry, carrot).
dish(tofu_curry, 16).

% Pizza
dish(pizza, flour).
dish(pizza, cheese).
dish(pizza, 17).

% Parfait
dish(parfait, berries).
dish(parfait, oats).
dish(parfait, banana).
dish(parfait, milk).
dish(parfait, yogurt).
dish(parfait, 18).

% cornmeal-crusted fish tacos
dish(cornmeal_fish_tacos, cornmeal).
dish(cornmeal_fish_tacos, salmon).
dish(cornmeal_fish_tacos, lettuce).
dish(cornmeal_fish_tacos, beans).
dish(cornmeal_fish_tacos, cheese).
dish(cornmeal_fish_tacos, 19).

% pasta Primavera
dish(primavera, pasta).
dish(primavera, lettuce).
dish(primavera, spinach).
dish(primavera, broccoli).
dish(primavera, carrot).
dish(primavera, cheese).
dish(primavera, 20).

% Avocado and Tomato Sandwich
dish(avocado_tomato_sandwich, flour).
dish(avocado_tomato_sandwich, avocado).
dish(avocado_tomato_sandwich, tomatoes).
dish(avocado_tomato_sandwich, lettuce).
dish(avocado_tomato_sandwich, cheese).
dish(avocado_tomato_sandwich, 21).

% Veggie Fried rice
dish(veggie_fried_rice, rice).
dish(veggie_fried_rice, tofu).
dish(veggie_fried_rice, spinach).
dish(veggie_fried_rice, broccoli).
dish(veggie_fried_rice, carrot).
dish(veggie_fried_rice, tomatoes).
dish(veggie_fried_rice, 22).

% Salmon and avocado Sushi Rolls
dish(salmon_avocado_roll, rice).
dish(salmon_avocado_roll, salmon).
dish(salmon_avocado_roll, avocado).
dish(salmon_avocado_roll, 23).

% Broccoli Casserole
dish(broccoli_casserole, broccoli).
dish(broccoli_casserole, cheese).
dish(broccoli_casserole, milk).
dish(broccoli_casserole, pasta).
dish(broccoli_casserole, spinach).
dish(broccoli_casserole, 24).

% Apple Salad
dish(apple_salad, apples).
dish(apple_salad, spinach).
dish(apple_salad, lettuce).
dish(apple_salad, 25).

% Orange beef Stir Fry
dish(orange_beef, beef).
dish(orange_beef, oranges).
dish(orange_beef, 27).

% Banana Oat Pancakes
dish(banana_oat_pancakes, banana).
dish(banana_oat_pancakes, oats).
dish(banana_oat_pancakes, flour).
dish(banana_oat_pancakes, milk).
dish(banana_oat_pancakes, 28).

% Tofu Spring Rolls
dish(tofu_spring_rolls, tofu).
dish(tofu_spring_rolls, lettuce).
dish(tofu_spring_rolls, carrot).
dish(tofu_spring_rolls, 29).

% Fettucine Alfredo
dish(fettucine_alfredo, pasta).
dish(fettucine_alfredo, cheese).
dish(fettucine_alfredo, milk).
dish(fettucine_alfredo, pasta).
dish(fettucine_alfredo, 30).

% Name facts for every dish
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

% PROGRAM LOGIC FLOW BASED ON USER MODE INPUT %
parseOption("1", Recommendation) :-
    pickIngredients(Recommendation).
parseOption("2", Ans) :-
    collect(Query),
    ask(Query, Ans).
parseOption(_, Ans) :-
    write('Invalid Option.\n'),
    start(Ans).

% Start here
start(Ans) :-
  write('Hello, trying to figure out what to cook?'),
  write('\nSelect a mode'),
  write('\n1. Surprise Me! (Random Buzzfeed Quiz Style)'),
  write('\n2. Provide your ingredients with a sentence (Conjunctive)'),
  nl,
  read_line_to_string(user_input, St),
  parseOption(St, Ans). 

% Logical workflow for the random mode
pickIngredients(Recommendation) :-
  % Ask the user to choose one food item from each category
  grainsQ(GrainsA),
  fruitsQ(FruitsA),
  veggiesQ(VeggiesA),
  proteinsQ(ProteinsA),
  dairyQ(DairyA),
  atom_number(GrainsA, X1),
  atom_number(FruitsA, X2),
  atom_number(VeggiesA, X3),
  atom_number(ProteinsA, X4),
  atom_number(DairyA, X5),
  max_list([X1,X2,X3,X4,X5], Upper), % get the max value user entered
  min_list([X1,X2,X3,X4,X5], Lower), % get the min value user entered
  random_between(Lower, Upper, Divisor), % get random number between the values
  DishNumber is mod(31,Divisor), % pick a random dish based on the above number out of the 30 dishes
  writeln("Based on your choices, I think you should make..."),
  dish(Recommendation, DishNumber).

% Asks the user to pick a grain
grainsQ(GrainsA) :-
  new(D, dialog('Cook Recommendation System')),
  send(D, append(new(Label, label))),
  send(Label, value('Hello, trying to figure out what to cook?
  \nPick a grain: 1. flour 2. rice 3. oats 4. cornmeal 5. pasta
  \nEnter your grain between 1-5: ')),
  send(D, append(new(NameItem, text_item(query)))),
  send(D, append(button(ok, message(D, return, NameItem?selection)))),
  send(D, append(button(cancel, message(D, return, @nil)))),
  send(D, default_button(ok)),
  get(D, confirm, GrainsA),
  free(D),
  atom_number(GrainsA, X),
  X > 1-1,
  X < 5+1,			
  GrainsA \== @nil.

% Asks the user to pick a fruit
fruitsQ(FruitsA) :-
  new(D, dialog('Cook Recommendation System')),
  send(D, append(new(Label, label))),
  send(Label, value('Now, pick a fruit!\n6. apples\n7. oranges\n8. banana\n9. berries\n10. avocado\nEnter your fruit between 6-10: ')),
  send(D, append(new(NameItem, text_item(query)))),
  send(D, append(button(ok, message(D, return, NameItem?selection)))),
  send(D, append(button(cancel, message(D, return, @nil)))),
  send(D, default_button(ok)),
  get(D, confirm, FruitsA),
  free(D),
  atom_number(FruitsA, X),
  X > 6-1,
  X < 10+1,			
  FruitsA \== @nil.

% Asks the user to pick a veggie
veggiesQ(VeggiesA) :-
  new(D, dialog('Cook Recommendation System')),
  send(D, append(new(Label, label))),
  send(Label, value('Now, pick a veggie!\n11. lettuce\n12. spinach\n13. broccoli\n14. carrot\n15. tomatoes\nEnter your veggie between 11-15: ')),
  send(D, append(new(NameItem, text_item(query)))),
  send(D, append(button(ok, message(D, return, NameItem?selection)))),
  send(D, append(button(cancel, message(D, return, @nil)))),
  send(D, default_button(ok)),
  get(D, confirm, VeggiesA),
  free(D),
  atom_number(VeggiesA, X),
  X > 11-1,
  X < 15+1,			
  VeggiesA \== @nil.

% Asks the user to pick a protein
proteinsQ(ProteinsA) :-
  new(D, dialog('Cook Recommendation System')),
  send(D, append(new(Label, label))),
  send(Label, value('Now, pick a protein!\n16. chicken\n17. beef\n18. beans\n19. salmon\n20. tofu\nEnter your grain between 16-20: ')),
  send(D, append(new(NameItem, text_item(query)))),
  send(D, append(button(ok, message(D, return, NameItem?selection)))),
  send(D, append(button(cancel, message(D, return, @nil)))),
  send(D, default_button(ok)),
  get(D, confirm, ProteinsA),
  free(D),
  atom_number(ProteinsA, X),
  X > 16-1,
  X < 20+1,			
  ProteinsA \== @nil.

% Asks the user to pick a dairy product
dairyQ(DairyA) :-
  new(D, dialog('Cook Recommendation System')),
  send(D, append(new(Label, label))),
  send(Label, value('Finally, pick a dairy product!\n21. milk\n22. cheese\n23. yogurt\nEnter your dairy product between 21-23: ')),
  send(D, append(new(NameItem, text_item(query)))),
  send(D, append(button(ok, message(D, return, NameItem?selection)))),
  send(D, append(button(cancel, message(D, return, @nil)))),
  send(D, default_button(ok)),
  get(D, confirm, DairyA),
  free(D),
  atom_number(DairyA, X),
  X > 21-1,
  X < 23+1,			
  DairyA \== @nil.

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

% Citations, some used in previous ideas that were scrapped
% geography.pl from lecture
% https://www.swi-prolog.org/pldoc/man?predicate=bagof/3
% https://www.swi-prolog.org/pldoc/man?predicate=maplist/3
% https://www.swi-prolog.org/pldoc/man?predicate=findall/3
% https://www.swi-prolog.org/pldoc/man?predicate=max_list/2
% https://www.swi-prolog.org/pldoc/man?predicate=min_list/2
% https://www.swi-prolog.org/pldoc/man?predicate=random_between/3
% https://stackoverflow.com/questions/39435709/how-to-remove-duplicates-from-a-list-in-swi-prolog
% https://stackoverflow.com/questions/60571367/prolog-how-to-verify-user-input
% https://www.swi-prolog.org/packages/xpce/examples.html
% https://www.cs.ubc.ca/~poole/cs312/2023/prolog/geography_string.pl