using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.CodeAnalysis;
using Microsoft.CodeAnalysis.CSharp;
using Microsoft.CodeAnalysis.CSharp.Syntax;

namespace TSharp
{
    partial class TSharpGrammar
    {
        public string Flatten(IList<string> input)
        {
            var result = "";
            foreach (var item in input) result += item;
            return result;
            //SyntaxFactory.ExpressionStatement()
            //SyntaxFactory.LiteralExpression(SyntaxKind.NumericLiteralExpression
        }
    }
}
