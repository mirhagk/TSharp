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
        }
        public static void Test()
        {


            Console.WriteLine("test");
            var invokable = SyntaxFactory.InvocationExpression(GenerateMemberAccess("System", "Console", "WriteLine"));
            var lambda = SyntaxFactory.SimpleLambdaExpression(SyntaxFactory.Parameter(SyntaxFactory.Identifier("x")), invokable);
            
            //SyntaxFactory.PredefinedType
            //SyntaxFactory.V
            //SyntaxFactory.ExpressionStatement()
            //SyntaxFactory.LiteralExpression(SyntaxKind.NumericLiteralExpression
        }

        private static ExpressionSyntax GenerateMemberAccess(params string[] names)
        {
            ExpressionSyntax result = SyntaxFactory.IdentifierName(SyntaxFactory.Token(SyntaxKind.GlobalKeyword));
            for (int i = 0; i < names.Length; i++)
            {
                var name = SyntaxFactory.IdentifierName(names[i]);
                if (i == 0)
                {
                    result = SyntaxFactory.AliasQualifiedName((IdentifierNameSyntax)result, name);
                }
                else
                {
                    result = SyntaxFactory.MemberAccessExpression(SyntaxKind.SimpleMemberAccessExpression, result, name);
                }
            }

            return result;
        }
    }
}
