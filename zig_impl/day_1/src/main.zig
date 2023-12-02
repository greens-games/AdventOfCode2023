const std = @import("std");
const root = @import("root");
const ArrayList = std.ArrayList;
const testing = std.testing;

pub fn main() !void {
    const input = [_][]const u8{ "1abc2", "pqr3stu8vwx", "a1b2c3d4e5f", "treb7uchet" };

    for (input) |c| {
        const curr_len: usize = c.len;
        _ = curr_len;
        std.debug.print("{c}", .{c[0]});
    }
}

fn find_first_digit(s: []const u8) u8 {
    for (s) |char| {
        _ = char;
    }
}

fn find_last_digit(s: []const u8) u8 {
    _ = s;
}

fn is_digit(c: u8) !bool {
    const allocator = std.heap.page_allocator;
    var list = ArrayList(u8).init(allocator);

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
            list.deinit();
            return true;
        }
    }
    list.deinit();
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
