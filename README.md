[![Build Status][gh-actions-badge]][gh-actions]
[![Erlang Versions][erlang-badge]][versions]
[![Tags][github-tags-badge]][github-tags]

# `rebar3_oscmd`

*Run custom shell commands with `rebar3 oscmd <shell command>`*

## Purpose

The goal of this plugin is to allow `rebar3` to run additional commands via the system shell, so
that one can use it solely to manage everything in an Erlang project.

Whether it is bringing Docker containers up, tagging a new Git release or
deleting log files, you should be able to use a single build tool.

## How it works

This is a very simple and straightforward plugin. Simply describe your
command in `rebar.config` and execute (just like you would Linux aliases)
with `rebar3 oscmd <shell command>`.

## Usage

Add the plugin to your `rebar.config`:

```erlang
    {plugins, [
        {rebar3_oscmd, "0.5.0"}
    ]}.

    {commands, [
        {docker_up, "docker-compose up -d"},
        {sync, "git fetch upstream && git merge upstream/master"}
    ]}.
```

The example above shows you how to describe a command to bring your
Docker containers up, as well as another one to sync a Git repository
with remote master.

Some options are available, as described below:

* `[{timeout, <Ms>}]` (defaults to `15000`)
* `[{verbose, <Verbose>}]` (defaults to `false`)

e.g. you could change the previous `docker_up` command to have it fail
after 5s with `{docker_up, "docker-compose up -d", [{timeout, 5000}]},`.
You could also get more info from the shell for the above command
`sync` with
`{sync, "git fetch upstream && git merge upstream/master", [{verbose, true}]}`

Check it out:

```bash
$ rebar3 oscmd sync
===> Analyzing applications...
===> Compiling rebar3_oscmd
===> Command sync resulted in: "Already up to date."
```

[//]: ---Named-Links---

[logo]: priv/images/logo.png
[logo-large]: priv/images/logo-large.png
[gh-actions-badge]: https://github.com/erlsci/rebar3_oscmd/workflows/ci%2Fcd/badge.svg
[gh-actions]: https://github.com/erlsci/rebar3_oscmd/actions
[erlang-badge]: https://img.shields.io/badge/erlang-21%20to%2027-blue.svg
[versions]: https://github.com/erlsci/rebar3_oscmd/blob/main/rebar.config
[github-tags]: https://github.com/erlsci/rebar3_oscmd/tags
[github-tags-badge]: https://img.shields.io/github/tag/erlsci/rebar3_oscmd.svg
