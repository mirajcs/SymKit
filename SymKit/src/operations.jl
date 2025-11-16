#basic arithmatic operations 

Base.:+(a::Union{SymExpr,Number},b::Union{SymExpr,Number}) = BinaryOp(:+,promote_expr(a),promote_expr(b))
Base.:-(a::Union{SymExpr,Number},b::Union{SymExpr,Number}) = BinaryOp(:-,promote_expr(a),promote_expr(b))
Base.:*(a::Union{SymExpr,Number},b::Union{SymExpr,Number}) = BinaryOp(:*,promote_expr(a),promote_expr(b))
Base.:/(a::Union{SymExpr,Number},b::Union{SymExpr,Number}) = BinaryOp(:/,promote_expr(a),promote_expr(b))
Base.:^(a::Union{SymExpr,Number},b::Union{SymExpr,Number}) = BinaryOp(:^,promote_expr(a),promote_expr(b))
Base.:-(a::SymExpr) =  UnaryOp(:-, a)