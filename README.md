# Node App Setup Instruction
While there are plenty of tools that help with building, compiling, and managing node projects, I prefer to use bash scripts for mine. This requires some setup which I have automated also using bash. This is how I set up my node project setup automation.

## Setup
To get this setup script working follow these steps:
* Make sure you have [node.js](https://nodejs.org/en/) installed.
* Create a directory in your home directory called `bin` and make another directory called `templates` inside of that. You can do that by running this:
    ```bash
    mkdir $HOME/bin $HOME/bin/templates;
    ```
* Download `nodeSetup.sh` into the `bin` directory.
* Download `package.json`, `index.html`, and `1-normalize.css` into the `templates` directory (see Folder Structure below to verify you've done this correctly).
* In order to run the command from any directory, create an alias for this script by running:
    ```bash
    alias nodeSetup="sh $HOME/bin/nodeSetup.sh";
    ```
* Make a directory anywhere for your app project.
* Run the setup command by running: 
    ```bash
    nodeSetup /Absolute/Path/To/App/Directory
    ```
    
## Folder Structure
HOME_DIRECTORY

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└── bin

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└── nodeSetup.sh

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└── templates

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└── 1-normalize.css

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└── index.html

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└── package.json

## Developing
Inside your app directory, run the following command to activate the watch script. This will automatically build your project when changes are made in your build directoy (see Package.json Scripts below for further explanation): 
```bash
npm run watch
```
Alternatively you can manually build your project by running:
```bash
npm run build
```

## Previewing / Deploying
To preview your app locally, the app directory will need to be served on a localhost server like [MAMP](https://www.mamp.info/en/). Navigate to your directory's `dist` directory through localhost to see it. See your local server program's documentation for more.

To deploy your web app on a server, copy the contents of your `dist` directory to a directory on your server.

# Package.json Scripts
This pure bash setup utilizes the power of [node scripts](https://docs.npmjs.com/misc/scripts). Here I'll go over each script I use found in `package.json.`
* **updateHtmlPhp**: This script copies `index.html` and `index.php` from the `build` directory (if they exist) to the `dist` directory. The commands are piped to true (note the `| true`) to avoid crashing if the files don't exist.
* **buildcss**: This script uses `cat` to concatenate all the files inside the `build/css` directory in alphabetical order. For that reason use numbers in front of each file name to order your css code. Less important scripts (like imported libraries) should have lower numbers than essential ones (like custom code files). It also uses `autoprefixer` to add prefixes for full browser support. The result is placed in the `dist` directory as `styles.min.css`.
* **lint**: This script uses `jshint` to lint all the code found in the `build/js` directory.
* **prebuild**: Using the `pre` prefix, this script runs before the `build` script automatically due to node's script running process. It runs the `lint`, `buildcss`, and `updateHtmlPhp` scripts. 
* **build**: This srcipt uses `browserify` to compile main.js and `uglifyjs` to minify it. The result is placed in the `dist` directory as `scripts.min.js`.
* **watch**: This script uses `nodemon` to watch for changes in js, css, html, and php code inside the `build` directory and runs the `build` script when one is detected. Remember that `prebuild` is also run automatically before `build`.

## Credits
I do not own nor claim the rights to normalize.css. The repo for that library can be found [here](https://necolas.github.io/normalize.css/). I include it in this repo only because I use it on most of my projects. Normalize is still properly included as a dependency in my package.json file.

Special thanks to [Nick Briz](https://github.com/nbriz) for helping me get this workflow set up.
