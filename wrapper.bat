@echo off

rem bukkonukiのラッパースクリプト、バイナリと同じディレクトリに入れてください
rem D&Dでつんでれんこみたいな感じにしたい

rem D&Dされたパスのバックスラッシュをスラッシュに置換
set dropped_path=%1
set input_path=%dropped_path:\=/%

echo "入力パスは"%input_path%

rem ファイル名を元に出力フォルダ作成
set filename=%~n1
set output_dir=%filename: =_%
mkdir %~dp0\slides > NUL 2>&1
mkdir %~dp0\slides\%output_dir%
set made_dir=%~dp0slides\%output_dir%
set output_path=%made_dir:\=/%/
echo %output_path%


rem 動画のアスペクト比を決定
set aspect=
set /P aspect="動画の画面比は？(4:3なら0 / 16:9なら1)："

rem Autoモードにするか
choice /m "全てデフォルト設定で処理しますか?(y/n)"

if errorlevel 2 goto :manual
if errorlevel 1 goto :auto

:auto
set trimming=0
set threshold=10
set interval=5

rem ぶっこぬき実行
call %~dp0Slidebukkonuki_wintest.exe %input_path% %output_path% %threshold% %trimming% %aspect% %interval% 
exit /b

:manual
rem トリミング指定
set trimming=
set /P trimming="トリミングしますか？(デフォルトなら0)"

rem 閾値指定
set threshold=
set /P threshold="閾値を指定しますか?(デフォルトなら10)"

rem フレーム取得間隔
set interval=
set /P interval="フレーム取得間隔を変更しますか？(デフォルトなら5)"

rem ぶっこぬき実行
call %~dp0Slidebukkonuki_wintest.exe %input_path% %output_path% %threshold% %trimming% %aspect% %interval% 

exit /b

