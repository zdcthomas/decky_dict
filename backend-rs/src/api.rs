use super::x;
use usdpl_back::core::serdes::Primitive;

pub const VERSION: &'static str = env!("CARGO_PKG_VERSION");
pub const NAME: &'static str = env!("CARGO_PKG_NAME");

pub fn hello(params: Vec<Primitive>) -> Vec<Primitive> {
    if let Some(Primitive::String(name)) = params.get(0) {
        vec![Primitive::String(format!("Hello {}", name))]
    } else {
        vec![]
    }
}

pub fn echo(params: Vec<Primitive>) -> Vec<Primitive> {
    params
}

pub fn version(_: Vec<Primitive>) -> Vec<Primitive> {
    vec![VERSION.into()]
}

pub fn name(_: Vec<Primitive>) -> Vec<Primitive> {
    vec![format!(
        "Name: {}, X11 Setup: {}",
        NAME,
        x::connect_and_read_setup().unwrap_or(String::from("ERROR GETTING SETUP"))
    )
    .into()]
}
