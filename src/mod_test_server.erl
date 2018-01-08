-module(mod_test_server).
-export([start/1]).

start(MM,  _ArgsC, _ArgS) ->
    loop(MM).

loop(MM) ->
    receive 
        {chan, MM, {store, K, V}} ->
            test:store(K,V),
            loop(MM);
        {chan, MM, {lookup, K}} ->
            MM ! {send, test:lookup(K)},
            loop(MM);
        {chan_closed, MM} ->
            true
    end.