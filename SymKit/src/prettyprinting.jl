function Base.show(io::IO, s::Sym)
    print(io,s.name)
end

function Base.show(io::IO, c::Const)
    print(io, c.value)
end 

function Base.show(io::IO, u::UnaryOp)
    if u.op == :- 
        print(io, "-(", u.arg, ")")
    else 
        print(io, u.op, "(",u.arg,")")
    end 
end

function Base.show(io::IO, b::BinaryOp)
    print(io, "(",b.left, " ", b.op, " ", b.right, ")")
end