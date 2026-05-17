import type { BunFile } from "bun";
import { homedir } from "os";
import { join } from "path";

const home: string = homedir();

interface FastFetchConfig {
  logo: {
    type: string;
    source: string;
    color: {
      [key: string]: string;
    };
    padding: {
      top: number;
      right: number;
      left: number;
    };
  };
}

const configFilePath: string = join(
  home,
  ".config",
  "fastfetch",
  "config.jsonc",
);
const imgFilePath: string = join(home, ".machine.config", "m0b.txt");

export function updateFastFetchLogo(): Promise<void> {
  return new Promise<void>(
    (resolve: () => void, reject: (reasons?: unknown) => void): void => {
      console.log("reading config file...");
      const file: BunFile = Bun.file(configFilePath);
      file
        .text()
        .then((fileContent: string) => {
          console.log(`parsing ${configFilePath}...`);
          const config: FastFetchConfig = Bun.JSONC.parse(
            fileContent,
          ) as FastFetchConfig;
          config["logo"]["type"] = "file";
          config["logo"]["source"] = imgFilePath;
          config["logo"]["color"] = {
            "1": "green",
          };
          config["logo"]["padding"] = {
            top: 2,
            right: 6,
            left: 2,
          };

          Object.keys(config.logo).forEach((key: string): void => {
            console.log(
              `updated logo.${key} to ${JSON.stringify(config.logo[key as keyof typeof config.logo], null, 2)}`,
            );
          });

          console.log(`writing updated config to ${configFilePath}...`);

          const updatedJSONCStr: string = JSON.stringify(config, null, 2);

          Bun.write(configFilePath, updatedJSONCStr).then((): void => {
            console.log("config updated successfully!");
            resolve();
          });
        })
        .catch(reject);
    },
  );
}
