using SymKit 
using Test


@testset "Simple Operations" begin
    x, y = @sym x y

    expr = x + y 
    @test expr isa BinaryOp
    @test expr.op == :+
end