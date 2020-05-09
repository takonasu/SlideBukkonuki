#coding: utf-8
import cv2
import numpy as np
from argparse import ArgumentParser

def difference(frame1, frame2):
	sabun = abs(frame1 - frame2)
	output = cv2.medianBlur(sabun, 25)
	return output

def compare_frames(frame):
	width = len(frame[0])
	height = len(frame)
	count = 0
	countRGB = 0
	i_max = int(((height * 3 / 4) - (height / 4)) / 5)
	j_max = int(((width * 3 /4) - (width / 4)) / 5)
	for i in range(i_max):
		for j in range(j_max):
			count += 1
			countRGB += frame[i,j,0] + frame[i,j,1] + frame[i,j,2]
	print("変化割合:" + str(((countRGB / count) / 256) * 100))
	return ((countRGB / count) / 256) * 100 > g_threshold

def trimming(frame):
	height = len(frame)
	if g_aspect_ratio == 0:
		return frame[0 : height, g_trimming_point : int(g_trimming_point + (height / 3) * 4)]
	else:
		return frame[0 : height, g_trimming_point : int(g_trimming_point + (height / 9) * 16)]

def movie_to_picture(video_path):
	video = cv2.VideoCapture(video_path)
	if (not video.isOpened()):
		return
	frame_num: int = video.get(cv2.CAP_PROP_FRAME_COUNT)
	digit: int = len(str(frame_num))

	video.set(cv2.CAP_PROP_POS_FRAMES, frame_num - 10)
	ret, frame1 = video.read()

	fps: int = video.get(cv2.CAP_PROP_FPS)

	i_max = int(frame_num / (fps * g_interval))

	for i in range(i_max):
		i_f = i * fps * g_interval
		if (i > 0):
			video.set(cv2.CAP_PROP_POS_FRAMES, i_f - fps * g_interval)
			ret, frame1 = video.read()
		frame1 = trimming(frame1)
		video.set(cv2.CAP_PROP_POS_FRAMES, i_f)
		ret, frame2 = video.read()
		frame2 = trimming(frame2)
		if frame2.shape == (0,):
			return

		if compare_frames(difference(frame1,frame2)):
			save_location = g_save_location + str(int(i_f)) + ".jpg"
			print(save_location)
			cv2.imwrite(save_location, frame2)


g_save_location = "./"
g_threshold: float = 10.0
g_interval: int = 5
g_trimming_point: int = 0
g_aspect_ratio: int = 0
input_location: str = "./movie.mp4"

parser = ArgumentParser(usage="SlideBukkonuki.py [-i INPUT] [-o OUTPUT] [-t Threshold] [-r Trimming] [-a Aspect] [-f Frame]")
parser.add_argument("-i","--input",help="入力動画のパスを指定してください。")
parser.add_argument("-o","--output",help="出力先のフォルダーのパスを指定してください。")
parser.add_argument("-t","--threshold",help="閾値")
parser.add_argument("-r","--trimming",help="トリミング開始位置")
parser.add_argument("-a","--aspect",help="スライドのアスペクト比",choices=["0","1"])
parser.add_argument("-f","--frame",help="フレーム取得間隔（秒）")
args = parser.parse_args()

if args.input != None:
	input_location = args.input
if args.output != None:
	g_save_location = args.output
if args.threshold != None:
	g_threshold = float(args.threshold)
if args.trimming != None:
	g_trimming_point = int(args.trimming)
if args.aspect != None:
	g_aspect_ratio = int(args.aspect)
if args.frame != None:
	g_interval = int(args.frame)
if g_aspect_ratio == 0:
	aspect = "4:3"
else:
	aspect = "16:9"
print("***********設定確認**********")
print("閾値:" + str(g_threshold))
print("トリミング開始位置:" + str(g_trimming_point))
print("スライド取得間隔:" + str(g_interval))
print("アスペクト比:" + aspect)
print("**********設定確認終わり**********")
movie_to_picture(input_location)
