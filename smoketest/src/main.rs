

fn main() {
    let f = libm::hypot(1_f64, 1_f64);
    unsafe { libc::dlopen(b"libc" as *const _ as _, 0); }
    println!("Hello, world! {f}");
}
