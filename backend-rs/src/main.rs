mod api;

use simplelog::{LevelFilter, WriteLogger};
use usdpl_back::Instance;

const PORT: u16 = 44444;

fn main() -> Result<(), ()> {
    WriteLogger::init(
        #[cfg(debug_assertions)]
        {
            LevelFilter::Debug
        },
        #[cfg(not(debug_assertions))]
        {
            LevelFilter::Info
        },
        Default::default(),
        std::fs::File::create("/tmp/decky_dict.log").unwrap(),
    )
    .unwrap();

    log::info!("Starting back-end ({} v{})", api::NAME, api::VERSION);
    println!("Starting back-end ({} v{})", api::NAME, api::VERSION);

    Instance::new(PORT)
        .register("echo", api::echo)
        .register("hello", api::hello)
        .register("version", api::version)
        .register("name", api::name)
        .run_blocking()
}
