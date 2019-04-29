# Core
[![CircleCI](https://circleci.com/gh/davydovanton/rubyjobs.dev/tree/master.svg?style=svg)](https://circleci.com/gh/davydovanton/rubyjobs.dev/tree/master)

Welcome to your new Hanami project!

## How to run app inside Docker

Copy development env-file from sample file:

```bash
cp .env.development.sample .env.development
```

Then simply run in your terminal:

```bash
make dockerize
```

Open [http://localhost:2300](http://localhost:2300) in your browser.

## How to get container's shell

Run in your terminal:

```bash
make shell
```

