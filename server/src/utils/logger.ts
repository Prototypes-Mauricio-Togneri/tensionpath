export class Logger {
  public static log(data: string) {
    console.log(`${new Date().toISOString()} ${data}`)
  }

  public static error(data: string) {
    console.error(`${new Date().toISOString()} ${data}`)
  }
}