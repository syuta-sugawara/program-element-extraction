#!ruby -Ku


require "pp"

# portfolio.mdを読み込み，改行コード(\n)をデリミタとして，1行ずつに分割した配列aDataに格納
aData = File.read("portfolio.md").split("\n")

hData = {}      # ポートフォリオ解析データ
sCurCap1 = nil  # 読み込み中の大見出し
sCurCap2 = nil  # 読み込み中の中見出し
sCurCap3 = nil  # 読み込み中の小見出し
lCurPos = nil   # 最後に読み込んだ見出し(大/中/小)の区別

# ポートフォリオを1行ずつ読み込んでいく
aData.each{|sLine|
  # 正規表現：先頭が#+半角スペースの行を大見出しとする
  if (sLine =~ /^# /)
    # 先頭の「#+半角スペース」以降の文字列を，大見出しの文字列として取得する
    sCurCap1 = sLine.gsub(/^# (.*)$/, "\\1")
    # 大見出しの文字列をキーとして，中見出し用のハッシュを持つ
    hData[sCurCap1] = {}
    # 大見出しに本文があった場合は，:TEXTをキーとした文字列に保持するため初期化する
    hData[sCurCap1][:TEXT] = ""
    # 最後に読み込んだ見出しを:CAP1(大見出し)とする
    lCurPos = :CAP1
  # 正規表現：先頭が##+半角スペースの行を中見出しとする
  elsif (sLine =~ /^## /)
    # 先頭の「##+半角スペース」以降の文字列を，中見出しの文字列として取得する
    sCurCap2 = sLine.gsub(/^## (.*)$/, "\\1")
    # 中見出しの文字列をキーとして，小見出し用のハッシュを持つ
    hData[sCurCap1][sCurCap2] = {}
    # 中見出しに本文があった場合は，:TEXTをキーとした文字列に保持するため初期化する
    hData[sCurCap1][sCurCap2][:TEXT] = ""
    # 最後に読み込んだ見出しを:CAP2(中見出し)とする
    lCurPos = :CAP2
  # 正規表現：先頭が###+半角スペースの行を小見出しとする
  elsif (sLine =~ /^### /)
    # 先頭の「###+半角スペース」以降の文字列を，小見出しの文字列として取得する
    sCurCap3 = sLine.gsub(/^### (.*)$/, "\\1")
    # 小見出しの文字列をキーとしてハッシュを持つ(:TEXT用)
    hData[sCurCap1][sCurCap2][sCurCap3] = {}
    # 小見出しに本文があった場合は，:TEXTをキーとした文字列に保持するため初期化する
    hData[sCurCap1][sCurCap2][sCurCap3][:TEXT] = ""
    # 最後に読み込んだ見出しを:CAP3(小見出し)とする
    lCurPos = :CAP3
  elsif (sLine == "")
    # 空行は何もしない
  else
    # 見出し，空行でない行は本文として扱う
    case lCurPos
    when :CAP1
      # 最後に読み込んだ見出しが大見出しの場合，その行の内容を，sCurCap1の:TEXTキー文字列に追加していく
      hData[sCurCap1][:TEXT] += sLine + "\n"
    when :CAP2
      # 最後に読み込んだ見出しが中見出しの場合，その行の内容を，sCurCap2の:TEXTキー文字列に追加していく
      hData[sCurCap1][sCurCap2][:TEXT] += sLine + "\n"
    when :CAP3
      # 最後に読み込んだ見出しが小見出しの場合，その行の内容を，sCurCap3の:TEXTキー文字列に追加していく
      hData[sCurCap1][sCurCap2][sCurCap3][:TEXT] += sLine + "\n"
    end
  end
}

# 引数の数に応じた処理
# ・引数が4つ以上ある場合，何もしない
case ARGV.size()
# 引数の数が1つの場合，大見出しのみ指定されたと見なす
when 1
  # 第1引数に指定された文字列がhDataのキー(大見出し)として存在し，:TEXTにデータがある場合出力する
  if (hData.has_key?(ARGV[0]) && (hData[ARGV[0]][:TEXT] != ""))
    puts hData[ARGV[0]][:TEXT]
  end
# 引数の数が2つの場合，大見出しと中見出しが指定されたと見なす
when 2
  # 第1引数に指定された文字列がhDataのキー(大見出し)として存在する場合のみ処理する
  if (hData.has_key?(ARGV[0]))
    # 第2引数に指定された文字列がhData[ARGV[0]]のキー(中見出し)として存在し，:TEXTにデータがある場合出力する
    if (hData[ARGV[0]].has_key?(ARGV[1]) && (hData[ARGV[0]][ARGV[1]][:TEXT] != ""))
      puts hData[ARGV[0]][ARGV[1]][:TEXT]
    end
  end
# 引数の数が3つの場合，大見出し・中見出し・小見出しが指定されたと見なす
when 3
  # 第1引数に指定された文字列がhDataのキー(大見出し)として存在する場合のみ処理する
  if (hData.has_key?(ARGV[0]))
    # 第2引数に指定された文字列がhData[ARGV[0]]のキー(中見出し)として存在する場合のみ処理する
    if (hData[ARGV[0]].has_key?(ARGV[1]))
      # 第3引数に指定された文字列がhData[ARGV[0]][ARGV[1]]のキー(小見出し)として存在し，:TEXTにデータがある場合出力する
      if (hData[ARGV[0]][ARGV[1]].has_key?(ARGV[2]) && (hData[ARGV[0]][ARGV[1]][ARGV[2]][:TEXT] != ""))
        puts hData[ARGV[0]][ARGV[1]][ARGV[2]][:TEXT]
      end
    end
  end
end
