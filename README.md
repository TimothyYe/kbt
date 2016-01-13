# KBT

程序员键盘发烧社, an open source forum, forked from [elixir-china](https://github.com/jw2013/elixir-china).

How to deploy it:

```
$ mix deps.get
$ mix ecto.create Repo
$ mix ecto.migrate Repo
$ mix phoenix.server
```

Launch web explorer, enter: [http://localhost:4000](http://localhost:4000) to visit it。