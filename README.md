# Description

This repo contains a GitHub action to run [flakehell](https://github.com/flakehell/flakehell),
using [reviewdog](https://github.com/reviewdog/reviewdog) to annotate code changes on GitHub.

This action was created from `reviewdog`'s awesome [action template](https://github.com/reviewdog/action-template).

## Usage

```yaml
name: reviewdog-flakehell
on: [pull_request]
jobs:
  flakehell:
    name: runner / flakehell
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: sailingpalmtree/reviewdog-flakehell-action@0.2
        with:
          github_token: ${{ secrets.github_token }}
          # Change reviewdog reporter if you need [github-pr-check,github-check,github-pr-review].
          reporter: github-pr-review
          # Change reporter level if you need.
          # GitHub Status Check won't become failure with warning.
          level: warning
```

## Releases

v0.2 - first fully tested, and actually fully used version
v0.1 - first draft release

## Testing
There are two ways to test this action:

### Use the included test workflows
These are defined in [`test.yaml`](https://github.com/sailingpalmtree/reviewdog-flakehell-action/blob/master/.github/workflows/test.yml). One can further configure these, but you can see in mine how I set them up.

### Test the action locally
For this I used the tool [act](https://github.com/nektos/act).

#### Platforms
I saved the platforms I cared about in my `~/.actrc` file:
```
-P ubuntu-latest=ghcr.io/catthehacker/ubuntu:act-latest
-P ubuntu-20.04=ghcr.io/catthehacker/ubuntu:act-20.04
-P ubuntu-18.04=ghcr.io/catthehacker/ubuntu:act-18.04
```
(note that you could pass these in on the command line too with `-P`)

#### Secrets and environment variables
In order to pass in secrets and other env variables to the action, I saved these in `.env` and `.secret` files.
(Don't forget to add these to `.gitignore` for obvious reasons)
`act` by default will read these files with these names but you can name them differently and pass them in with their flags.
Alternatively, you can pass them in on the `act` command line too.

#### Invocation
I ran `act` with the simple:
```shell
act push
```
command, where `push` was meant to simulate a GitHub `push` event. You can use any other event, and you can further configure them if you wish.
