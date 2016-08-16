-module(elmer_runtime_test).

-include_lib("eunit/include/eunit.hrl").

calling_partially_applied_no_args_fun_test() ->
    Fun = fun () -> ok end,
    Partial = elmer_runtime:partial(Fun),
    ?assertEqual(ok, Partial([])).

should_fail_calling_partially_applied_no_args_fun_with_one_arg_test() ->
    Fun = fun () -> ok end,
    Partial = elmer_runtime:partial(Fun),
    ?assertException(error, _, Partial([1])).

calling_partially_applied_single_arg_fun_test() ->
    Fun = fun (X) -> X * 2 end,
    Double = elmer_runtime:partial(Fun),
    Four = Double([2]),
    ?assertEqual(4, Four).

calling_partially_applied_two_args_fun_test() ->
    Fun = fun (A, B) -> A + B end,
    First = elmer_runtime:partial(Fun),
    Second = First([1]),
    Three = Second([2]),
    ?assertEqual(3, Three).

fails_applying_no_args_to_partial_two_args_fun_test() ->
    Fun = fun (A, B) -> A + B end,
    Partial = elmer_runtime:partial(Fun),
    ?assertException(error, _, Partial([])).
