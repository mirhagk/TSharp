using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Irony.Parsing;
using Irony.Ast;

namespace TSharpCompiler
{
    [Language("Turing", "0.1", "A .NET implementation of Turing that compiles to CIL")]
    public class TuringGrammar : Irony.Parsing.Grammar
    {
        public TuringGrammar()
        {
            //Expr -> n | v | Expr BinOp Expr | UnOP Expr | ( Expr )
            //BinOp -> + | - | * | / | **
            //UnOp -> -
            //ExprLine -> Expr EOF
            
            //1. Terminals
            Terminal n = new NumberLiteral("number");
            Terminal v = new IdentifierTerminal("variable");

            //2. Non-Terminals
            NonTerminal Expr = new NonTerminal("Expr");
            NonTerminal BinOp = new NonTerminal("BinOp");
            NonTerminal UnOp = new NonTerminal("UnOp");
            NonTerminal ExprLine = new NonTerminal("ExprLine");

            //3. BNF rules
            Expr.Rule = n | v | Expr + BinOp + Expr | UnOp + Expr | "(" + Expr + ")";
            BinOp.Rule = new ImpliedSymbolTerminal("+") | "-" | "*" | "/" | "**";
            UnOp.Rule = "-";
            ExprLine.Rule = Expr + Eof;
            this.Root = ExprLine;

            //4. Set operator precenednce and associativity
            RegisterOperators(1, "+", "-");
            RegisterOperators(2, "*", "/");
            RegisterOperators(3, Associativity.Right, "**");

            //5. Register Parenthesis as punctuation symbols so they will not appear in the syntax tree
            MarkPunctuation("(", ")");
        }
    }
}
