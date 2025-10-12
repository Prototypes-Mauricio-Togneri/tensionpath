const mapIds = [
  'battle_quadrants',
  'stonewall',
]

export const getRandomMapId = (): string => {
  const randomIndex = Math.floor(Math.random() * mapIds.length)

  return mapIds[randomIndex]
}
