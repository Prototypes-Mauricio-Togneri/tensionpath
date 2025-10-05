const mapIds = [
  'battle_quadrats',
]

export const getRandomMapId = (): string => {
  const randomIndex = Math.floor(Math.random() * mapIds.length)

  return mapIds[randomIndex]
}
