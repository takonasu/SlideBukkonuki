rem bukkonukiのラッパースクリプト、バイナリと同じディレクトリに入れてください
rem D&Dでつんでれんこみたいな感じにしたい
@echo off

rem D&Dされたパスのバックスラッシュをスラッシュに置換
set dropped_path=%1

set input_path=%dropped_path:\=/%
echo %input_path%

rem ファイル名を元に出力フォルダ作成
set filename=%~n1
set output_dir=%filename: =_%
mkdir %~dp0\slides
mkdir %~dp0\slides\%output_dir%
set made_dir=%~dp0\slides\%output_dir%

set output_path="%made_dir:\=/%"

rem 動画のアスペクト比を決定
set aspect=
set /P aspect="動画の画面比は？(4:3なら0 / 16:9なら1)："
echo %aspect%
pause