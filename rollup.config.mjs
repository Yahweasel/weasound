import * as fs from "fs/promises";
import nodeResolve from "@rollup/plugin-node-resolve";
import commonjs from "@rollup/plugin-commonjs";
import terser from "@rollup/plugin-terser";

export default {
    input: "src/main.js",
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
    plugins: [nodeResolve(), commonjs()]
};
