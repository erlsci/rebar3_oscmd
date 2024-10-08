-module(rebar3_oscmd_SUITE).

-include_lib("stdlib/include/assert.hrl").

-compile(export_all).

-define(CONFIG, [
    not_tuple,
    {tuple_1},
    {tuple_4, "ls", [], four},
    {timeout_0, "ls", [{timeout, 0}]},
    {timeout_1999, "sleep 2", [{timeout, 1999}]},
    {non_verbose_ls, "ls", [{verbose, false}]},
    {verbose_ls, "ls", [{verbose, true}]},
    {not_string, 2},
    {timeout_not_int, "ls", [{timeout, a}]},
    {ok, "ls", [{timeout, 2500}, verbose]}
]).

all() ->
    [
        command_not_atom,
        command_tuple_1,
        command_tuple_4,
        command_not_in_commands,
        command_timeout_0,
        command_timeout_1999,
        command_verbose_false,
        command_verbose_true,
        command_not_string,
        command_timeout_not_integer,
        command_ok
    ].

command_not_atom(_Config) ->
    {Cmd, CmdFound} = as_rebar3_oscmd(not_tuple, _FoundInSuiteConfig = true),
    ?assertMatch(
        {error, _},
        r3_oscmd_prv:do_internal({Cmd, CmdFound}, no_state)
    ).

command_tuple_1(_Config) ->
    {Cmd, CmdFound} = as_rebar3_oscmd(tuple_1, _FoundInSuiteConfig = true),
    ?assertMatch(
        {error, _},
        r3_oscmd_prv:do_internal({Cmd, CmdFound}, no_state)
    ).

command_tuple_4(_Config) ->
    {Cmd, CmdFound} = as_rebar3_oscmd(tuple_4, _FoundInSuiteConfig = true),
    ?assertMatch(
        {error, _},
        r3_oscmd_prv:do_internal({Cmd, CmdFound}, no_state)
    ).

command_not_in_commands(_Config) ->
    {Cmd, CmdFound} = as_rebar3_oscmd(not_in_commands, _FoundInSuiteConfig = false),
    ?assertMatch(
        {error, _},
        r3_oscmd_prv:do_internal({Cmd, CmdFound}, no_state)
    ).

command_timeout_0(_Config) ->
    {Cmd, CmdFound} = as_rebar3_oscmd(timeout_0, _FoundInSuiteConfig = true),
    ?assertMatch(
        {error, _},
        r3_oscmd_prv:do_internal({Cmd, CmdFound}, no_state)
    ).

command_timeout_1999(_Config) ->
    {Cmd, CmdFound} = as_rebar3_oscmd(timeout_1999, _FoundInSuiteConfig = true),
    ?assertMatch(
        {error, _},
        r3_oscmd_prv:do_internal({Cmd, CmdFound}, no_state)
    ).

command_verbose_false(_Config) ->
    {Cmd, CmdFound} = as_rebar3_oscmd(non_verbose_ls, _FoundInSuiteConfig = true),
    ?assertMatch(
        {ok, no_state},
        r3_oscmd_prv:do_internal({Cmd, CmdFound}, no_state)
    ).

command_verbose_true(_Config) ->
    {Cmd, CmdFound} = as_rebar3_oscmd(verbose_ls, _FoundInSuiteConfig = true),
    ?assertMatch(
        {ok, no_state},
        r3_oscmd_prv:do_internal({Cmd, CmdFound}, no_state)
    ).

command_not_string(_Config) ->
    {Cmd, CmdFound} = as_rebar3_oscmd(not_string, _FoundInSuiteConfig = true),
    ?assertEqual(
        {ok, no_state},
        r3_oscmd_prv:do_internal({Cmd, CmdFound}, no_state)
    ).

command_timeout_not_integer(_Config) ->
    {Cmd, CmdFound} = as_rebar3_oscmd(timeout_not_int, _FoundInSuiteConfig = true),
    ?assertMatch(
        {ok, no_state},
        r3_oscmd_prv:do_internal({Cmd, CmdFound}, no_state)
    ).

command_ok(_Config) ->
    {Cmd, CmdFound} = as_rebar3_oscmd(ok, _FoundInSuiteConfig = true),
    ?assertMatch(
        {ok, no_state},
        r3_oscmd_prv:do_internal({Cmd, CmdFound}, no_state)
    ).

%% Internal

as_rebar3_oscmd(Cmd, FoundInSuiteConfig) ->
    FoundInSuiteConfig andalso
        begin
            true =
                lists:keyfind(Cmd, 1, ?CONFIG) =/= false orelse
                    lists:member(Cmd, ?CONFIG)
        end,
    {atom_to_list(Cmd), r3_oscmd_prv:find_command_in(atom_to_list(Cmd), ?CONFIG)}.
