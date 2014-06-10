TSharp
======

A variation of the Turing programming language that runs on .NET. Aims to be mostly syntax/feature compatible

Goals
---

Create a very simple compiler by making use of Parser Expression Grammars and Rolsyn's APIs. The parser parses the source into Roslyn source code nodes, and then passes off the rest of the compilation to Roslyn.

The aim of this project is to get Turing up and running on .NET, therefore making it cross-platform and allowing access to the full range of .NET libraries.

The project seeks to run the majority of Turing programs without modification, but it is explicitly not a goal of this project to be 100% compatible with the current version of Turing. There are simply some features that aren't worth implementing (such as the `cheat` function).

Roadmap
---

+ 0.1 - Proof of concept, basic Turing syntax compiled and executed
+ 0.2 - Ability to import .NET libraries into Turing programs
+ 0.3 - Majority of non-OOP functionality
+ 0.4 - Majority of functionality
+ 0.5 - Turing standard library implemented 