const std = @import("std");
const logo = @embedFile("../idra.logo");

pub usingnamespace @cImport({
    @cInclude("startup/reboot.h");
});

pub fn main() anyerror!void {
    std.debug.print(logo, .{});
    std.debug.print("\n\nstarting up\n", .{});

    do_reboot();
}
