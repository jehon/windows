#!/usr/bin/env node

// See https://github.com/cronvel/terminal-kit/blob/HEAD/doc/high-level.md#ref.fileInput

import terminal from 'terminal-kit';
import glob from 'glob';
import childProcess from 'child_process';
import projects from 'file://C:\\Users\\jho\\OneDrive - NSI IT Software & Services (NSISABE)\\Documents\\NSI\\projects.mjs';
const term = terminal.terminal;

term.fullscreen();

term.cyan('The hall is spacious. Someone lighted few chandeliers.\n');
term.cyan('There are doorways south and west.\n');

projects.filter(e => e.title > '');

projects.sort((a, b) => (a.wo + a.id).localeCompare(b.wo + b.id));

process.stdout.write(` ${'id'.padStart(7, ' ')} | ${'wo'.padStart(7)} | status     | title\n`);
var items = projects.map(v => `${('' + v.id).padStart(7, ' ')} | ${v.wo.padStart(7)} | ${v.status.padEnd(10)} | ${v.title}`);

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