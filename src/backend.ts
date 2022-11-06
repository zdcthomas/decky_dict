import { init_usdpl, target, init_embedded, call_backend } from "usdpl-front";

const USDPL_PORT: number = 44444;

// Utility

export function resolve(promise: Promise<any>, setter: any) {
  (async function () {
    let data = await promise;
    if (data != null) {
      console.debug("Got resolved", data);
      setter(data);
    } else {
      console.warn("Resolve failed:", data);
    }
  })();
}

export function execute(promise: Promise<any[]>) {
  (async function () {
    let data = await promise;
    console.debug("Got executed", data);
  })();
}

export async function initBackend() {
  // init usdpl
  await init_embedded();
  init_usdpl(USDPL_PORT);
  console.log("USDPL started for framework: " + target());
  //setReady(true);
}

// Back-end functions

export async function name(): Promise<boolean> {
  return (await call_backend("name", []))[0];
}
