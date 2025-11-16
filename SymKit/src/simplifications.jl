# Internal helper function - applies one simplification rule
function simplify_once(expr::SymExpr)
    # Base cases: Sym and Const are already simplified
    expr isa Sym && return expr
    expr isa Const && return expr

    # Simplify UnaryOp
    expr isa UnaryOp && return simplify_unary(expr)

    # Simplify BinaryOp
    expr isa BinaryOp && return simplify_binary(expr)

    return expr
end

# Simplify unary operations
function simplify_unary(expr::UnaryOp)
    arg = simplify_once(expr.arg)

    # Double negation: -(-x) = x
    if expr.op == :- && arg isa UnaryOp && arg.op == :-
        return arg.arg
    end

    return UnaryOp(expr.op, arg)
end

# Simplify binary operations
function simplify_binary(expr::BinaryOp)
    left = simplify_once(expr.left)
    right = simplify_once(expr.right)

    # Constant folding: if both sides are constants, compute the result
    if left isa Const && right isa Const
        if expr.op == :+
            return Const(left.value + right.value)
        elseif expr.op == :-
            return Const(left.value - right.value)
        elseif expr.op == :*
            return Const(left.value * right.value)
        elseif expr.op == :/
            return Const(left.value / right.value)
        elseif expr.op == :^
            return Const(left.value ^ right.value)
        end
    end

    # Identity rules
    if expr.op == :+
        (left isa Const && left.value == 0) && return right
        (right isa Const && right.value == 0) && return left
    end

    if expr.op == :*
        (left isa Const && left.value == 0) && return Const(0)
        (right isa Const && right.value == 0) && return Const(0)
        (left isa Const && left.value == 1) && return right
        (right isa Const && right.value == 1) && return left
    end

    if expr.op == :-
        (right isa Const && right.value == 0) && return left
    end

    if expr.op == :/
        (right isa Const && right.value == 1) && return left
    end

    if expr.op == :^
        (right isa Const && right.value == 0) && return Const(1)
        (right isa Const && right.value == 1) && return left
    end

    return BinaryOp(expr.op, left, right)
end

# Convenience function to convert numbers to Const
simplify(x::Number) = Const(x)

function Simplify(expr::SymExpr)
    # Recursively simplify
    expr = simplify_once(expr)
    prev = nothing
    while prev !== expr
        prev = expr
        expr = simplify_once(expr)
    end
    expr
end
