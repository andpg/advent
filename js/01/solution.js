const readFile = async (path) => {
  const file = Bun.file(path)
  const text = await file.text()
  return text.trim()
}

const getLists = async () => {
  // Assumes you're running in the project's root directory
  const lines = (await readFile("./js/01/input")).split("\n")
  const n = lines.length
  let leftList = new Array(n), rightList = new Array(n)

  for (let i=0; i<n; i++) {
    const [left, right] = lines[i].split("   ")
    leftList[i] = parseInt(left)
    rightList[i] = parseInt(right)
  }

  return [leftList, rightList]
}

const part1 = async () => {
  let [leftList, rightList] = await getLists()
  leftList.sort((a,b) => a-b)
  rightList.sort((a,b) => a-b)
  return leftList.reduce(
    (dist, left, i) => dist + Math.abs(left - rightList[i]),
    0
  )
}

const part2 = async () => {
  let [leftList, rightList] = await getLists()
  return leftList.reduce(
    (score, left) => score + left * rightList.filter(x => x == left).length,
    0
  )
}


part1().then(console.log)
part2().then(console.log)
