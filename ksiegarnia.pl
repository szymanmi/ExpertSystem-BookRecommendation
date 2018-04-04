:- dynamic lubi/1.
:- dynamic nielubi/1.
:- dynamic punkty/2.
:- dynamic koniec/1.
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
	funkcja_licznik.
start:-
	nl,funkcja_wypisz_pkt.

jaka_ksiazka:-
	cechy(X),					%sprawdza cechy 
	not(koniec(tak)),			%jezeli koniec to nie pojdzie dalej
	write('czy lubisz t/n/k '),
	write(X),nl,
	read(Odp),
	decyzja(Odp, X),
	nl, fail.

decyzja('t', X):-
	assertz(lubi(X)).
	
decyzja('n', X):-
	assertz(nielubi(X)).
	
decyzja('k', X):-
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
	assertz(punkty(Tytul, 0)),
	fail.
	
funkcja_licznik:-
	cecha(Tytul, X),
	lubi(X),
	punkty(Tytul, Pkt),
	Pkt_nowe is Pkt + 1,
	retract(punkty(Tytul, Pkt)),
	assertz(punkty(Tytul, Pkt_nowe)),
	fail.
	
funkcja_wypisz_pkt:-
	punkty(Tytul, Pkt),
	write(Tytul), write(' '), write(Pkt), nl,
	fail.
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	