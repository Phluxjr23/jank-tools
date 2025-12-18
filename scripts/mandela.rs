use std::fs;
use std::time::{SystemTime, UNIX_EPOCH};
use std::thread;
use std::time::Duration;

fn main() {
    let fake_files = vec![
        "important_document.pdf",
        "childhood_photo.jpg",
        "secret_recipe.txt",
        "that_song_you_loved.mp3",
        "your_backup.zip",
        "memories.dat",
        "the_truth.txt",
        "what_you_forgot.doc"
    ];
    
    let now = SystemTime::now()
        .duration_since(UNIX_EPOCH)
        .unwrap()
        .as_nanos();
    
    let fake = fake_files[(now % fake_files.len() as u128) as usize];
    
    println!("strange... there's a file in this directory you forgot about...");
    println!();
    thread::sleep(Duration::from_secs(1));
    println!("it's called: {}", fake);
    println!();
    thread::sleep(Duration::from_secs(1));
    
    if let Ok(entries) = fs::read_dir(".") {
        for entry in entries {
            if let Ok(entry) = entry {
                if let Some(name) = entry.file_name().to_str() {
                    if name == fake {
                        println!("wait... it's here. it's real.");
                        return;
                    }
                }
            }
        }
    }
    
    println!("but... it's not here.");
    println!();
    thread::sleep(Duration::from_secs(1));
    println!("it never was.");
    println!();
    thread::sleep(Duration::from_secs(1));
    println!("wake up.");
}
