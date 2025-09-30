const mapIds = [
  'w9h7',
]

export const getRandomMapId = (): string => {
  const randomIndex = Math.floor(Math.random() * mapIds.length)

  return mapIds[randomIndex]
}
