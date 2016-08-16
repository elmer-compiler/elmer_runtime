-module(elmer_runtime).

-export([
         partial/1
        ]).

partial(Fun) when is_function(Fun, 0) ->
    fun ([]) -> Fun() end;

partial(Fun) when is_function(Fun, 1) ->
    fun ([A]) -> Fun(A) end;

partial(Fun) when is_function(Fun) ->
    {arity, Arity} = erlang:fun_info(Fun, arity),
    partial(Fun, Arity, []).

partial(Fun, Arity, Args) when Arity > length(Args) ->
    fun (MoreArgs) when length(Args) + length(MoreArgs) == Arity ->
            apply(Fun, Args ++ MoreArgs);
        (MoreArgs) when length(MoreArgs) > 0 ->
            partial(Fun, Arity, Args ++ MoreArgs)
    end.


