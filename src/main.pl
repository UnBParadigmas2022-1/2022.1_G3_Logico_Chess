:- consult(menu).


main :-
    showMenu(),
    menuOption(Option),
    format('Opcao escolhida: ~d\n', Option).