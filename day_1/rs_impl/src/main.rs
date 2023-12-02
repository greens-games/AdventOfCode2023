use std::{path::Path, fs::File, io::{Read, }};

fn main() {
    let input = vec!["1abc2", "pqr3stu8vwx", "a1b2c3d4e5f", "treb7uchet"];

    let s = get_input();

    let mut sum = 0;

    for line in s.split("\n") {
        let digits = find_digits(line);
        let digit0_str = digits.0.to_string();
        let digit1_str = digits.1.to_string();
        let digits_str = format!("{digit0_str}{digit1_str}");
        sum += digits_str.parse::<i32>().unwrap(); 
    }

    println!("SUM = {sum}");
}

fn get_input() -> String {
    let path = Path::new("input.txt");
    let display = path.display();

    let mut file = match File::open(&path) {
        Err(err) => panic!("couldn't open file {} {}", display, err),
        Ok(file) => file,
    };

    let mut s = String::from("");

    match file.read_to_string(&mut s) {
        Err(err) => panic!("could not read file {}", err),
        Ok(size) => println!("File read properly")
    };

    s
}

fn find_digits(s: &str) -> (i32,i32) {
    let i = match s.find(|c: char| (c >= '0') && (c <= '9')) {
        None => s.len() + 1,
        Some(value) => value,
    };

    let ri = match s.rfind(|c: char| (c >= '0') && (c <= '9')) {
        None => s.len() + 1,
        Some(value) => value,
    };

    if i > s.len() {
        return (-1, -1);
    }
    let c = s.chars().nth(i).unwrap();
    let rc = s.chars().nth(ri).unwrap();
    (c.to_digit(10).unwrap() as i32, rc.to_digit(10).unwrap() as i32)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn find_first_test_no_digit() {
        assert_eq!(find_digits("abc"), (-1,-1));
    }

    #[test]
    fn find_first_test_has_digit() {
        assert_eq!(find_digits("1abc5"), (1,5));
    }

    #[test]
    fn read_intput_test() {
        get_input();
    }
}
