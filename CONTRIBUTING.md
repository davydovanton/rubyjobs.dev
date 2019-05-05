RubyJobs.dev is an open source project and we would love you to help us make it better.

## Reporting Issues

A well formatted issue is appreciated, and goes a long way in helping us help you.

* Make sure you have a [GitHub account](https://github.com/signup/free)
* Submit a [Github issue](https://github.com/davydovanton/rubyjobs.dev/issues/new) by:
  * Clearly describing the issue
  * Provide a descriptive summary
  * Explain the expected behavior
  * Explain the actual behavior
  * Provide steps to reproduce the actual behavior
  * Put application stacktrace as text (in a [Gist](https://gist.github.com) for bonus points)
  * Any relevant stack traces

If you provide code, make sure it is formatted with the triple backticks (\`).

At this point, we'd love to tell you how long it will take for us to respond,
but we just don't know.

## Pull requests

We accept pull requests to RubyJobs.dev for:

* Fixing bugs
* Adding new features

Not all features proposed will be added but we are open to having a conversation
about a feature you are championing.

Here's a quick guide:

1. Fork the repo.

2. Run the tests.

3. Create a new branch and make your changes. This includes tests for features!

4. Push to your fork and submit a pull request. For more information, see
[Github's pull request help section](https://help.github.com/articles/using-pull-requests/).

At this point you're waiting on us. Expect a conversation regarding your pull
request, questions, clarifications, and so on.

## How to install project

The first thing what you need to start project is copying sample configs:

```bash
$ cp .env.development.sample .env.development
$ cp .env.test.sample .env.test
```

If you want to contribute inside Docker instead of local development,
then you need to uncomment `DATABASE_URL`, `REDISTOGO_URL` and other variables
in Docker section in these configs.

Project will be available on [http://localhost:2300](http://localhost:2300).

### Local development

```bash
$ bundle install
$ bundle exec hanami db prepare
$ bundle exec hanami s
```

### Docker development

```bash
$ make dockerize
```

## How to run tests

### Local development

```bash
$ HANAMI_ENV=test bundle exec hanami db prepare
$ bundle exec rspec
```

### Docker development

```bash
$ make shell
$ HANAMI_ENV=test bundle exec hanami db prepare
$ bundle exec rspec
```
