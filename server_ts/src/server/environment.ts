export class Environment {
  constructor(
    readonly apiKey: string,
    readonly port: string,
    readonly fullchain: string,
    readonly privkey: string,
  ) {}

  get hasCertificate() {
    return this.fullchain && this.privkey
  }
}