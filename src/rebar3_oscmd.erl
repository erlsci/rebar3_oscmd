-module(rebar3_oscmd).

-export([init/1]).

-ignore_xref([init/1]).

-spec init(rebar_state:t()) -> {ok, rebar_state:t()}.
init(State) ->
    {ok, State1} = r3_oscmd_prv:init(State),
    {ok, State1}.
