const std = @import("std");
const ChildProcess = std.ChildProcess;
const Allocator = std.mem.Allocator;
const alloc = std.heap.c_allocator;
const logo = @embedFile("../idra.logo");

pub usingnamespace @cImport({
    @cInclude("startup/reboot.h");
});

pub fn main() anyerror!void {
    std.debug.print(logo, .{});
    std.debug.print("\n\nstarting up\n", .{});

    try mount("proc", "/proc", "proc");
    try mount("devtmpfs", "/dev", "devtmpfs");
    try ip_addr();

    do_reboot();
}

fn mount(what: []const u8, where: []const u8, kind: []const u8) anyerror!void {
    var dir = try std.fs.cwd().openDir("/", .{});
    defer dir.close();
    var child_result = try ChildProcess.exec(.{
       .allocator = alloc,
       .argv = &[_][]const u8{ "/bin/mount", "-t", kind, what, where },
       .cwd_dir = dir,
    });
    defer deinitResult(alloc, child_result);
}

fn ip_addr() anyerror!void {
    // https://github.com/firecracker-microvm/firecracker/blob/master/docs/network-setup.md
    const ip = std.os.getenv("ip_address") orelse unreachable;
    const gateway = std.os.getenv("default_route") orelse unreachable;

    var dir = try std.fs.cwd().openDir("/", .{});
    defer dir.close();
    var addr_result = try ChildProcess.exec(.{
        .allocator = alloc,
        .argv = &[_][]const u8{ "/bin/ip", "addr", "add", ip, "dev", "eth0" },
        .cwd_dir = dir,
    });
    defer deinitResult(alloc, addr_result);

    var link_result = try ChildProcess.exec(.{
        .allocator = alloc,
        .argv = &[_][]const u8{ "/bin/ip", "link", "set", "eth0", "up" },
        .cwd_dir = dir,
    });
    defer deinitResult(alloc, link_result);

    var route_result = try ChildProcess.exec(.{
        .allocator = alloc,
        .argv = &[_][]const u8{ "/bin/ip", "route", "add", "default", "via", gateway, "dev", "eth0" },
        .cwd_dir = dir,
    });
    defer deinitResult(alloc, route_result);
}

fn deinitResult(allocator: *Allocator, result: ChildProcess.ExecResult) void {
    allocator.free(result.stderr);
    allocator.free(result.stdout);
}
