#!/usr/bin/env bash

generate-icons() {
  node --input-type=module -e "
  import { generateSocialIcons } from './src/generate.js';
  generateSocialIcons();
  "
}

build() {
  generate-icons

  # why do I transpile?
  pnpm babel src \
    --copy-files \
    --out-dir "./dist" \
    --ignore "src/**/*.{spec,test}.*" \
    --extensions ".ts"
}

dev() {
  pnpm vite
}

test:js() {
  pnpm playwright test -c playwright-ct.config.ts
}

test:lint() {
  pnpm eslint src
}

test:ts() {
  pnpm tsc
}

test:() {
  test:js;
  test:lint;
  test:ts;
}

"$@"
