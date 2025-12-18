use std::fs::File;
use std::path::Path;
use std::time::{SystemTime, UNIX_EPOCH};

fn main() {
    let extensions = vec![
        "py", "html", "htm", "c", "cake", "png", "cheese", 
        "txt", "md", "rs", "go", "cpp", "js", "json", "xml",
        "yeet", "bruh", "sus", "based", "cringe"
    ];
    
    let words = vec![
        "random", "file", "yeet", "bruh", "sus", "based",
        "jank", "cursed", "blessed", "test", "demo", "sample",
        "thing", "stuff", "data", "content", "meme"
    ];
    
    let now = SystemTime::now()
        .duration_since(UNIX_EPOCH)
        .unwrap()
        .as_nanos();
    
    let name = words[(now % words.len() as u128) as usize];
    let ext = extensions[(now / 100 % extensions.len() as u128) as usize];
    let filename = format!("{}.{}", name, ext);
    
    if Path::new(&filename).exists() {
        println!("file {} already exists, try again", filename);
        return;
    }
    
    match File::create(&filename) {
        Ok(_) => println!("created {}", filename),
        Err(e) => println!("error creating file: {}", e),
    }
}
