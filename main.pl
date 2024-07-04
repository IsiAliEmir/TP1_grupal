/*                               TP1 Grupal - Eishofpdep

1) Modelar lo necesario para representar los jugadores, las civilizaciones y las tecnologías, 
de la forma más conveniente para resolver los siguientes puntos. Incluir los siguientes ejemplos.
    a. Ana, que juega con los romanos y ya desarrolló las tecnologías de herrería, forja, emplumado y láminas.
    b. Beto, que juega con los incas y ya desarrolló herrería, forja y fundición.
    c. Carola, que juega con los romanos y sólo desarrolló la herrería.
    d. Dimitri, que juega con los romanos y ya desarrolló herrería y fundición.
    e. Elsa no juega esta partida. */

:- discontiguous jugador/1.
:- discontiguous juegaCon/2.
:- discontiguous desarrollo/2.

jugador(ana).
jugador(beto).
jugador(carola).
jugador(dimitri).

civilizacion(romanos).
civilizacion(incas).

tecnologia(herreria).
tecnologia(forja).
tecnologia(emplumado).
tecnologia(laminas).
tecnologia(fundicion).

juegaCon(ana,romanos).
juegaCon(carola,romanos).
juegaCon(dimitri,romanos).
juegaCon(beto,incas).

desarrollo(ana,herreria).
desarrollo(ana,forja).
desarrollo(ana,emplumado).
desarrollo(ana,laminas).
desarrollo(beto,herreria).
desarrollo(beto,fundicion).
desarrollo(beto,forja).
desarrollo(carola,herreria).
desarrollo(dimitri,herreria).
desarrollo(dimitri,fundicion).

jugador(fulanito). % Para probar el punto 2).
juegaCon(fulanito,romanos).
desarrollo(fulanito,herreria).
desarrollo(fulanito,forja).
desarrollo(fulanito,fundicion).

/* 2) Saber si un jugador es experto en metales, que sucede cuando desarrolló las tecnologías de herrería, forja y:
o bien desarrolló fundición, o bien juega con los romanos. 
En los ejemplos, Ana y Beto son expertos en metales, pero Carola y Dimitri, no. */

esExpertoEnMetales(Jugador):-
    jugador(Jugador), % Es necesario esto?
    desarrollo(Jugador,herreria),
    desarrollo(Jugador,forja),
    desarrollo(Jugador,fundicion),
    not(juegaCon(Jugador,romanos)).

esExpertoEnMetales(Jugador):-
    jugador(Jugador), % Es necesario esto?
    juegaCon(Jugador,romanos),
    desarrollo(Jugador,herreria),
    desarrollo(Jugador,forja),
    not(desarrollo(Jugador,fundicion)).

/* 3) Saber si una civilización es popular, que se cumple cuando la eligen varios jugadores (más de uno).
En los ejemplos, los romanos son una civilización popular, pero los incas no. */

esPopular(Civilizacion):-
    civilizacion(Civilizacion), % Es necesario esto?
    juegaCon(Jugador1,Civilizacion),
    juegaCon(Jugador2,Civilizacion),
    Jugador1 \= Jugador2.

/* 4) Saber si una tecnología tiene alcance global, que sucede cuando a nadie le falta desarrollarla.
En los ejemplos, la herrería tiene alcance global, pues Ana, Beto, Carola y Dimitri la desarrollaron. */

tieneAlcanceGlobal(Tecnologia):-
    tecnologia(Tecnologia), % Es necesario esto?
    forall(jugador(Jugador),desarrollo(Jugador,Tecnologia)).

/* 5) Saber cuándo una civilización es líder. Se cumple cuando esa civilización alcanzó todas las tecnologías 
que alcanzaron las demás. Una civilización alcanzó una tecnología cuando algún jugador de esa civilización la 
desarrolló. En los ejemplos, los romanos son una civilización líder pues entre Ana y Dimitri, que juegan con 
romanos, ya tienen todas las tecnologías que se alcanzaron. */

esLider(Civilizacion):-
    civilizacion(Civilizacion),
    forall(
        (civilizacion(Civilizacion2), Civilizacion2 \= Civilizacion, alcanzo(Civilizacion2,Tecnologia)),
        alcanzo(Civilizacion,Tecnologia)
    ).

alcanzo(Civilizacion,Tecnologia):-
    juegaCon(Jugador,Civilizacion),
    desarrollo(Jugador,Tecnologia).

/* OTRA VERSION */ 

tecnologiaAlcanzada(Tecnologia):-
    desarrollo(_,Tecnologia).

esLiderr(Civilizacion):-
    civilizacion(Civilizacion),
    forall(
        tecnologiaAlcanzada(Tecnologia), 
        (juegaCon(Jugador,Civilizacion), desarrollo(Jugador,Tecnologia))
    ).