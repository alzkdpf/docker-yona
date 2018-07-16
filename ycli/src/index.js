#!/usr/bin/env node
const program = require('commander');
const pkg = require('../package.json');
const fs = require('fs');
const check = require('check-types');
const replace = require('replace-in-file');
const co = require('co')
const prompt = require('co-prompt')
const chalk = require('chalk')
const join = require('path').join

let gen = () => {
  let resources_path = join(__dirname, '.', 'assets')
  let cwd_path = process.cwd();

  if(fs.existsSync(`${cwd_path}/yona`) === false)
  {
    console.log(chalk.red("** does not found yona directory **"));
    process.exit(1);
  }

  co(function*() {
    // container name check
    let container_name = "";
    container_name = yield prompt("container_name (default: yona): ");
    if(check.emptyString(container_name)){
      container_name = "yona";
      process.stdout.write(`message - ${err}\n`);
    }

    // port number check
    let port = -1;
    port = yield prompt("port (default:9000): ");
    if(port < 0){
      port = 9000;
    }

    // YONA_DATA path check 
    let yona_data = "";
    while(check.emptyString(yona_data)){
      yona_data = yield prompt(chalk.yellow("*YONA_DATA_PATH (required): "));
    }

    // generate path setting
    let compsoe_path = `${cwd_path}/docker-compose.yml`

    if (fs.existsSync(yona_data) === false)
    {
      fs.mkdirSync(yona_data);
    }

    // template copy
    fs.writeFileSync(compsoe_path, fs.readFileSync(`${resources_path}/docker-compose.temp`));

    // keyword change
    const options = {
      files: compsoe_path,
      from: [/CONTAINER_NAME/g,/PORT/g,/YONA_DATA_PATH/g],
      to: [container_name, port, yona_data]
    };

    try {
      replace.sync(options);
    }
    catch (error) {
      throw new Error(error);
    }

  }).then( () => {
    process.exit(0);
  }, err => {
    process.stdout.write(`message - ${err}\n`);
    process.exit(0);
  });
}

program
  .version(pkg.version)
  .command('docker')
  .description('generate composer file')
  .action(gen);

program.parse(process.argv);

if (program.args.length === 0) program.help();