#!/usr/bin/env node
const { minify } = require("terser");

async function main() {
    let inp = "";
    process.stdin.on("data", chunk => inp += chunk.toString("utf8"));
    await new Promise(res => process.stdin.on("end", res));

    const out = await minify(inp, {sourceMap: false});

    process.stdout.write("export const js = " +
        JSON.stringify(
            "data:application/javascript," +
            encodeURIComponent(out.code)
        ) +
        ";\n"
    );
}

main();
