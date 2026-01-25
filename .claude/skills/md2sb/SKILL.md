---
name: md2sb
description: >
  Markdownでまとめを作成し、Scrapbox(Cosense)形式に変換してクリップボードにコピーする。
  「Scrapboxにまとめて」「Cosenseにまとめて」「sb形式で出力」「Scrapbox形式でコピー」「Cosense形式でコピー」などのリクエストで使用。
argument-hint: "[トピック]"
---

# md2sb スキル

ユーザーのリクエストに基づいてMarkdown形式のまとめを作成し、Scrapbox形式に変換してクリップボードにコピーする。

## 手順

1. リクエスト内容をMarkdown形式でまとめる（見出し、リスト、コードブロック、テーブル等を適切に使用）
2. 環境に応じたクリップボードコマンドを選択:
   - macOS: `pbcopy`
   - X11: `xsel --clipboard --input`
   - Wayland: `wl-copy`
3. 以下のコマンドでScrapbox形式に変換してクリップボードにコピー:

```bash
echo '<markdown内容>' | npx md2sb | <clipboard-command>
```

4. 「クリップボードにコピーしました」と報告

## 環境判定

- `$XDG_SESSION_TYPE` が `wayland` なら Wayland
- `$DISPLAY` が設定されていれば X11
- `uname` が `Darwin` なら macOS

## 注意事項

- Markdownの内容はシングルクォートで囲む（変数展開を防ぐ）
- 内容にシングルクォートが含まれる場合は適切にエスケープする
- 日本語で出力する
