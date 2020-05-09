@echo off

rem bukkonukiのラッパースクリプト、バイナリと同じディレクトリに入れてください
rem D&Dでつんでれんこみたいな感じにしたい

rem D&Dされたパスのバックスラッシュをスラッシュに置換
set dropped_path=%1
set input_path=%dropped_path:\=/%

rem 入力パス通知
echo 入力パスは %input_path%

rem ファイル名を元に出力フォルダ作成
set filename_origin=%~n1

rem スペースの削除
set filename_del_1bytespace=%filename_origin: =_%
set filename_del_2bytespace=%filename_del_1bytespace:　=_%
set dirname=%filename_del_2bytespace%

rem カレントディレクトリを取得
set bat_dir=%~dp0
set bat_path=%bat_dir:\=/%

rem 出力フォルダが生成されていなければ生成
If NOT EXIST "%bat_path%slides"\ (
mkdir "%bat_path%slides" > NUL 2>&1
)

If NOT EXIST "%bat_path%slides\%dirname%"\ (
mkdir "%bat_path%slides\%dirname%"
)

set  output_path="%bat_path%slides/%dirname%/"

rem 出力パス通知
echo 出力パスは %output_path%


rem スライドのアスペクト比を決定
set aspect=
set /P aspect="動画内スライドの画面比は？(4:3(正方形に近い)なら0 / 16:9なら1)："

rem Autoモードにするか
choice /m "全てデフォルト設定で処理しますか?"

if errorlevel 2 goto :manual
if errorlevel 1 goto :auto

:auto
set trimming=0
set threshold=10
set interval=5

rem ぶっこぬき実行
call %bat_path%bin\Slidebukkonuki.exe %input_path% %output_path% %threshold% %trimming% %aspect% %interval% 
exit /b

:manual
rem トリミング指定
set trimming=
set /P trimming="トリミングしますか？(デフォルトなら0)："

rem 閾値指定
set threshold=
set /P threshold="閾値を指定しますか?(デフォルトなら10)："

rem フレーム取得間隔
set interval=
set /P interval="フレーム取得間隔を変更しますか？(デフォルトなら5)："

rem ぶっこぬき実行
cd %~dp0
call %bat_path%bin\Slidebukkonuki.exe %input_path% %output_path% %threshold% %trimming% %aspect% %interval% 

exit /b

