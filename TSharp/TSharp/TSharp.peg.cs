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
            IParseResult<string> r1 = null;
            r1 = this.Expr(ref cursor);
            if (r1 != null)
            {
                r0 = this.ReturnHelper<StatementSyntax>(startCursor0, ref cursor, state =>
                    #line 11 "TSharp.peg"
         null
                    #line default
                    );
            }
            else
            {
                cursor = startCursor0;
            }
            return r0;
        }

        private IParseResult<string> Expr(ref Cursor cursor)
        {
            IParseResult<string> r0 = null;
            r0 = this.number(ref cursor);
            return r0;
        }

        private IParseResult<string> number(ref Cursor cursor)
        {
            IParseResult<string> r0 = null;
            r0 = this.ParseClass(ref cursor, "09");
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
                r0 = this.ParseLiteral(ref cursor, "const");
            }
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
