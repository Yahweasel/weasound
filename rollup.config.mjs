import * as fs from "fs/promises";
import typescript from "@rollup/plugin-typescript";
import terser from "@rollup/plugin-terser";

export default {
    input: "src/main.ts",
    output: [
        {
            file: "dist/weasound.js",
            format: "umd",
            name: "Weasound"
        }, {
            file: "dist/weasound.min.js",
            format: "umd",
            name: "Weasound",
            plugins: [terser({
                format: {
                    preamble: await fs.readFile("src/license.js", "utf8")
                }
            })]
        }
    ],
    context: "this",
    plugins: [
        typescript()
    ]
};
