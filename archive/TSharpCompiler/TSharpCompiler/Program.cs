using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Text.RegularExpressions;

namespace TSharpCompiler
{
    class Program
    {
        class Token
        {
            public string tokenType;
            public string value;
            public Match match;
            public override string ToString()
            {
                return value;
            }
        }
        class TokenMatch
        {
            public Regex regex;
            public string tokenType;
            public Func<string, string> tokenAlterer = null;
            public Regex first;
        }
        class GrammarToken
        {
            public GrammarToken[] children;
            public Token token;
            public string type;
            public GrammarTokenMatch grammarMatch;
        }
        class GrammarTokenMatch
        {
            public string type;
            public int precedence;
            public string[] matches;
            public static bool Matches(List<GrammarTokenMatch> grammarTokenMatches, List<TokenMatch> lexicalTokenMatches, List<Token> tokens, int index, int length, string type)
            {
                List<GrammarTokenMatch> validMatches = grammarTokenMatches.Where((x) => x.type == type).ToList();
                foreach (var priority in validMatches.Select((x) => x.precedence).Distinct().OrderBy((x)=>x))
                {
                    foreach (var priorityMatch in validMatches.Where((x) => x.precedence == priority))
                    {
                        List<string> terminals = priorityMatch.matches.Where((x) => lexicalTokenMatches.Exists((y) => x == y.tokenType)).ToList();
                        List<int> terminalMatches=new List<int>();
                        int terminal = 0;
                        int i = index;
                        while (terminal < terminals.Count)
                        {
                            if (tokens[i].tokenType == terminals[terminal])
                            {
                                terminalMatches.Add(i);
                                terminal++;
                            }
                            i++;
                            if (i > length)
                                break;
                        }
                        if (terminalMatches.Count == terminals.Count)
                        {
                            GrammarToken grammarToken = new GrammarToken();
                            List<int> terminalMatchIndexes = new List<int>();
                            for (int p = 0; p < priorityMatch.matches.Length; p++)
                            {
                                int terminalID = terminals.FindIndex((x) => x == priorityMatch.matches[p]);
                                if (terminalID >= 0)
                                {
                                    //grammarToken
                                }
                            }
                        }
                    }
                }
                return false;
            }
            public static void Parse(List<GrammarTokenMatch> grammarTokenMatches, List<TokenMatch> lexicalTokenMatches, List<Token> tokens)
            {
                //a list (for each token in the input) of lists (one for each token, to hold each possible grammar state) of Tuples (each grammar state)
                //The tuple has 3 fields, the grammar token, the current position in the rule, and where the rule was made
                List<List<Tuple<int, int, int>>> stateChart = new List<List<Tuple<int, int, int>>>();
                stateChart.Add(new List<Tuple<int, int, int>>());
                for (int i = 0; i < grammarTokenMatches.Count; i++)//for each grammar rule
                {
                    stateChart[0].Add(Tuple.Create<int,int,int>(i,0,0));
                }
                for (int i = 1; i < tokens.Count; i++)//for each token in the input, i is how many tokens we have looked at
                {
                    stateChart.Add(new List<Tuple<int, int, int>>());
                    for (int p = 0; p < stateChart[i - 1].Count; p++)//look at all the states from the last token, possibly shifting them in
                    {
                        //if it's not at the end
                        if (grammarTokenMatches[stateChart[i][p].Item1].matches.Length == stateChart[i][p].Item2)
                        {

                        }
                    }
                    for (int p = 0; p < stateChart[i].Count; p++)//use closure and reduction on each state in the current chart state to possibly produce more states
                    {
                        //closure
                        if (grammarTokenMatches[stateChart[i - 1][p].Item1].matches[stateChart[i - 1][p].Item2] == null)
                        {
                        }
                        //reduction

                    }
                }
            }
        }
        static string RegexMatch(TokenMatch tokenMatch, string input)
        {
            string result = tokenMatch.regex.Match(input).Value;
            if (result != "")
                if (tokenMatch.tokenAlterer != null)
                    result = tokenMatch.tokenAlterer(result);
            return result + ";";
        }
        static List<Token> LexicalAnalyzer(List<TokenMatch> tokenMatches, string input)
        {
            string newInput = input;//.Replace("\n", " \n") + " ";
            List<Token> tokens = new List<Token>();
            int index = 0;
            while (index < newInput.Length)
            {
                for (int i = 0; i < tokenMatches.Count; i++)
                {
                    if (tokenMatches[i].first.Match(newInput, index, 1).Success)
                    {
                        Match match = tokenMatches[i].regex.Match(newInput, index);
                        if (match.Success && match.Index == index)
                        {
                            if (tokenMatches[i].tokenType == "whitespace" || tokenMatches[i].tokenType == "comment")
                            {
                                index = match.Index + match.Length;
                                break;
                            }
                            tokens.Add(new Token { match = match, value = tokenMatches[i].tokenAlterer != null ? tokenMatches[i].tokenAlterer(match.Value) : match.Value, tokenType = tokenMatches[i].tokenType });
                            //if (tokens[tokens.Count-1].tokenType!="string")
                            //    index = match.Index + tokens[tokens.Count - 1].value.Length;
                            //else
                            //    index = match.Index + match.Length;//tokens[tokens.Count - 1].value.Length
                            if (index == 133452)
                            {
                            }
                                index = match.Index + match.Value.Trim().Length;
                            break;
                        }
                    }
                }
            }
            return tokens;
        }
        static void PrintLexicalAnalysis(List<Token> tokens, System.IO.TextWriter writer)
        {
            foreach (Token token in tokens)
            {
                if (token.tokenType != "whitespace")
                    writer.WriteLine("{0}:({1}, {2}, {3})", token.tokenType, token.value, token.match.Index, token.match.Length);
            }
        }
        static List<TokenMatch> BuildTSharpLexer()
        {
            List<TokenMatch> tokenMatches = new List<TokenMatch>();

            tokenMatches.Add(new TokenMatch { regex = new Regex("%.*\\n"), tokenType = "comment", tokenAlterer = (x) => x.Substring(0, x.Length - 1), first = new Regex("%")});
            tokenMatches.Add(new TokenMatch { regex = new Regex("var "), tokenType = "var", tokenAlterer = (x) => x.Substring(0, x.Length - 1), first = new Regex("v") });
            tokenMatches.Add(new TokenMatch
            {
                regex = new Regex("((int)|(int4)|(int2)|(int1)|(nat)|(nat4)|(nat2)|(nat1)|(string)|(real)|(real4)|(real2)|(real1)|(boolean))[^a-zA-Z0-9]"),
                tokenType = "varType",
                tokenAlterer = (x) => x.Substring(0, x.Length - 1),
                first = new Regex("[isrb]")
            });
            tokenMatches.Add(new TokenMatch { regex = new Regex("[0-9]*\\.[0-9]+"), tokenType = "real", first = new Regex("[0-9]") });
            tokenMatches.Add(new TokenMatch { regex = new Regex("[0-9]+"), tokenType = "int", first = new Regex("[0-9]") });
            tokenMatches.Add(new TokenMatch { regex = new Regex("((true)|(false))[^a-zA-Z0-9]"), tokenType = "boolean", first = new Regex("[tf]") });
            tokenMatches.Add(new TokenMatch { regex = new Regex("\"[^\\n\"]*\""), tokenType = "stringLiteral", tokenAlterer = (x) => x.Substring(1, x.Length - 2), first = new Regex("\"") });
            tokenMatches.Add(new TokenMatch { regex = new Regex("'[^\\n\"]'"), tokenType = "charLiteral", tokenAlterer = (x) => x.Substring(1, x.Length - 2), first = new Regex("'") });
            tokenMatches.Add(new TokenMatch { regex = new Regex(":="), tokenType = "setEqual", first = new Regex(":") });
            tokenMatches.Add(new TokenMatch { regex = new Regex("="), tokenType = "isEqual", first = new Regex("=") });
            tokenMatches.Add(new TokenMatch { regex = new Regex(":"), tokenType = "colon", first = new Regex(":") });
            tokenMatches.Add(new TokenMatch { regex = new Regex("\\+"), tokenType = "+", first = new Regex("\\+") });
            tokenMatches.Add(new TokenMatch { regex = new Regex("\\-"), tokenType = "-", first = new Regex("\\-") });
            tokenMatches.Add(new TokenMatch { regex = new Regex("\\/"), tokenType = "/" , first = new Regex("\\/")});
            tokenMatches.Add(new TokenMatch { regex = new Regex("mod[^a-zA-Z0-9]"), tokenType = "mod", first = new Regex("m") });
            tokenMatches.Add(new TokenMatch { regex = new Regex("\\*\\*"), tokenType = "**", first = new Regex("\\*") });
            tokenMatches.Add(new TokenMatch { regex = new Regex("\\*"), tokenType = "*", first = new Regex("\\*") });
            tokenMatches.Add(new TokenMatch { regex = new Regex(","), tokenType = ",", first = new Regex(",") });
            tokenMatches.Add(new TokenMatch { regex = new Regex("\\>"), tokenType = ">", first = new Regex("\\>") });
            tokenMatches.Add(new TokenMatch { regex = new Regex("\\<"), tokenType = "<", first = new Regex("\\<") });
            tokenMatches.Add(new TokenMatch { regex = new Regex("\\."), tokenType = ".", first = new Regex("\\.") });
            tokenMatches.Add(new TokenMatch { regex = new Regex("put"), tokenType = "put", first = new Regex("p") });
            tokenMatches.Add(new TokenMatch { regex = new Regex("get"), tokenType = "get", first = new Regex("g") });
            tokenMatches.Add(new TokenMatch { regex = new Regex("type"), tokenType = "type", first = new Regex("t") });
            tokenMatches.Add(new TokenMatch { regex = new Regex("record"), tokenType = "record", first = new Regex("r") });
            tokenMatches.Add(new TokenMatch { regex = new Regex("\\("), tokenType = "(", first = new Regex("\\(") });
            tokenMatches.Add(new TokenMatch { regex = new Regex("\\)"), tokenType = ")", first = new Regex("\\)") });
            tokenMatches.Add(new TokenMatch { regex = new Regex("[a-zA-Z_][a-zA-Z0-9_]*"), tokenType = "word", first = new Regex("[a-zA-Z_]") });
            tokenMatches.Add(new TokenMatch { regex = new Regex("\\n+"), tokenType = "newline", first = new Regex("\\n") });
            tokenMatches.Add(new TokenMatch { regex = new Regex("[ \\n\\r\\t]+"), tokenType = "whitespace", first = new Regex("[ \\n\\r\\t]") });
            tokenMatches.Add(new TokenMatch { regex = new Regex("."), tokenType = "unMatchedChar", first = new Regex(".") });

            return tokenMatches;
        }
        class TSharpParsingException : Exception
        {
            public Token token;
            public string errorType;
            public static Dictionary<string, string> errorMessages = new Dictionary<string, string>{
                        {"varNotFirst","Unexpected \"var\" encountered. \"var\" should only be used at the beginning of a line."}};
            public TSharpParsingException(string errorType, Token token)//:base(errorMessages[errorType])
            {
                this.token = token;
                this.errorType = errorType;
            }
        }
        static List<Token> RemoveWhiteSpace(List<Token> inTokens)
        {
            List<Token> tokens = new List<Token>();
            foreach (Token token in inTokens)
            {
                if (token.tokenType != "whitespace" && token.tokenType != "comment")
                    tokens.Add(token);
            }
            return tokens;
        }
        static string ConvertToCSharpPreDef(List<Token> inTokens)
        {
            List<Token> tokens = RemoveWhiteSpace(inTokens);
            string line = "";
            int i = 0;
            string identifier;
            if (tokens.Count == 0)
                return "";
            switch (tokens[i].tokenType)
            {
                case "var":
                    i++;
                    if (tokens[i].tokenType != "word") throw new TSharpParsingException("expectedIdentifier", tokens[i]);
                    identifier = tokens[i].value;
                    i++;
                    switch (tokens[i].tokenType)
                    {
                        case "colon":
                            i++;
                            if (tokens[i].tokenType != "varType") throw new TSharpParsingException("expectedVarType", tokens[i]);
                            string varType = tokens[i].value;
                            line = String.Format("{0} {1};", varType, identifier);
                            break;
                        case "setEqual":
                            i++;
                            line = "var " + identifier + "=";
                            for (int p = i; p < tokens.Count; p++)
                            {
                                line += tokens[p].value;
                            }
                            line += ";";
                            break;
                        default:
                            throw new TSharpParsingException("unexpected", tokens[i]);
                    }
                    break;
                case "word":
                    identifier = tokens[i].value;
                    i++;
                    switch (tokens[i].tokenType)
                    {
                        case "setEqual":
                            i++;
                            line = identifier + "=";
                            for (int p = i; p < tokens.Count; p++)
                            {
                                line += tokens[p].value;
                            }
                            line += ";";
                            break;
                        case "leftParenth":
                            break;
                        case "word":
                            line = identifier + "(";
                            for (int p = i; p < tokens.Count; p++)
                            {
                                switch (tokens[p].tokenType)
                                {
                                    case "word":
                                        line += tokens[p].value + ",";
                                        break;
                                    case "comma":
                                        break;
                                    default:
                                        throw new TSharpParsingException("unexpected", tokens[i]);
                                }
                            }
                            line = line.Substring(0, line.Length - 1) + ")";
                            break;
                    }
                    break;
                default:
                    throw new TSharpParsingException("unexpected", tokens[i]);
            }
            return line;
        }
        static List<GrammarTokenMatch> BuildGrammar()
        {
            List<GrammarTokenMatch> grammarMatches = new List<GrammarTokenMatch>();
            var file = new System.IO.StreamReader("grammar.txt");
            while (!file.EndOfStream)
            {
                string[] line = file.ReadLine().Split('=', ':');
                if (line.Length > 0)
                {
                    GrammarTokenMatch match = new GrammarTokenMatch();
                    match.type = line[0].Trim();
                    match.precedence = line.Length > 2 ? int.Parse(line[2]) : int.MaxValue;
                    match.matches = line[1].Split(' ').Select((x)=>x.Trim()).Where((x)=>x!="").ToArray();
                    grammarMatches.Add(match);
                }
            }
            file.Close();
            return grammarMatches;
        }
        static void OldMain(string[] args)
        {
            System.Diagnostics.Stopwatch watch = new System.Diagnostics.Stopwatch();
            watch.Start();
            int count = 100000000;
            double answer = 0;
            watch.Start();
            for (int i = 0; i < count; i++) { answer = Math.Sqrt(Math.Tan(i)); }
            watch.Stop();
            Console.WriteLine(watch.ElapsedMilliseconds);
            watch.Reset();
            watch.Start();
            Parallel.For(0, count, (i) => answer = Math.Sqrt(Math.Tan(i)));
            watch.Stop();
            Console.WriteLine(watch.ElapsedMilliseconds);
            Console.ReadKey();
            return;
            //"var number:int:=.0\nvar text:string:=\"yo yo yo, this shouldn't match a var\""
            var file = new System.IO.StreamReader("test.t");
            var output = new System.IO.StreamWriter("test.txt");
            string input = file.ReadToEnd() + " ";
            file.Close();
            //Console.WriteLine(input);
            var grammar = BuildGrammar();
            var lexicalTokens = BuildTSharpLexer();
            List<Token> tokens = LexicalAnalyzer(lexicalTokens, input);
            PrintLexicalAnalysis(tokens, output);
            output.Close();
            GrammarTokenMatch.Matches(grammar, lexicalTokens, tokens, 0, tokens.Count, "expression");
            
            //string line = ConvertToCSharpPreDef(LexicalAnalyzer(BuildTSharpLexer(), input));
            //Console.WriteLine(line);
            //output.WriteLine(line);
            Console.WriteLine("==============================================");
            Console.WriteLine("done");
            Console.ReadKey();
        }
        static void Main(string[] args)
        {
        }
    }
}
