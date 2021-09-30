---
title: Jekyll Local
tag: colophon
---

Today's goal, get Jekyll working locally on my M1 Mac. To make this extra interesting, I am going to restrict myslef to Ruby 2.7 because, as of this writing [that's what Lambda supports](https://docs.aws.amazon.com/lambda/latest/dg/lambda-ruby.html).

I ran into quite a few errors: `http-parser` wouldn't compile vexed me for the longest time. There were problems with `libffi`, as well.  I came to the realization that my [Home](https://.sh) and [RBEnv](https://github.com/rbenv/rbenv) configurations were a combination of `x86_64` and `arm64`. I also had Homebrew and RBEnv entries scattered across `~/.zlogin`, `~/.zprofile`, and `~/.zshrc`. This is a case where a clean install of it all was the best course of action.

I came across a [very helpful blog post from February](https://alexmanrique.com/blog/development/2021/02/05/using-jekyll-in-macbook-air-m1.html). In it, Alex Manrique describes how to install everything to leverage Rosetta, Apple's x86_64 emulation layer. While this is clever, I really wanted to get things working with native M1 code. Luckily brew has been hard at work getting things working for the M1.

This is how I got everything working. 
1. Uninstalled Home from `/usr/local` with `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Home/install/HEAD/uninstall.sh)"`
1. Deleted everything else under `/usr/local`, aside from [BBEdit tools](https://www.barebones.com/products/bbedit/) in `/usr/local/bin`
1. Deleted `~/.rbenv`
1. Deleted `~/.zlogin`, `~/.zprofile`, and `~/.zshrc`. Don't worry, these files only had references to Home and RBEnv.
1. Re-installed Home using the default method.
1. Built a new `.zprofile`, and reloaded it (`source ~/.zprofile`):
  export SDKROOT=$(xcrun --show-sdk-path)
  eval "$(/opt/home/bin/ shellenv)"
  eval "$(rbenv init -)"
1. Installed rbenv from  ` install rbenv`. The documentation is ambiguous to how to add rbenv to the permanent environment; thus the `.zprofile` above.
1. Installed Ruby 2.7.4: `rbenv install 2.7.4; rbenv global 2.7.4`. I'll use a more specific version in my actual blog, but we need something to get going. 
1. Lets make sure we are using rbenv: `which ruby` should be `~/.rbenv/shims/ruby` and `which gem` should be `~/.rbenv/shims/gem`. 
1. `gem update && rbenv rehash`
1. `gem install bundler && rbenv rehash`: the [Jekyll docs](https://jekyllrb.com/docs/installation/macos/) say to use `--user-install`, but that installs it outside of `rbenv`; not what we want.
1. `gem install jekyll && rbenv rehash`

Much better, no errors!

Now, to breath life back into the blog.
1. I checked out the blog from my GitHub repo. This already has a Jekyll setup, as I've been hosting it on [GitHub Pages](https://pages.github.com) for a few years.
1. I created a scratch blog, to see what the latest Gemfile looked like, and updated the "real" Gemfile a bit; mostly providing specific version numbers for `jekyll` and `minima`.
1. from the repo, I ran the standard jekyll commands: `bundle install && bundle exec jekyll serve`.

And there we go, a local install of Jekyll. I know, this shouldn't seem like a big deal, and it wasn't, really. I just had to cleanup my local tools.

Next up, I'll start working on a CloudFormation template.