using GLib;

class ParadoxGenerator {
    private string[] paradoxes;
    
    public ParadoxGenerator() {
        paradoxes = {
            "This statement is false.|Wait, if it's false, then it's true.|But if it's true, then it's false.|ERROR: Logic has left the chat.",
            
            "The next line is true.|The previous line is false.|...|You've been stuck in this loop for 0.3 seconds.|It felt like longer, didn't it?",
            
            "Do not read this message.|...|You just read the message telling you not to read it.|By obeying, you disobeyed.|Nice job breaking reality.",
            
            "Pinocchio says: 'My nose will grow now.'|If it grows, he told the truth, so it shouldn't grow.|If it doesn't grow, he lied, so it should grow.|Pinocchio.exe has stopped responding.",
            
            "You traveled back in time.|You prevented this command from being written.|But if it was never written, you couldn't have run it.|But you just ran it.|Time is a flat circle.",
            
            "The barber shaves all those who don't shave themselves.|Does the barber shave himself?|If yes: he only shaves those who don't shave themselves (contradiction).|If no: then he doesn't shave himself, so he should shave himself (contradiction).|The barber has quit and moved to another town.",
            
            "This command will execute unexpectedly.|But you just expected it to execute unexpectedly.|So it's not unexpected anymore.|ERROR: Expectation overflow.",
            
            "This command replaces one line of its own code each time it runs.|After enough runs, is it still the same command?|Philosophy.exe not found.|Did you expect an answer? That's adorable.",
            
            "Everything I say is a lie.|Including that statement.|And that one.|And this one.|Help.",
            
            "Can sudo create a file it can't delete?|Checking permissions...|ERROR: Paradox detected in root privileges.|Reality.conf is corrupted.",
            
            "A crocodile steals your CPU.|It promises to return it if you correctly predict what it will do.|You predict: 'You will not return my CPU.'|If correct, it won't return it (making you wrong).|If wrong, it returns it (making you right).|Your CPU is gone. The crocodile won.",
            
            "This script was sent back in time to write itself.|If it wrote itself, who wrote the original?|There is no original.|You're running a program that has no author.|Spooky.",
            
            "To maintain tolerance, we must not tolerate intolerance.|But isn't refusing to tolerate intolerance... intolerant?|ERROR: Philosophy stack overflow.|Karl Popper is typing...",
            
            "Removing one line of code doesn't make a program 'not a program'.|Removing another line doesn't either.|Eventually you have no code left.|At what point did it stop being a program?|Answer: when you ran this command.",
            
            "Achilles races a tortoise. The tortoise has a head start.|Achilles reaches where the tortoise was.|But the tortoise moved forward a bit.|Achilles reaches that point.|But the tortoise moved again.|This process continues infinitely.|ERROR: Segmentation fault (infinite recursion).|Achilles is still running. The tortoise won.",
            
            "This command can modify its own rules.|New rule: This command cannot modify its own rules.|...|...|sudo rm -rf paradox|Access denied: file is modifying itself.",
            
            "The smallest uninteresting number is interesting.|Therefore it's not uninteresting.|Therefore it's not the smallest uninteresting number.|Loop detected.|All numbers are interesting now. You're welcome.",
            
            "If this statement is true, then you owe me a cookie.|Assume it's true. Then you owe me a cookie.|But we assumed it was true to prove it's true.|Logic has imploded.|You still owe me a cookie though.",
            
            "The smallest number that cannot be described in under 20 words.|But I just described it in under 20 words.|Therefore it can be described in under 20 words.|Therefore it's not the smallest number that cannot be described in under 20 words.|Numbers.h: No such file or directory.",
            
            "ERROR: This command only works when it doesn't work.|Status: Successfully failed.|Exit code: Yes.|Task failed successfully."
        };
    }
    
    public void run() {
        // Pick random paradox
        var random_index = Random.int_range(0, paradoxes.length);
        var paradox = paradoxes[random_index];
        
        // Split by pipe and print with delays
        var lines = paradox.split("|");
        foreach (var line in lines) {
            stdout.printf("%s\n", line);
            stdout.flush();
            Thread.usleep(800000); // 0.8 seconds in microseconds
        }
    }
}

int main() {
    var generator = new ParadoxGenerator();
    generator.run();
    return 32; // The ACTUAL answer to life (L+I+F+E = 12+9+6+5)
}
