:- dynamic lubi/1.
:- dynamic nielubi/1.
:- dynamic punkty/2.
:- dynamic koniec/1.
:- dynamic wybrana/2.
:-(clause(cechy(_),_); consult('baza.pl')).  

start:-
	nl,nl,
	jaka_ksiazka,
	read(Odp).
start:-
	wypisz_co_lubi.
start:-
	nl, wypisz_co_nie_lubi.
start:-
	funkcja_init.
start:-
	funkcja_licznik1.
start:-
	funkcja_licznik2.
start:-
	nl,funkcja_wypisz_pkt.
start:-
	funkcja_init_2.
start:-
	nl,funkcja.
start:-
	nl,funkcja2.


	
jaka_ksiazka:-
	cechy(X),					%sprawdza cechy 
	not(koniec(tak)),			%jezeli koniec to nie pojdzie dalej
	write('czy lubisz t/n/o/k '),
	write(X),nl,
	read(Odp),
	decyzja(Odp, X),
	nl, fail.

decyzja('t', X):-
	assertz(lubi(X)).
	
decyzja('n', X):-
	assertz(nielubi(X)).
	
decyzja('k', _):-
	assertz(koniec(tak)).
	
wypisz_co_lubi:-
	write('A wiêc lubisz:'),nl,
	lubi(X),
	write(X),
	nl,
	fail.
	
wypisz_co_nie_lubi:-
	write('Oraz nie lubisz:'),nl,
	nielubi(X),
	write(X),
	nl,
	fail.
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%	

funkcja_init:-
	cecha(Tytul, X),
	not(punkty(Tytul, _)),
	assertz(punkty(Tytul, 4)),
	fail.
	
funkcja_licznik1:-
	cecha(Tytul, X),
	lubi(X),
	punkty(Tytul, Pkt),
	Pkt_nowe is Pkt + 1,
	retract(punkty(Tytul, Pkt)),
	assertz(punkty(Tytul, Pkt_nowe)),
	fail.
	
funkcja_licznik2:-
	cecha(Tytul, X),
	nielubi(X),
	punkty(Tytul, Pkt),
	Pkt_nowe is Pkt - 1,
	retract(punkty(Tytul, Pkt)),
	assertz(punkty(Tytul, Pkt_nowe)),
	fail.
	
funkcja_wypisz_pkt:-
	punkty(Tytul, Pkt),
	write(Tytul), write(' '), write(Pkt), nl,
	fail.
	
funkcja_init_2:-
	punkty(wiedzmin, Pkt),
	assertz(wybrana(wiedzmin, Pkt)),
	fail.

funkcja:-
	punkty(Tytul, Pkt),
	wybrana(X, P),
	Pkt > P,
	retract(wybrana(X, P)),
	assertz(wybrana(Tytul, Pkt)),
	fail.
	
	
funkcja2:-
	wybrana(X, Y),
	write('Powinieneœ przeczytaæ '),
	write(X), write(', ksi¹¿ka ta zdoby³a '), write(Y),
	Procent is (Y*100)/8,
	write(' punktów. Na '), write(Procent), write('% Ci siê spodoba!'),
	nl,nl, halt.
	
	
	% swipl --goal=start --stand_alone=true -o ksiegarnia.exe -c ksiegarnia.pl
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	