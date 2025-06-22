export enum UnitType {
  fire = 'fire',
  water = 'water',
  plant = 'plant',
}

export const unitTypeBeats = (type1: UnitType, type2: UnitType): boolean => {
  return (
    (type1 === UnitType.fire && type2 === UnitType.plant) ||
    (type1 === UnitType.water && type2 === UnitType.fire) ||
    (type1 === UnitType.plant && type2 === UnitType.water)
  )
}
