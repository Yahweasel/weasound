import * as fs from "fs/promises";
import typescript from "@rollup/plugin-typescript";
import terser from "@rollup/plugin-terser";

const terserPlugin = [terser({
    format: {
        preamble: await fs.readFile("src/license.js", "utf8")
    }
})];

export default {
    input: "src/main.ts",
    output: [
        {
            file: "dist/weasound.mjs",
            format: "es"
        },
        {
            file: "dist/weasound.min.mjs",
            format: "es",
            plugins: terserPlugin
        },
        {
            file: "dist/weasound.js",
            format: "umd",
            name: "Weasound"
        },
        {
            file: "dist/weasound.min.js",
            format: "umd",
            name: "Weasound",
            plugins: terserPlugin
        }
    ],
    context: "this",
    plugins: [
        typescript()
    ]
};
