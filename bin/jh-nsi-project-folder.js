#!/usr/bin/env node

// See https://github.com/cronvel/terminal-kit/blob/HEAD/doc/high-level.md#ref.fileInput

const LIST_FILE = "C:/Users/jho/OneDrive - NSI IT Software & Services (NSISABE)/Desktop/Storage/ProjectData/listing.xlsx";

import terminal from 'terminal-kit';
// import glob from 'glob';
import childProcess from 'child_process';
import readXlsxFile from 'read-excel-file/node/index.commonjs.js';
const term = terminal.terminal;

const xlsxprojects = await readXlsxFile(LIST_FILE);
const headers = xlsxprojects.shift();

const projects = xlsxprojects.map(row => {
	const res = {};
	for (let i = 0; i < headers.length; i++) {
		res[headers[i]] = row[i];
	}
	return res;
})

term.on('key', function (name, matches, data) {
	// console.log("'key' event:", name);
	if (name === 'CTRL_C' || name === 'ESCAPE') {
		term.grabInput(false);
		setTimeout(function () { process.exit() }, 100);
	}
});

term.fullscreen();

term.cyan('The hall is spacious. Someone lighted few chandeliers.\n');
term.cyan('There are doorways south and west.\n');

projects.filter(e => e.title > '');

projects.sort((a, b) => (a.wo + a.id).localeCompare(b.wo + b.id));

const padId = projects.map(p => ("" + p.id).length).reduce((prev, cur) => Math.max(prev, cur), 0) + 1;
const padWO = projects.map(p => ("" + p.WO).length).reduce((prev, cur) => Math.max(prev, cur), 0) + 2;
const padStatus = projects.map(p => ("" + p.status).length).reduce((prev, cur) => Math.max(prev, cur), 0) + 1;

process.stdout.write(` ${'id'.padStart(padId, ' ')} | ${'wo'.padStart(padWO)} | ${"status".padEnd(padStatus)} | title\n`);
var items = projects.map(v => `${('' + v.id).padStart(padId, ' ')} | ${v.wo.padStart(padWO)} | ${v.status.padEnd(padStatus)} | ${v.title}`);

term.singleColumnMenu(items, function (error, response) {
	// response.selectedIndex
	const id = projects[response.selectedIndex].id;

	const p = '\\\\' + ["portalnsi", "sites", "priam", `Project${id}`, "Documents du projet"].join('\\');
	console.log("Path: ", p);
	const child = childProcess.spawn('explorer', [p], { detached: true, stdio: 'ignore' });
	child.unref();

	// glob(p + '\\*', function (err, files) {
	// 	if (err) {
	// 		console.error(err);
	// 		return;
	// 	}
	// 	console.log(files);
	// 	console.log("done");
	// });

	// term.inputField((error, input) => {
	process.exit();
	// });
});