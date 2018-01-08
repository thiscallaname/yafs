-module(test).
-behavior(gen_server).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, code_change/3,
    terminate/2]).

-export([start/0, store/2, lookup/1]).
%% API
start() ->
    gen_server:start({local, ?MODULE}, ?MODULE, [], []).


store(Key, Value) ->
    gen_server:call(?MODULE, {store, Key, Value}).

lookup(Key) ->
    gen_server:call(?MODULE, {lookup, Key}).

stop() ->
    terminate().
%% gen_server callbacks
init([]) ->
        {ok, []}.

handle_call({store, Key, Value}, _From, State) ->
    {reply, true, [{Key, Value}|State]};

handle_call({lookup, Key}, _From, State) ->
    {Flag, Value} =
        case lists:keyfind(Key, 1, State) of
            false ->
                {false, undefine};
            V ->
                {ok, V}
        end,
    {reply, {Flag, Value}, State};

handle_call(_Msg, _From, State) ->
    {noreply, State}.

handle_cast(_Request, State) ->
    {noreply, State}.

handle_info(Info, State) ->
    io:format("~w: ~w~n", [erlang:node(), Info]),
    {noreply, State}.

code_change(_OldVsn, _Extra, State) ->
    {ok, State}.

terminate(_Reason, _State) ->
    ok.
