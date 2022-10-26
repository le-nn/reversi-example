dotnet publish .\src\Reversi.Blazor\Reversi.Blazor.csproj -c:Release -p:GHPages=true -o:dist
gh-pages -t -d .\dist\wwwroot\ -b demo