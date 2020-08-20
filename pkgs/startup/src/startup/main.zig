const std = @import("std");
const logo = @embedFile("../idra.logo");

pub usingnamespace @cImport({
    @cInclude("startup/reboot.h");
    @cInclude("startup/mknod.h");
});

pub fn main() anyerror!void {
    std.debug.print(logo, .{});
    std.debug.print("\n\nstarting up\n", .{});

    try std.fs.makeDirAbsolute("/dev");
    _ = do_mknodes();

    do_reboot();
}
