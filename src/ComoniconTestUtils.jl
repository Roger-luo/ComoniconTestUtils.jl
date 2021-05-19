module ComoniconTestUtils

export @test_args, @test_kwargs, random_command

using Faker
using ComoniconTypes

const args = Ref{Vector{Any}}([])
const kwargs = Ref{Vector{Any}}([])

function test_function(xs...; kw...)
    args[] = [xs...]
    kwargs[] = collect(Any, kw)
    return 1
end

macro test_args(ex)
    quote
        @test $ComoniconTestUtils.args[] == $(ex)
    end |> esc
end

macro test_kwargs(ex)
    quote
        @test $ComoniconTestUtils.kwargs[] == $ex
    end |> esc
end

function random_command()
    options=Dict(
        "option-a" => Option(;
            sym=:option_a,
            type=Int,
            short=true,
            hint="int",
            description="option a." * Faker.text()
        ),
        "option-b" => Option(;
            sym=:option_b,
            type=Float64,
            hint="float64",
            description="option b." * Faker.text()
        ),
    )

    flags = Dict(
        "flag-a" => Flag(;sym=:flag_a, short=true, description="flag a." * Faker.text()),
        "flag-b" => Flag(;sym=:flag_b, short=true, description="flag b." * Faker.text()),
    )

    return CLIEntry(;
        version=v"1.2.0",
        root=NodeCommand(;
            name="cmd",
            description="node command." * Faker.text(),
            subcmds=Dict(
                "leaf-1" => LeafCommand(;
                    fn=test_function,
                    name="leaf-1",
                    description="leaf command 1. " * Faker.text(),
                    args=[
                        Argument(;name="a", description=Faker.text(;number_chars=20)),
                        Argument(;name="b", type=Int, description=Faker.text(;number_chars=20)),
                        Argument(;name="c", type=Float64, require=false, default="3.5", description=Faker.text(;number_chars=20)),
                        Argument(;name="d", type=String, require=false, description=Faker.text(;number_chars=20)),
                    ],
                    options,
                    flags,
                ),
                "leaf-2" => LeafCommand(;
                    fn=test_function,
                    name="leaf-2",
                    description="leaf command 2. " * Faker.text(),
                    vararg=Argument(;
                        name="xs",
                        type=Float64,
                        description=Faker.text(;number_chars=20),
                        vararg=true
                    ),
                    options,
                    flags,
                ),
                "leaf-3" => LeafCommand(;
                    fn=test_function,
                    name="leaf-3",
                    description="leaf command 3. " * Faker.text(),
                    options,
                    flags,
                )
            )
        )
    )
end


end
