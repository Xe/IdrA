const std = @import("std");
const logo = @embedFile("../idra.logo");

pub usingnamespace @cImport({
    @cInclude("startup/reboot.h");
});

pub fn main() anyerror!void {
    std.log.info(logo, .{});
    std.log.info("\nstarting up", .{});

    do_reboot();
}
