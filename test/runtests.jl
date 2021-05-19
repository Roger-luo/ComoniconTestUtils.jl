using ComoniconTestUtils
using Test

@testset "ComoniconTestUtils.jl" begin
    ComoniconTestUtils.test_function("a", "b", "c"; option_a=1, option_b=2)
    @test_args ["a", "b", "c"]
    @test_kwargs [:option_a=>1, :option_b=>2]    
end
