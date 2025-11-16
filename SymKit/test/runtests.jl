using SymKit 
using Test


@testset "Simple Operations" begin
    x, y = @sym x y

    expr = x + y
    @test expr isa BinaryOp
    @test expr.op == :+
end

@testset "Simplification" begin
    @sym x y

    # Test constant folding
    @test Simplify(Const(2) + Const(3)) == Const(5)
    @test Simplify(Const(5) * Const(2)) == Const(10)
    @test Simplify(Const(2) ^ Const(3)) == Const(8)

    # Test identity rules
    @test Simplify(x + Const(0)) == x
    @test Simplify(Const(0) + x) == x
    @test Simplify(x * Const(1)) == x
    @test Simplify(Const(1) * x) == x
    @test Simplify(x ^ Const(0)) == Const(1)
    @test Simplify(x ^ Const(1)) == x
    @test Simplify(x - Const(0)) == x
    @test Simplify(x / Const(1)) == x

    # Test complex expressions
    @test Simplify((Const(2) + Const(3)) * x) == (Const(5) * x)
    @test Simplify(x * Const(0)) == Const(0)

    # Test double negation
    @test Simplify(-(-x)) == x
end