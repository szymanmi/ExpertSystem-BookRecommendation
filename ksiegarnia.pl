:- dynamic lubi/1.
:- dynamic nielubi/1.
:- dynamic punkty/2.
:- dynamic koniec/1.
:- dynamic wybrana/2.
:-(clause(cechy(_,_),_); consult('baza.pl')).  

start:-
	write('Witaj w aplikacji rekomenduj¹cej ksi¹¿ki, opowiedz mi coœ o swoich preferencjach.'), nl,
	write('Je¿eli lubisz dan¹ cechê ksi¹¿ki napisz "t", je¿eli nie lubisz napisz "n",'), nl,
	write('je¿eli jest ci to obojêtne napisz "o", a je¿eli znudzi ci siê odpowiadanie na'), nl,
	write('pytania wybierz k. W momencie zakoczenia odpowiadania na pytania wyœwietlona zostanie'),nl,
	write('ksi¹¿ka która z pewnoœci¹ spe³ni twoje oczekiwania.'),nl,
	write('----------------------------------------------------------------------------'),nl,
	jaka_ksiazka.
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
	funckja_uwzglednij_ocene.
start:-
	nl,funkcja_wypisz_pkt.
start:-
	funkcja_init_2.
start:-
	nl,wybierz_najlepsza.
start:-
	nl,wypisz_najlepsza.


	
jaka_ksiazka:-					
	cechy(X,Y),					%sprawdza cechy 
	not(koniec(tak)),			%jezeli koniec to nie pojdzie dalej
	write('Czy lubisz '), write(Y), write('?'), nl,
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
	ile_cech(Tytul, Ile),
	not(punkty(Tytul, _)),
	assertz(punkty(Tytul, Ile)),
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
	
funckja_uwzglednij_ocene:-
	ocena(Tytul, Mnoznik),
	punkty(Tytul, Pkt),
	Pkt_nowe is Pkt * Mnoznik,
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

wybierz_najlepsza:-
	punkty(Tytul, Pkt),
	wybrana(X, P),
	Pkt > P,
	retract(wybrana(X, P)),
	assertz(wybrana(Tytul, Pkt)),
	fail.
	
	
wypisz_najlepsza:-
	wybrana(X, Pkt),
	ksiazka(X, Nazwa),
	ile_cech(X, Cechy),
	write('Powinieneœ przeczytaæ '),
	write(Nazwa), 
	%write(', ksi¹¿ka/seria ta zdoby³a '), write(Pkt),
	%write(' na '), write(Cechy*2), write(' punktów.'), nl,
	Procent is (Pkt*100)/(Cechy*4),
	write('Na '), write(Procent), write('% Ci siê spodoba!'),
	nl,nl, halt.
	
	
	% swipl --goal=start --stand_alone=true -o ksiegarnia.exe -c ksiegarnia.pl
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	