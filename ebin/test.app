{application, test,
[{description, "test for lib_chan"},
{vsn, "0.1.0"},
{modules,[test, lib_chan,mod_test_server]},
{application, [kernel, stdlib]},
{mod, {test,[]}}
]}.
