# KBT

[![Build Status](https://travis-ci.org/TimothyYe/kbt.svg?branch=master)](https://travis-ci.org/TimothyYe/kbt)

[程序员键盘发烧社](http://kbt.xiaozhou.net), an open source forum, forked from [elixir-china](https://github.com/jw2013/elixir-china).

How to deploy it:

```
$ mix deps.get
$ mix ecto.create Repo
$ mix ecto.migrate Repo
$ mix phoenix.server
```

Launch web explorer, enter: [http://localhost:4000](http://localhost:4000) to visit it。
