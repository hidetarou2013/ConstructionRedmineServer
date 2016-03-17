# ConstructionRedmineServer

Dockerを利用した Redmineサーバ構築スクリプトになります。
最短で2分程度でRedmineサーバが構築できます。
（※pullが遅い場合は、スクリプト内のコメントアウトしているdocker buildのほうをお使いください。15分程度かかります。）

## 1.構成

Redmine 3.2.0
MySQL   5.5.46

## 2.前提

Dockerが動く環境を準備します。
Windowsであれば、Docker Toolboxで構いません。
もしくは、Vagrant等で Docker Host なゲストOSを立てたうえで、構築します。

## 3.構築手順

dockerコマンドが有効な場合


```
 curl -fsSL https://github.com/hidetarou2013/ConstructionRedmineServer/raw/master/create_start_redmine.sh | sh
```


もしくは、「sudo docker」の場合のスクリプトも一応添付します。


```
 curl -fsSL https://github.com/hidetarou2013/ConstructionRedmineServer/raw/master/sudo_create_start_redmine.sh | sh
```

##4. Redmine URL

http://DockerHostIPAddress:10080/

admin/admin

##5. 改良内容

TAG:SVN

+ Subversion連携機能追加

- 決め打ちで、tmp1というリポジトリを作成してあります。
- アクセスアカウントは１８名分のチームのダミーアカウントをアクセス用に設定済みです。
- パスワードファイルは、「/etc/httpd/conf/tmp1」になります。必要があれば適時修正してください。
- リポジトリの実際のファイルパスは、「/var/lib/svnrepos/tmp1」になります。
- redmineから設定する際のリポジトリのURLは、「http://svn/repo1/」になります。
- redmineから設定する際のリポジトリへの接続アカウントは、「id/pass=redmine/redadmin」になります。


TAG:SVN_repo1

+ Subversion連携機能修正
+ リポジトリを外部設定可能にしました。

このTAGの例では「repo1」という名前のSVNリポジトリを新規作成し、アカウントのデフォルト設定済の状態までイメージに固められます。
 
任意のリポジトリ名に変更したい場合は

+ 依存しているcentos6-apacheのDockerfileの、該当箇所「repo1」を利用したいリポジトリ名に置換し
+ centos6-apacheのイメージをbuildする。（名前を決めておく：例- hidetarou2013/centos6-apache:SVN_repo1）
+ このプロジェクトのファイル「create_start_redmine.sh」の該当部分「hidetarou2013/centos6-apache:SVN_repo1」を修正し
+ シェルスクリプトをキックすれば起動できます。

##6. 改良予定

TAG:svn_storage_repo1

hidetarou2013/svn-storage:latest
を利用し、SVNのリポジトリを外出しコンテナとして運用する構成に改良予定

※現在、この部分だけは外出しストレージコンテナの内部にうまくリポジトリが作成できない問題がある。

