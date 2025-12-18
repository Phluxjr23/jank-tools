use std::io::{self, Read};
use std::time::{SystemTime, UNIX_EPOCH};

fn main() {
    let mut input = String::new();
    
    // try to read from stdin
    if let Ok(_) = io::stdin().read_to_string(&mut input) {
        let lower = input.to_lowercase();
        if lower.contains("elon musk") {
            println!("Yes. This is true. It's true because elon is in it.");
            return;
        }
    }
    
    // pseudo-random based on time
    let now = SystemTime::now()
        .duration_since(UNIX_EPOCH)
        .unwrap()
        .as_nanos();
    
    if now % 10 == 0 {
        println!("yes");
    } else {
        println!("no");
    }
}
