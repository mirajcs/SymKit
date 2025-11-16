macro sym(x)
    :(Sym($(QuoteNode(x))))
end