// https://www.typescripttutorial.net/typescript-tutorial/typescript-hello-world/
// tsc app.ts
// ^^ VSCode Live Server (neato)

let message: string = 'Hello, TypeScript!';
// create a new heading 1 element
let heading = document.createElement('h1');
heading.textContent = message;
// add the heading the document
document.body.appendChild(heading);