const jsonFile = require('./jsonexample.json')

const data = JSON.parse(JSON.stringify(jsonFile))

console.log(data.name); // Output: Lucy
console.log(data.Affiliation.formerly); //Output: Arasaka

