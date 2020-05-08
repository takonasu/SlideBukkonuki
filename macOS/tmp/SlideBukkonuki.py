#coding: utf-8
#未完成品です。
import cv2
import numpy as np
from argparse import ArgumentParser

g_save_location = "./"
g_threshold: float = 10.0
g_interval: int = 5
g_trimming_point: int = 0
g_aspect_ratio: int = 0

def movie_to_picture(video_path):
	video = cv2.VideoCapture(video_path)
	if (!video.isOpened()):
		return
	frame_num: int = video.get(cv2.CAP_PROP_FRAME_COUNT)
	digit: int = len(str(frame_num))
	
	video.set(cv2.CAP_PROP_POS_FRAMES, frame_num - 10)
	
	

def main():
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

if __name__ == "__main__":
	main()
