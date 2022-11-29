#!/usr/bin/env node

import os from 'os';
import fs from 'fs';
import path from 'path';

import XLSX from "xlsx";

const F_INPUT = path.join(os.homedir(), 'Downloads', 'd365.xlsx');
const F_OUTPUT = F_INPUT.replace('.xlsx', '-splitted.xlsx')

process.stdout.write(`FILE: ${F_INPUT}\n`);
try {
    fs.statSync(F_INPUT);
} catch (e) {
    console.error("File does not exists");
}

// https://www.npmjs.com/package/xlsx

const workbook = XLSX.readFile(F_INPUT);

const initialData = XLSX.utils.sheet_to_json(workbook.Sheets.Sheet1)

const outputData = [];
for(let i = 0; i< initialData.length; i++) {
    outputData.push(initialData[i]);
}

console.log(outputData);

XLSX.utils.book_append_sheet(workbook, XLSX.utils.json_to_sheet(outputData), "splitted", true);
XLSX.writeFile(workbook, F_OUTPUT);
