% GUI SECTION %
:- use_module(library(pce)).
set_display :-
    getenv('DISPLAY', _), % Check if DISPLAY is already set
    !. % If so, do nothing
set_display :-
    process_create('sh', ['-c', 'export DISPLAY=154.5.139.248：8888'], []),
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

% PROGRAM LOGIC FLOW %
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
    grainsQ(GrainsA),
    fruitsQ(FruitsA),
    veggiesQ(VeggiesA),
    proteinsQ(ProteinsA),
    dairyQ(DairyA),
    max_list([GrainsA, FruitsA, VeggiesA, ProteinsA, DairyA], Upper),
    min_list([GrainsA, FruitsA, VeggiesA, ProteinsA, DairyA], Lower),
    random_between(Lower, Upper, Divisor),
    DishNumber is mod(31,Divisor),
    writeln("Based on your choices, I think you should make..."),
    dish(Recommendation, DishNumber).
    
grainsQ(GrainsA) :-
    write('Pick a grain!'),
    write('\n1. flour'),
    write('\n2. rice'),
    write('\n3. oats'),
    write('\n4. cornmeal'),
    write('\n5. pasta'),
    write('\nEnter your grain between 1-5: '),
    read(GrainsA).

fruitsQ(FruitsA) :-
    write('Now, pick a fruit!'),
    write('\n6. apples'),
    write('\n7. oranges'),
    write('\n8. banana'),
    write('\n9. berries'),
    write('\n10. avocado'),
    write('\nEnter your fruit between 6-10: '),
    read(FruitsA).

veggiesQ(VeggiesA) :-
    write('Now, pick a veggie!'),
    write('\n11. lettuce'),
    write('\n12. spinach'),
    write('\n13. broccoli'),
    write('\n14. carrot'),
    write('\n15. tomatoes'),
    write('\nEnter your veggie between 11-15: '),
    read(VeggiesA).

proteinsQ(ProteinsA) :-
    write('Now, pick a protein!'),
    write('\n16. chicken'),
    write('\n17. beef'),
    write('\n18. beans'),
    write('\n19. salmon'),
    write('\n20. tofu'),
    write('\nEnter your grain between 16-20: '),
    read(ProteinsA).

dairyQ(DairyA) :-
    write('Finally, pick a dairy product!'),
    write('\n21. milk'),
    write('\n22. cheese'),
    write('\n23. yogurt'),
    write('\nEnter your dairy product between 21-23: '),
    write('\n:'),
    read(DairyA).

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
