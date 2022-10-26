# オセロプログラムサンプル

C#でオセロアプリケーションを，CUIとGUIで実装します．

GUIはBlazorを利用してWEBブラウザアプリケーションとしてビルドします．

また，CIとしてGithub Actions使用してGithub Pagesにデプロイします.

※ BlazorとはJavascriptの代わりにC#とWebAssemblyを用いてブラウザアプリケーションを開発するフレームワークです．

[Blazor 公式](https://learn.microsoft.com/ja-jp/aspnet/core/blazor/)

### オセロDEMOページはこちら

https://le-nn.github.io/reversi-example/

# 環境

|                    |                 | 
| ------------------ | --------------- |
| プラットフォーム    | .NET 7           |
| 言語               | C# 11            |
| CI                 | Github Actions   |
| デプロイ先          | Github Pages     |

# 起動

### GUI

Visual Studio でReversi.Blazorプロジェクトを起動 
もしくはReversi.Blazorディレクトリをターミナルで開いて以下のコマンドを実行

```
dotnet run
```

開発用サーバーが起動するので、Consoleに表示されたURLへブラウザからアクセス

### CUI

Visual Studio でReversi.ConsoleAppプロジェクトを起動 
もしくはReversi.ConsoleAppディレクトリをターミナルで開いて以下のコマンドを実行

```
dotnet run
```

# プロジェクト構成

| project            | description                                      | 
| ------------------ | ------------------------------------------------ |
| Reversi.Core       | オセロのゲームロジック                             |
| Reversi.Blazor     | WEBブラウザで操作するアプリケーション               |
| Reversi.ConsoleApp | ターミナル上のCUIで操作するアプリケーション          |

# 拡張

```ReversiGame```クラスがオセロゲームを提供します。

駒の配置などの入力は```IInteractor```インターフェースを実装したクラスを```ReversiGame```クラスのコンストラクタに指定します．
これによりUIの種類やプラットフォームに依存せず，
また，ロジックを変更することなく、
拡張や利用をすることができます．
ユーザーのインタラクションのみならず、NPCのAIなども実装することができます．

```cs
public interface IInteractor {
    string Name { get; }

    Task<Position> InputAsync(Board board, Piece turn);
}
```
入力が必要になると```InputAsync```が呼び出されるので、配置する場所を戻り値として返します。

利用と実装例
```cs
var player1 = new ConsoleInteractor("Player1");
var player2 = new ConsoleInteractor("Player2");
var game = new ReversiGame(player1, player2); 

class ConsoleInteractor : IInteractor {
    public string Name { get; }

    public ConsoleInteractor(string name) {
        this.Name = name;
    }

    public Task<Position> InputAsync(Board board, Piece turn) {
        // turnは現在のターンの駒の種類
        // boardは現在のボードの状態

        // ...
        // 駒を配置する処理
        // ...

        var position = new Position(..., ...); // 配置する位置

        return position;
    }
}
```
#### 参考実装

コンソールアプリの場合
[ConsoleInteractor.cs](./src/Reversi.ConsoleApp/ConsoleInteractor.cs)

Blazorの場合
[PlayerInteractor.cs](./src/Reversi.Blazor/Services/PlayerInteractor.cs)

