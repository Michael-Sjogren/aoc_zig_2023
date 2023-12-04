const std = @import("std");

const fmt = std.fmt;
const testing = std.testing;
const aochelpers = @import("aochelpers.zig");
const test_input: []const u8 =
    \\two1nine
    \\eightwothree
    \\abcone2threexyz
    \\xtwone3four
    \\4nineeightseven2
    \\zoneight234
    \\7pqrstsixteen
    \\one
;
// 12
// 38
// 15
// 77
// 11
// 44
const DigitTokenizer = struct {
    slice: []const u8,
    offset: usize = 0,

    pub fn next(self: *DigitTokenizer) ?Digits {
        if (self.offset >= self.slice.len) return null;
        if (std.ascii.isDigit(self.slice[self.offset])) {
            const num = std.fmt.parseUnsigned(u32, &.{self.slice[self.offset]}, 10) catch 0;
            self.offset += 1;
            return @enumFromInt(num);
        }

        const token = getDigitFromWord(self.slice[self.offset..]);

        const token_name = std.enums.tagName(Digits, token) orelse return null;
        if (token == .nondigit) {
            self.offset += 1;
        } else {
            self.offset += token_name.len;
        }
        return token;
    }

    pub fn getDigitFromWord(slice: []const u8) Digits {
        if (slice.len < 3) return .nondigit;
        if (std.mem.eql(u8, slice[0..3], "one")) {
            return .one;
        } else if (std.mem.eql(u8, slice[0..3], "two")) {
            return .two;
        } else if (slice.len >= 5 and std.mem.eql(u8, slice[0..5], "three")) {
            return .three;
        } else if (slice.len >= 4 and std.mem.eql(u8, slice[0..4], "four")) {
            return .four;
        } else if (slice.len >= 4 and std.mem.eql(u8, slice[0..4], "five")) {
            return .five;
        } else if (std.mem.eql(u8, slice[0..3], "six")) {
            return .six;
        } else if (slice.len >= 5 and std.mem.eql(u8, slice[0..5], "seven")) {
            return .seven;
        } else if (slice.len >= 5 and std.mem.eql(u8, slice[0..5], "eight")) {
            return .eight;
        } else if (slice.len >= 4 and std.mem.eql(u8, slice[0..4], "nine")) {
            return .nine;
        }

        return .nondigit;
    }
};

const Digits = enum(u8) {
    one = 1,
    two = 2,
    three = 3,
    four = 4,
    five = 5,
    six = 6,
    seven = 7,
    eight = 8,
    nine = 9,
    nondigit = 11,
};

test "the first numbers" {
    testing.log_level = .debug;
    //const input = test_input;
    const input = try aochelpers.loadInputFile(.day_01);
    var lineItr = std.mem.splitSequence(u8, input, "\n");
    var total: u32 = 0;

    while (lineItr.next()) |line| {
        var digitTokenizer = DigitTokenizer{
            .offset = 0,
            .slice = line,
        };

        var first: ?u32 = null;
        var last: ?u32 = null;

        while (digitTokenizer.next()) |digit| {
            switch (digit) {
                .nondigit => continue,
                else => {
                    const n = @intFromEnum(digit);
                    if (first == null) {
                        first = n;
                    } else {
                        last = n;
                    }
                },
            }
        }
        var n: u32 = 0;
        if (first) |v| {
            n = v * 10 + (last orelse v);
        }
        total += n;
        std.log.debug("{d} {s}", .{ n, line });
    }
    std.log.debug("{d} total", .{total});
}
