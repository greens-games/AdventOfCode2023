const std = @import("std");
const root = @import("root");
const ArrayList = std.ArrayList;
const testing = std.testing;
const allocator = std.heap.page_allocator;

pub fn main() !void {
    const input = [_][]const u8{ "1abc2", "pqr3stu8vwx", "a1b2c3d4e5f", "treb7uchet" };

    var sum: u8 = 0;

    for (input) |s| {
        const first_digit: u8 = try find_first_digit(s);
        const second_digit: u8 = try find_last_digit(s);
        const digits_concate = try std.fmt.allocPrint(allocator, "{d}{d}", .{ first_digit, second_digit });

        sum += try std.fmt.parseInt(u8, digits_concate, 10);
    }
    std.debug.print("SUM IS: {}\n", .{sum});
}

fn find_first_digit(s: []const u8) !u8 {
    for (s) |char| {
        if (try is_digit(char))
            return char - '0';
    }

    return 11;
}

fn find_last_digit(s: []const u8) !u8 {
    var length: usize = s.len - 1;

    while (length >= 0) {
        const char: u8 = s[length];
        if (try is_digit(char))
            return char - '0';
        length -= 1;
    }

    return 11;
}

fn is_digit(c: u8) !bool {
    var list = ArrayList(u8).init(allocator);
    defer list.deinit();

    try list.append('0');
    try list.append('1');
    try list.append('2');
    try list.append('3');
    try list.append('4');
    try list.append('5');
    try list.append('6');
    try list.append('7');
    try list.append('8');
    try list.append('9');

    for (list.allocatedSlice()) |item| {
        if (c == item) {
            return true;
        }
    }
    return false;
}

test "day1 Test" {}

test "is_digit test return true" {
    const result: bool = try is_digit('0');
    try testing.expectEqual(true, result);
}

test "is_digit test return false" {
    const result: bool = try is_digit('a');
    try testing.expectEqual(false, result);
}

test "find_first_digit return 1" {
    const s = "ab1";
    const result: u8 = try find_first_digit(s);
    try testing.expectEqual(@as(u8, 1), result);
}

test "find_last_digit return 2" {
    const s = "1b2";
    const result: u8 = try find_last_digit(s);
    try testing.expectEqual(@as(u8, 2), result);
}
