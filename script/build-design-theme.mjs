import { execFileSync } from "node:child_process"
import { mkdirSync, readFileSync, renameSync, rmSync, writeFileSync } from "node:fs"
import { dirname, resolve } from "node:path"

const root = resolve(import.meta.dirname, "..")
const source = resolve(root, "DESIGN.md")
const destination = resolve(root, "app/assets/stylesheets/design/generated-theme.css")
const temporary = `${destination}.tmp`
const executable = resolve(root, "node_modules/.bin", process.platform === "win32" ? "designmd.cmd" : "designmd")

const generated = execFileSync(executable, ["export", "--format", "css-tailwind", source], {
  cwd: root,
  encoding: "utf8"
})

const header = "/* Generated from DESIGN.md by `yarn design:build`. Do not edit directly. */\n"
const output = `${header}${generated.trim()}\n`

if (process.argv.includes("--check")) {
  let current

  try {
    current = readFileSync(destination, "utf8")
  } catch {
    console.error("Generated design theme is missing. Run `yarn design:build`.")
    process.exit(1)
  }

  if (current !== output) {
    console.error("Generated design theme is stale. Run `yarn design:build`.")
    process.exit(1)
  }

  console.log("Generated design theme is current.")
  process.exit(0)
}

mkdirSync(dirname(destination), { recursive: true })

try {
  writeFileSync(temporary, output)
  renameSync(temporary, destination)
} finally {
  rmSync(temporary, { force: true })
}
