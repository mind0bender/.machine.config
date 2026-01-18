import jsonc from "jsonc/safe";
import fs from "fs/promises";

const configFilePath: string = "~/.config/fastfetch/config.jsonc";
const imgFilePath: string = "~/.machine.config/m0b.txt";

function updateLogo(): Promise<void> {
  return new Promise<void>((resolve: ()=>void, reject: (reasons?: unknown) => void) => {
    fs.readFile(configFilePath, "utf-8").then((dataString: string) => {
      const [err, dataObj] = jsonc.parse(dataString);
      if(err) throw new Error(`Failed to parse JSONC: ${err.message}`);
      dataObj["$schema"]["logo"]["type"] = "file";
      dataObj["$schema"]["logo"]["source"] = imgFilePath;

      const updatedJSONCStr: string = jsonc.stringify(dataObj, null, 2);

      console.log(updatedJSONCStr);

      fs.writeFile(configFilePath, updatedJSONCStr, "utf-8").then(() => {
        console.log("Successfully updated fastfetch config.");
        resolve()
      }).catch(reject);
    }).catch(reject);
  });
}
