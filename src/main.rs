
use warp::Filter;
use log::info;

#[tokio::main]
async fn main() {
  pretty_env_logger::init();


  let index = warp::path::end()
    .and(warp::fs::file("public/index.html"));

  let source = warp::path("assets")
    .and(warp::fs::dir("public/assets"));

  let sw = warp::path!("sw.js")
    .and(warp::fs::file("public/sw.js"));

  let files = warp::fs::dir("public/");

  let compressed = warp::get()
    .and(
      index
        .or(source)
        .or(sw)
    )
    .with(warp::compression::brotli());

  

  let catch_all = warp::any()
    .map(|| {
      warp::redirect(warp::http::Uri::from_static("/"))
    });

  let routes = compressed
    .or(files)
    .or(catch_all)
    .with(warp::log("REQ"));


  let host_addr = ([0, 0, 0, 0], 3030);
  info!("Starting server on: {:?}", host_addr);

  warp::serve(routes)
    .tls()
    .cert_path("certs/cert.pem")
    .key_path("certs/key.pem")
    .run(host_addr)
    .await;
}
