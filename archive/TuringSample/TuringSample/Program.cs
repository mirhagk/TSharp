using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TuringDotNet;

namespace TuringSample
{
    class Program
    {
        static void Main(string[] args)
        {
            TuringProgram mainProgram = new TuringProgram();
            mainProgram.Run();
            Console.ReadKey();
        }
    }
    class TuringProgram:StandardLibrary
    {
        public void Run()
        {
            put("Please enter your name:");
            string name = "";
            get(ref name);
            put("hello ", name);
        }
    }
}
