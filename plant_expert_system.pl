% ==============================================
% 🌿 PLANT EXPERT SYSTEM (with HTTP API)
% ----------------------------------------------
% Run:  swipl plant_expert_system.pl
% Then open: http://localhost:8080
% ==============================================

:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_json)).
:- use_module(library(http/http_parameters)).
:- use_module(library(http/html_write)).
:- dynamic known/2.

% HTTP endpoint
:- http_handler(root(recommend), recommend_handler, []).
:- http_handler(root(.), serve_frontend, []).

% ----------------------------------------------
% Start Server
% ----------------------------------------------
server(Port) :-
    http_server(http_dispatch, [port(Port)]).

:- initialization(server(8080)).

serve_frontend(Request) :-
    http_reply_file('index.html', [], Request).

:- multifile http:location/3.
:- dynamic   http:location/3.

http:location(css, root(css), []).
:- http_handler(css(.), http_reply_from_files('', []), [prefix]).
         
% ----------------------------------------------
% Rule Base
% ----------------------------------------------

rule('Sweet Flag') :-
    ease_of_care(easy),
    toxicity(toxic),
    lighting(medium),
    watering('1 times/week').

rule('Ox Tongue') :-
    lighting(low),
    toxicity('non toxic'),
    watering('3 times/week').

rule('Slipperwort') :-
    watering('1 times/week'),
    ease_of_care(easy).

rule('Ponytail') :-
    watering('3 times/week'),
    ease_of_care(difficult),
    toxicity('non toxic'),
    lighting(low).

rule('Brevifolia Aloe') :-
    watering('3 times/week'),
    ease_of_care(difficult),
    toxicity('non toxic'),
    lighting(high).

rule('Powder Puff') :-
    watering('3 times/week'),
    ease_of_care(difficult),
    toxicity('non toxic'),
    lighting(low).

rule('Scarlet Star') :-
    watering('3 times/week'),
    ease_of_care(difficult),
    toxicity('non toxic'),
    lighting(low).

rule('Philodendron Pertusum') :-
    watering('2 times/week'),
    ease_of_care(average),
    toxicity('non toxic'),
    lighting(low).

rule('Little Tree Cactus') :-
    watering('3 times/week'),
    ease_of_care(difficult),
    toxicity('non toxic'),
    lighting(low).

rule('Pigmy Date Palm') :-
    watering('2 times/week'),
    ease_of_care(average),
    toxicity('non toxic'),
    lighting(low).

rule('Nephthytis') :-
    watering('2 times/week'),
    ease_of_care(average),
    toxicity('non toxic'),
    lighting(medium).

rule('Wandering Jew') :-
    watering('2 times/week'),
    ease_of_care(average),
    toxicity('non toxic'),
    lighting(high).

% Derived rules for ease of care
ease_of_care(easy) :- watering('1 times/week').
ease_of_care(average) :- watering('2 times/week').
ease_of_care(difficult) :- watering('3 times/week').

% ----------------------------------------------
% Facts from JSON memory
% ----------------------------------------------

set_attribute(Name, Value) :-
    retractall(known(Name,_)),
    assertz(known(Name, Value)).

watering(Value) :- known(watering, Value).
lighting(Value) :- known(lighting, Value).
toxicity(Value) :- known(toxicity, Value).
ease_of_care(Value) :- known(ease_of_care, Value).

% ----------------------------------------------
% Recommendation logic
% ----------------------------------------------

recommend(CommonName) :-
    rule(CommonName), !.
recommend('No matching plant found.').

recommend_handler(Request) :-
    http_parameters(Request, [
        watering(Water, []),
        lighting(Light, []),
        toxicity(Tox, []),
        ease(Ease, [])
    ]),
    clear_memory,
    set_attribute(watering, Water),
    set_attribute(lighting, Light),
    set_attribute(toxicity, Tox),
    set_attribute(ease_of_care, Ease),
    (recommend(Result) -> true ; Result = 'No match found'),
    reply_json_dict(_{recommendation: Result}).

clear_memory :- retractall(known(_,_)).

