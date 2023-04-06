

% A noun phrase is a subjective followed by verb followed 
% preposition followed by a noun...
noun_phrase(L0, L4, Ind) :-
    subject(L0, L1, Ind), 
    verb(L1, L2, Ind),
    prep(L2, L3, Ind),
    noun(L3, L4, Ind).


subject(["I" | L], L, _).
verb(["cook" | L], L, Ind) :- dish(Ind).
verb(["make" | L], L, Ind) :- dish(Ind).

prep(["with" | L], L, _).

noun([IngName | L], L, Ind) :- ingridient(Ing, Ind), name(Ing, IngName).





% question(Question, QR, Ind) is true if Ind is  an answer to Question
question(["What", "can" | L0], L1, Ind) :- 
    noun_phrase(L0, L1, Ind).



% ask(Q, A) gives answer A to question Q
ask(Q, A) :- 
    question(Q, [], A).


% The Database of Facts to be Queried
dish(gongpaochicken).

% spicy(gongpaochiken).
% sweet(gongpaochiken).
% sour(gongpaochiken).
% creamy(gongpaochiken).

ingridient(Ing, _) :- foodgroup(Ing, _).

foodgroup(wheatflour, grains).
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
foodgroup(brocoli, vegetables).
foodgroup(carrot, vegetables).
foodgroup(tomatoes, vegetables).


foodgroup(chickenbreast, protein).
foodgroup(beef, protein).
foodgroup(beans, protein).
foodgroup(salmon, protein).
foodgroup(tofu, protein).

foodgroup(milk, dairy).
foodgroup(cheese, dairy).
foodgroup(yogurt, dairy).

name(wheatflour, "wheat flour").
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
name(brocoli, "brocoli").
name(carrot, "carrot").
name(tomatoes, "tomatoes").

name(chickenbreast, "chicken breast").
name(beef, "beef").
name(beans, "beans").
name(salmon, "salmon").
name(tofu, "tofu").

name(milk, "milk").
name(cheese, "cheese").
name(yogurt, "yogurt").

% sample queries:
% ?- ask(["What", "can", "I", "cook", "with", "brocoli"], A).
