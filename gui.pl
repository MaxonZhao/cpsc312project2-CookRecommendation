:- use_module(library(pce)).

% Define GUI components
:- pce_begin_class(my_button, button).

variable(parent,  any*, both, "Parent window").
variable(message, any*, both, "Message to display").

initialise(B, Parent: frame, Label: name = [name], Message: [any] = 'Hello, Prolog!') :->
    "Create my_button object"::
    send_super(B, initialise(Label)),
    send(B, attribute, parent, Parent),
    send(B, attribute, message, Message),
    send(B, on_left_down, message(@prolog, display_message, B)).

display_message(B) :->
    "Display message in a new dialog"::
    get(B, parent, Parent),
    get(B, message, Message),
    new(D, dialog(Parent, 'Message')),
    send(D, append, text(Message)),
    send(D, append, button(ok, message(D, destroy))),
    send(D, open).

:- pce_end_class.

% Create and display the GUI
main :->
    "Create and display main window"::
    new(Main, frame('Prolog GUI Example')),
    new(Button, my_button(Main, 'Click me!')),
    send(Main, append, Button),
    send(Main, open).

% Start the GUI when Prolog is loaded
:- initialization(main).
