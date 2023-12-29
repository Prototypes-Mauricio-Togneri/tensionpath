export class Environment {
  constructor(
    readonly apiKey: string,
    readonly port: string,
    readonly fullchain: string,
    readonly privkey: string,
  ) {}
}