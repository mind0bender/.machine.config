import { ok } from "assert";
import { updateFastFetchLogo } from "./fastfetch";

ok(Bun.argv.length > 2, "Please provide a tool to setup");
const tool: string = Bun.argv[2] as string;

console.log(`Setting up ${tool}...`);

switch (tool) {
  case "fastfetch": {
    updateFastFetchLogo();
  }
}
