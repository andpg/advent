const readFile = async (path) => {
  const file = Bun.file(path)
  const text = await file.text()
  return text.trim()
}

// Assumes you're running in the project's root directory
readFile("./js/01/input").then(console.log)
