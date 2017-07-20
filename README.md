# hello-digdag

[![Docker Repository on Quay](https://quay.io/repository/aaua/hello-digdag/status "Docker Repository on Quay")](https://quay.io/repository/aaua/hello-digdag)

---

# Quay, Rancher, Digdagの使い方
vagrantを立ててDockerインストールしておく

vagrant
- 80・8080ポートを開ける
- CPU数: 2
- メモリ: 4GB程度

変更例
```
Vagrant.configure("2") do |config|
  config.vm.network "forwarded_port", guest: 8080, host: 8080

  config.vm.provider "virtualbox" do |vb|
    vb.cpus = 2

    # Customize the amount of memory on the VM:
    vb.memory = "4096"
  end
  ・・・
```


## Quay
コミットしたらビルドが動くことを確認

## Rancher
https://github.com/rancher/rancher
```sh
docker run -d --restart=unless-stopped -p 8080:8080 rancher/server
```

ブラウザからRancherのGUIにアクセス<br>
http://localhost:8080

CATALOGからWordpressを立ててみる、データの永続化をしてみる
参考: https://github.com/aaua/hello-digdag/blob/latest/sample/rancher/wordpress

## Digdag
``quay.io/aaua/hello-digdag``をイメージとして使ってdigdagサーバーを立ててみる
参考: https://github.com/aaua/hello-digdag/blob/latest/sample/rancher/digdag

```sh
docker ps -a
docker exec -it r-digdag-digdag-1-○○ /bin/bash -i
```
```sh
mkdir /var/digdag; cd $_
digdag init digdag-sample

cd digdag-sample/
digdag run digdag-sample.dig

digdag push test
digdag workflow
```

GUIで編集して、実行してみる

Shellを実行してみる
```sh
mkdir tasks
vi tasks/hello.sh
```
```sh
#!/bin/sh

echo "Hello, World!"
```

```sh
vi digdag-sample.dig
```
```
+hello:
  sh>: /bin/bash ./tasks/hello.sh
```
```sh
digdag push test
```

CUIで実行してみる
```sh
digdag start test digdag-sample --session now
```
