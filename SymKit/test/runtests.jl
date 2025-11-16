using SymKit 
using Test


@testset "Simple Operations" begin
    x = @sym x 
    y = @sym y 

    expr = x + y 
    @test expr isa BinaryOp
    @test expr.op == :+
end