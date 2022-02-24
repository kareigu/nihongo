FROM node:alpine as elm_builder

WORKDIR /usr/src/nihongo

COPY ./src ./src
COPY ./public ./public
COPY ./elm.json ./elm.json
COPY ./package.json ./package.json
COPY ./postcss.config.js ./postcss.config.js
COPY ./tailwind.config.js ./tailwind.config.js
COPY ./yarn.lock ./yarn.lock


FROM rust:buster as rust_builder

WORKDIR /usr/src

RUN USER=root cargo new --bin nihongo

WORKDIR /usr/src/nihongo

COPY ./Cargo.toml ./Cargo.toml
COPY ./Cargo.lock ./Cargo.lock

RUN cargo build --release
RUN rm ./target/release/deps/nihongo*
RUN rm src/*.rs

COPY ./src ./src
RUN cargo build --release

FROM debian:buster as runner

WORKDIR /usr/src/nihongo

COPY --from=rust_builder /usr/src/nihongo/target/release/nihongo ./nihongo
COPY --from=elm_builder /usr/src/nihongo/public ./public

CMD ./nihongo