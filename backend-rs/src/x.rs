use std::fmt::Pointer;
use xcb::{Result, Connection};

pub fn connect_and_read_setup() -> Result<String> {
    let (conn, screen) = xcb::Connection::connect(None)?;
    let setup = conn.get_setup();
    Ok(format!("Setup: {:?}", setup))
}
