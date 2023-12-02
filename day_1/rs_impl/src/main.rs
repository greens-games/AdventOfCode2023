
fn main() {
    let input = vec!["1abc2", "pqr3stu8vwx", "a1b2c3d4e5f", "treb7uchet"];

    let mut sum = 0;
    for val in input {
        let digits = find_digits(val);
        let digit0_str = digits.0.to_string();
        let digit1_str = digits.1.to_string().to_owned();
        let digits_str = format!("{digit0_str}{digit1_str}");
        sum += digits_str.parse::<i32>().unwrap();
    }

    println!("SUM = {sum}");
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

}
