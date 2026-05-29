module Ast exposing (..)


type CalcExpr
    = Number Float
    | Neg CalcExpr
    | Sum CalcExpr CalcExpr
    | Sub CalcExpr CalcExpr
    | Mul CalcExpr CalcExpr
    | Div CalcExpr CalcExpr
    | Pow CalcExpr CalcExpr


eval : CalcExpr -> Float
eval expr =
    case expr of
        Number x ->
            x

        Neg x ->
            0 - eval x

        Sum left right ->
            eval left + eval right

        Sub left right ->
            eval left - eval right

        Mul left right ->
            eval left * eval right

        Div left right ->
            eval left / eval right

        Pow left right ->
            eval left ^ eval right


toSource : CalcExpr -> String
toSource expr =
    let
        wrap x =
            case x of
                Number y ->
                    String.fromFloat y

                _ ->
                    "(" ++ toSource x ++ ")"

        wrapOp left op right =
            wrapIf (needParens left op) left ++ " " ++ op ++ " " ++ wrapIf (needParens right op) right

        wrapIf cond e =
            if cond then
                wrap e

            else
                toSource e

        needParens e op =
            case ( e, op ) of
                ( Sum _ _, "*" ) ->
                    True

                ( Sub _ _, "*" ) ->
                    True

                ( Sum _ _, "^" ) ->
                    True

                ( Sub _ _, "^" ) ->
                    True

                ( Mul _ _, "^" ) ->
                    True

                ( Div _ _, "^" ) ->
                    True

                _ ->
                    False
    in
    case expr of
        Number x ->
            String.fromFloat x

        Neg x ->
            "-(" ++ toSource x ++ ")"

        Sum left right ->
            wrapOp left "+" right

        Sub left right ->
            wrapOp left "-" right

        Mul left right ->
            wrapOp left "*" right

        Div left right ->
            wrapOp left "/" right

        Pow left right ->
            wrapOp left "^" right


example : CalcExpr
example =
    Mul (Sum (Number 10) (Number 11)) (Number 2)


example2 : CalcExpr
example2 =
    Sum (Mul (Number 10) (Number 4)) (Number 2)
