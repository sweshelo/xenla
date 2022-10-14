# Xenla
Xmodmapでキー配列を上書きします。なお現在Xmodmapでキー配列を上書きするのは非推奨のようです。

## 使い方
```
# Xmodmap用のファイル書き出し
./main.sh data/eucalyn.cnf 64 > ~/.Xmodmap

# Xmomapで反映
xmodmap ~/.Xmodmap
```

この例では、`64` (-> 左Altキー)を押している間だけQwertyに戻ります。省略可能オプションです。  
Qwertyに戻すための修飾キーを調べるには`xev`コマンドを使用してください。  
