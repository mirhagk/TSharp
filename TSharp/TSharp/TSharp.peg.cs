// -----------------------------------------------------------------------
// <auto-generated>
//   This code was generated by Pegasus 3.1.0.0
//
//   Changes to this file may cause incorrect behavior and will be lost if
//   the code is regenerated.
// </auto-generated>
// -----------------------------------------------------------------------

namespace
#line 1 "TSharp.peg"
           TSharp
#line default
{
    using System;
    using System.Collections.Generic;
    using Pegasus.Common;
    using
        #line 3 "TSharp.peg"
       Microsoft.CodeAnalysis
        #line default
        ;
    using
        #line 4 "TSharp.peg"
       Microsoft.CodeAnalysis.CSharp
        #line default
        ;
    using
        #line 5 "TSharp.peg"
       Microsoft.CodeAnalysis.CSharp.Syntax
        #line default
        ;

    /// <summary>
    ///  Parses a string according to the rules of the <see cref="TSharpGrammar" /> grammar.
    /// </summary>
    [System.CodeDom.Compiler.GeneratedCode("Pegasus", "3.1.0.0")]
    public
    partial class
    #line 2 "TSharp.peg"
           TSharpGrammar
    #line default
    {

        /// <summary>
        ///  Parses a string according to the rules of the <see cref="TSharpGrammar" /> grammar.
        /// </summary>
        /// <param name="subject">The parsing subject.</param>
        /// <param name="fileName">The optional file name to use in error messages.</param>
        /// <returns>The <see cref="SyntaxNode" /> parsed from <paramref name="subject" />.</returns>
        /// <exception cref="FormatException">
        ///  Thrown when parsing fails against <paramref name="subject"/>.  The exception's <code>Data["cursor"]</code> will be set with the cursor where the fatal error occurred.
        /// </exception>
        public SyntaxNode Parse(string subject, string fileName = null)
        {
            var cursor = new Cursor(subject, 0, fileName);
            var result = this.Start(ref cursor);
            if (result == null)
            {
                throw ExceptionHelper(cursor, state => "Failed to parse 'Start'.");
            }
            return result.Value;
        }

        private IParseResult<
            #line 8 "TSharp.peg"
       SyntaxNode
            #line default
            > Start(ref Cursor cursor)
        {
            IParseResult<SyntaxNode> r0 = null;
            var startCursor0 = cursor;
            IParseResult<IList<StatementSyntax>> r1 = null;
            var statementsStart = cursor;
            var startCursor1 = cursor;
            var l0 = new List<StatementSyntax>();
            while (true)
            {
                IParseResult<StatementSyntax> r2 = null;
                r2 = this.Statement(ref cursor);
                if (r2 != null)
                {
                    l0.Add(r2.Value);
                }
                else
                {
                    break;
                }
            }
            r1 = this.ReturnHelper<IList<StatementSyntax>>(startCursor1, ref cursor, state => l0.AsReadOnly());
            var statementsEnd = cursor;
            var statements = ValueOrDefault(r1);
            if (r1 != null)
            {
                r0 = this.ReturnHelper<SyntaxNode>(startCursor0, ref cursor, state =>
                    #line 9 "TSharp.peg"
                            SyntaxFactory.Block(statements)
                    #line default
                    );
            }
            else
            {
                cursor = startCursor0;
            }
            return r0;
        }

        private IParseResult<
            #line 10 "TSharp.peg"
           StatementSyntax
            #line default
            > Statement(ref Cursor cursor)
        {
            IParseResult<StatementSyntax> r0 = null;
            var startCursor0 = cursor;
            IParseResult<ExpressionSyntax> r1 = null;
            var exprStart = cursor;
            r1 = this.Expr(ref cursor);
            var exprEnd = cursor;
            var expr = ValueOrDefault(r1);
            if (r1 != null)
            {
                r0 = this.ReturnHelper<StatementSyntax>(startCursor0, ref cursor, state =>
                    #line 11 "TSharp.peg"
              SyntaxFactory.ExpressionStatement(expr)
                    #line default
                    );
            }
            else
            {
                cursor = startCursor0;
            }
            return r0;
        }

        private IParseResult<
            #line 12 "TSharp.peg"
      ExpressionSyntax
            #line default
            > Expr(ref Cursor cursor)
        {
            IParseResult<ExpressionSyntax> r0 = null;
            var startCursor0 = cursor;
            IParseResult<LiteralExpressionSyntax> r1 = null;
            var valStart = cursor;
            r1 = this.number(ref cursor);
            var valEnd = cursor;
            var val = ValueOrDefault(r1);
            if (r1 != null)
            {
                r0 = this.ReturnHelper<ExpressionSyntax>(startCursor0, ref cursor, state =>
                    #line 13 "TSharp.peg"
               (val)
                    #line default
                    );
            }
            else
            {
                cursor = startCursor0;
            }
            return r0;
        }

        private IParseResult<
            #line 14 "TSharp.peg"
        LiteralExpressionSyntax
            #line default
            > number(ref Cursor cursor)
        {
            IParseResult<LiteralExpressionSyntax> r0 = null;
            var startCursor0 = cursor;
            IParseResult<IList<string>> r1 = null;
            r1 = this.ows(ref cursor);
            if (r1 != null)
            {
                IParseResult<IList<string>> r2 = null;
                var valStart = cursor;
                var startCursor1 = cursor;
                var l0 = new List<string>();
                while (true)
                {
                    IParseResult<string> r3 = null;
                    r3 = this.ParseClass(ref cursor, "09");
                    if (r3 != null)
                    {
                        l0.Add(r3.Value);
                    }
                    else
                    {
                        break;
                    }
                }
                if (l0.Count >= 1)
                {
                    r2 = this.ReturnHelper<IList<string>>(startCursor1, ref cursor, state => l0.AsReadOnly());
                }
                else
                {
                    cursor = startCursor1;
                }
                var valEnd = cursor;
                var val = ValueOrDefault(r2);
                if (r2 != null)
                {
                    IParseResult<IList<string>> r4 = null;
                    r4 = this.ows(ref cursor);
                    if (r4 != null)
                    {
                        r0 = this.ReturnHelper<LiteralExpressionSyntax>(startCursor0, ref cursor, state =>
                            #line 15 "TSharp.peg"
                         SyntaxFactory.LiteralExpression(SyntaxKind.NumericLiteralExpression,SyntaxFactory.Literal(int.Parse(Flatten(val))))
                            #line default
                            );
                    }
                    else
                    {
                        cursor = startCursor0;
                    }
                }
                else
                {
                    cursor = startCursor0;
                }
            }
            else
            {
                cursor = startCursor0;
            }
            return r0;
        }

        private IParseResult<string> varOrConst(ref Cursor cursor)
        {
            IParseResult<string> r0 = null;
            if (r0 == null)
            {
                r0 = this.ParseLiteral(ref cursor, "var");
            }
            if (r0 == null)
            {
                var startCursor0 = cursor;
                IParseResult<string> r1 = null;
                r1 = this.ParseLiteral(ref cursor, "const");
                if (r1 != null)
                {
                    IParseResult<IList<string>> r2 = null;
                    r2 = this.ows(ref cursor);
                    if (r2 != null)
                    {
                        {
                            var len = cursor.Location - startCursor0.Location;
                            r0 = this.ReturnHelper<string>(startCursor0, ref cursor, state =>
                                state.Subject.Substring(startCursor0.Location, len)
                                );
                        }
                    }
                    else
                    {
                        cursor = startCursor0;
                    }
                }
                else
                {
                    cursor = startCursor0;
                }
            }
            return r0;
        }

        private IParseResult<
            #line 17 "TSharp.peg"
           SeparatedSyntaxList<VariableDeclaratorSyntax>
            #line default
            > idenList(ref Cursor cursor)
        {
            IParseResult<SeparatedSyntaxList<VariableDeclaratorSyntax>> r0 = null;
            var startCursor0 = cursor;
            IParseResult<IList<VariableDeclaratorSyntax>> r1 = null;
            var idensStart = cursor;
            var startCursor1 = cursor;
            var l0 = new List<VariableDeclaratorSyntax>();
            while (true)
            {
                IParseResult<VariableDeclaratorSyntax> r2 = null;
                r2 = this.identifier(ref cursor);
                if (r2 != null)
                {
                    l0.Add(r2.Value);
                }
                else
                {
                    break;
                }
            }
            if (l0.Count >= 1)
            {
                r1 = this.ReturnHelper<IList<VariableDeclaratorSyntax>>(startCursor1, ref cursor, state => l0.AsReadOnly());
            }
            else
            {
                cursor = startCursor1;
            }
            var idensEnd = cursor;
            var idens = ValueOrDefault(r1);
            if (r1 != null)
            {
                r0 = this.ReturnHelper<SeparatedSyntaxList<VariableDeclaratorSyntax>>(startCursor0, ref cursor, state =>
                    #line 18 "TSharp.peg"
                        SyntaxFactory.SeparatedList<VariableDeclaratorSyntax>(idens)
                    #line default
                    );
            }
            else
            {
                cursor = startCursor0;
            }
            return r0;
        }

        private IParseResult<
            #line 19 "TSharp.peg"
            VariableDeclaratorSyntax
            #line default
            > identifier(ref Cursor cursor)
        {
            IParseResult<VariableDeclaratorSyntax> r0 = null;
            var startCursor0 = cursor;
            IParseResult<IList<string>> r1 = null;
            var idenStart = cursor;
            var startCursor1 = cursor;
            var l0 = new List<string>();
            while (true)
            {
                IParseResult<string> r2 = null;
                r2 = this.ParseClass(ref cursor, "azAZ");
                if (r2 != null)
                {
                    l0.Add(r2.Value);
                }
                else
                {
                    break;
                }
            }
            if (l0.Count >= 1)
            {
                r1 = this.ReturnHelper<IList<string>>(startCursor1, ref cursor, state => l0.AsReadOnly());
            }
            else
            {
                cursor = startCursor1;
            }
            var idenEnd = cursor;
            var iden = ValueOrDefault(r1);
            if (r1 != null)
            {
                r0 = this.ReturnHelper<VariableDeclaratorSyntax>(startCursor0, ref cursor, state =>
                    #line 20 "TSharp.peg"
                     SyntaxFactory.VariableDeclarator(Flatten(iden))
                    #line default
                    );
            }
            else
            {
                cursor = startCursor0;
            }
            return r0;
        }

        private IParseResult<
            #line 21 "TSharp.peg"
                     VariableDeclarationSyntax
            #line default
            > variableDeclaration(ref Cursor cursor)
        {
            IParseResult<VariableDeclarationSyntax> r0 = null;
            var startCursor0 = cursor;
            IParseResult<string> r1 = null;
            r1 = this.varOrConst(ref cursor);
            if (r1 != null)
            {
                IParseResult<SeparatedSyntaxList<VariableDeclaratorSyntax>> r2 = null;
                var idensStart = cursor;
                r2 = this.idenList(ref cursor);
                var idensEnd = cursor;
                var idens = ValueOrDefault(r2);
                if (r2 != null)
                {
                    IParseResult<TypeSyntax> r3 = null;
                    var typeStart = cursor;
                    r3 = this.typeSpecifier(ref cursor);
                    var typeEnd = cursor;
                    var type = ValueOrDefault(r3);
                    if (r3 != null)
                    {
                        r0 = this.ReturnHelper<VariableDeclarationSyntax>(startCursor0, ref cursor, state =>
                            #line 22 "TSharp.peg"
                                                  SyntaxFactory.VariableDeclaration(type,idens)
                            #line default
                            );
                    }
                    else
                    {
                        cursor = startCursor0;
                    }
                }
                else
                {
                    cursor = startCursor0;
                }
            }
            else
            {
                cursor = startCursor0;
            }
            return r0;
        }

        private IParseResult<
            #line 23 "TSharp.peg"
               TypeSyntax
            #line default
            > typeSpecifier(ref Cursor cursor)
        {
            IParseResult<TypeSyntax> r0 = null;
            var startCursor0 = cursor;
            IParseResult<string> r1 = null;
            r1 = this.ParseLiteral(ref cursor, "int");
            if (r1 != null)
            {
                r0 = this.ReturnHelper<TypeSyntax>(startCursor0, ref cursor, state =>
                    #line 24 "TSharp.peg"
          SyntaxFactory.ParseTypeName("int")
                    #line default
                    );
            }
            else
            {
                cursor = startCursor0;
            }
            return r0;
        }

        private IParseResult<string> ws(ref Cursor cursor)
        {
            IParseResult<string> r0 = null;
            r0 = this.ParseClass(ref cursor, "  \t\t\n\n\r\r");
            return r0;
        }

        private IParseResult<IList<string>> ows(ref Cursor cursor)
        {
            IParseResult<IList<string>> r0 = null;
            var startCursor0 = cursor;
            var l0 = new List<string>();
            while (true)
            {
                IParseResult<string> r1 = null;
                r1 = this.ws(ref cursor);
                if (r1 != null)
                {
                    l0.Add(r1.Value);
                }
                else
                {
                    break;
                }
            }
            r0 = this.ReturnHelper<IList<string>>(startCursor0, ref cursor, state => l0.AsReadOnly());
            return r0;
        }

        private IParseResult<string> ParseLiteral(ref Cursor cursor, string literal, bool ignoreCase = false)
        {
            if (cursor.Location + literal.Length <= cursor.Subject.Length)
            {
                var substr = cursor.Subject.Substring(cursor.Location, literal.Length);
                if (ignoreCase ? substr.Equals(literal, StringComparison.OrdinalIgnoreCase) : substr == literal)
                {
                    var endCursor = cursor.Advance(substr.Length);
                    var result = this.ReturnHelper<string>(cursor, ref endCursor, state => substr);
                    cursor = endCursor;
                    return result;
                }
            }
            return null;
        }

        private IParseResult<string> ParseClass(ref Cursor cursor, string characterRanges, bool negated = false, bool ignoreCase = false)
        {
            if (cursor.Location + 1 <= cursor.Subject.Length)
            {
                var c = cursor.Subject[cursor.Location];
                bool match = false;
                for (int i = 0; !match && i < characterRanges.Length; i += 2)
                {
                    match = c >= characterRanges[i] && c <= characterRanges[i + 1];
                }
                if (!match && ignoreCase && (char.IsUpper(c) || char.IsLower(c)))
                {
                    var cs = c.ToString();
                    for (int i = 0; !match && i < characterRanges.Length; i += 2)
                    {
                        var min = characterRanges[i];
                        var max = characterRanges[i + 1];
                        for (char o = min; !match && o <= max; o++)
                        {
                            match = (char.IsUpper(o) || char.IsLower(o)) && cs.Equals(o.ToString(), StringComparison.CurrentCultureIgnoreCase);
                        }
                    }
                }
                if (match ^ negated)
                {
                    var endCursor = cursor.Advance(1);
                    var substr = cursor.Subject.Substring(cursor.Location, 1);
                    var result = this.ReturnHelper<string>(cursor, ref endCursor, state => substr);
                    cursor = endCursor;
                    return result;
                }
            }
            return null;
        }

        private IParseResult<string> ParseAny(ref Cursor cursor)
        {
            if (cursor.Location + 1 <= cursor.Subject.Length)
            {
                var substr = cursor.Subject.Substring(cursor.Location, 1);
                var endCursor = cursor.Advance(1);
                var result = this.ReturnHelper<string>(cursor, ref endCursor, state => substr);
                cursor = endCursor;
                return result;
            }
            return null;
        }

        private IParseResult<T> ReturnHelper<T>(Cursor startCursor, ref Cursor endCursor, Func<Cursor, T> wrappedCode)
        {
            var result = wrappedCode(endCursor);
            var lexical = result as ILexical;
            if (lexical != null && lexical.StartCursor == null && lexical.EndCursor == null)
            {
                lexical.StartCursor = startCursor;
                lexical.EndCursor = endCursor;
            }
            return new ParseResult<T>(startCursor, endCursor, result);
        }

        private Exception ExceptionHelper(Cursor cursor, Func<Cursor, string> wrappedCode)
        {
            var ex = new FormatException(wrappedCode(cursor));
            ex.Data["cursor"] = cursor;
            return ex;
        }

        private T ValueOrDefault<T>(IParseResult<T> result)
        {
            return result == null
                ? default(T)
                : result.Value;
        }
    }
}
