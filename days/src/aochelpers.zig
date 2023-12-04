const std = @import("std");

pub const AdventDay = enum {
    day_01,
    day_02,
    day_03,
    day_04,
    day_05,
    day_06,
    day_07,
    day_08,
    day_09,
    day_10,
    day_11,
    day_12,
    day_13,
    day_14,
    day_15,
    day_16,
    day_17,
    day_18,
    day_19,
    day_20,
    day_21,
    day_22,
    day_23,
    day_24,
};

pub fn loadInputFile(day: AdventDay) ![]u8 {
    const path = switch (day) {
        .day_01 => "inputs/day_01.txt",
        .day_02 => "inputs/day_02.txt",
        .day_03 => "inputs/day_03.txt",
        .day_04 => "inputs/day_04.txt",
        .day_05 => "inputs/day_05.txt",
        .day_06 => "inputs/day_06.txt",
        .day_07 => "inputs/day_07.txt",
        .day_08 => "inputs/day_08.txt",
        .day_09 => "inputs/day_09.txt",
        .day_10 => "inputs/day_10.txt",
        .day_11 => "inputs/day_11.txt",
        .day_12 => "inputs/day_12.txt",
        .day_13 => "inputs/day_13.txt",
        .day_14 => "inputs/day_14.txt",
        .day_15 => "inputs/day_15.txt",
        .day_16 => "inputs/day_16.txt",
        .day_17 => "inputs/day_17.txt",
        .day_18 => "inputs/day_18.txt",
        .day_19 => "inputs/day_19.txt",
        .day_20 => "inputs/day_20.txt",
        .day_21 => "inputs/day_21.txt",
        .day_22 => "inputs/day_22.txt",
        .day_23 => "inputs/day_23.txt",
        .day_24 => "inputs/day_24.txt",
    };
    var buffer: [1024 * 100]u8 = undefined;
    return try std.fs.cwd().readFile(
        path,
        &buffer,
    );
}
