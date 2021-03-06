
## ポートフォリオ

Markdown 形式でポートフォリオを記載し、それを提出してください。記載の項目については、[サンプルのポートフォリオ](portfolio.md) を参考にしてください。項目については、追加したり修正したりしても問題ありません。

## 課題

指定した動作をするプログラムを作成し、ソースコードを提出してください。

### 課題内容

[GitHub Flavored Markdown](https://github.github.com/gfm/)で書かれた文章は、見出しによって階層構造となっているとみなすことができます。たとえば、下記のような文章があったときに、「大見出し」は「中見出し」を含み、「中見出し」は「小見出し1」と「小見出し2」とを含み、「小見出し1」は「本文1」を含んでいるとみなすことができます。

```
# 大見出し
## 中見出し
### 小見出し1

本文1

### 小見出し2

本文2
```

Markdown 形式のポートフォリオがあったときに、見出しを指定すると、その見出しに含まれる要素を抽出するプログラムをつくってください。見出しの指定方法は、コマンドライン引数などで指定するものとします。具体的には、コマンドライン引数として「大見出し 中見出し 小見出し2」が与えられたときには、そこに含まれる要素の「本文2」の内容を出力してください。また、該当する見出しが無い場合には何も出力しません。

なお、実装にあたってのプログラム言語や処理系は問いません。ただし、 Mac で動作確認を行ないますので、どのようにプログラムを動作させるのかについて、補足ドキュメントを添えてください。

ライブラリの利用については制限しない。

### 提出物

| 提出物           | 概要       |
| ---------------- | ---------- |
| ポートフォリオ   | Markdown 形式で記載されたポートフォリオ。ファイル名を portfolio.md にしてください。 |
| 課題ソースコード | 指定された課題を解くためのプログラムのソースコード |
| 補足ドキュメント | 課題を動作させるための手順を説明した文書 |
