using Microsoft.CodeAnalysis;
using Microsoft.CodeAnalysis.CSharp;
using Microsoft.CodeAnalysis.CSharp.Syntax;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TSharp
{
    class Program
    {
        static void Main(string[] args)
        {
            SyntaxTree tree = CSharpSyntaxTree.ParseText(
@"using System;
            using System.Collections;
            using System.Linq;
            using System.Text;

namespace HelloWorld
    {
        class Program
        {
            static void Main(string[] args)
            {
                var x = 1 + 1;
                Console.WriteLine(""Hello, World!"");
            }
        }
    }");
            var root = (CompilationUnitSyntax)tree.GetRoot();
            
            WriteTree(root);
            Console.ReadKey();
            TSharp.TSharpGrammar grammar = new TSharp.TSharpGrammar();
        }
        static string Repeat(string text, int times)
        {
            string result = "";
            for (int i = 0; i < times; i++) result += text;
            return result;
        }
        static void WriteTree(SyntaxNode node, int indent=0)
        {
            Console.WriteLine("{0}----------------\n{0}{2}-{1}", Repeat(".", indent), node,node.CSharpKind());
            foreach (var child in node.ChildNodes())
                WriteTree(child, indent + 1);
        }
    }
}
