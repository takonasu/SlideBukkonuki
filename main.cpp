#include <iostream>
#include <string>
#include <opencv2/opencv.hpp>
#include <unistd.h>

using namespace cv;

std::string g_save_location = "./";
// 閾値　何%の差分で処理するか
float g_threshold = 10.0;
// 何秒間隔で動画を処理するか
int g_interval = 5;
// トリミング開始位置
int g_trimming_point = 0;
// スライドのアスペクト比(0なら4:3,1なら16:9)
int g_aspect_ratio = 0;

// トリミングする
Mat trimming(Mat frame)
{
    int height = frame.rows;
    // トリミングをする。
    if (g_aspect_ratio == 0)
    {
        // 4:3
        Rect roi(Point(g_trimming_point, 0), Size((height / 3) * 4, height));
        return frame(roi);
    }
    else
    {
        // 16:9
        Rect roi(Point(g_trimming_point, 0), Size((height / 9) * 16, height));
        return frame(roi);
    }
}

// フレーム間での差分を計算する
Mat difference(Mat frame1, Mat frame2)
{
    // 差分の絶対値
    Mat sabun = abs(frame1 - frame2);
    Mat output;
    // フィルターをかけて平坦化
    medianBlur(sabun, output, 25);
    return output;
}

// 差分がどの程度の大きさなのかを計算して閾値より大きければTrue
bool compare_frames(Mat frame)
{
    int width = frame.cols;
    int height = frame.rows;

    long int count = 0;
    long int countRGB = 0;
    for (int i = height / 4; i < height * 3 / 4; i += 5)
    {
        for (int j = width / 4; j < width * 3 / 4; j += 5)
        {
            count++;
            countRGB += (frame.at<Vec3b>(i, j)[0] + frame.at<Vec3b>(i, j)[1] + frame.at<Vec3b>(i, j)[2]);
        }
    }

    // printf("RGB合計：%ld\n", countRGB);
    // printf("精査回数：%ld\n", count);
    // printf("平均：%ld \n", countRGB / count);
    printf("変化割合：%f\n", ((float)(countRGB / count) / 256) * 100);

    // 指定した閾値よりも変化しているか
    return ((((float)(countRGB / count) / 256) * 100) > g_threshold);
}

// 参考:https://kisqragi.hatenablog.com/entry/2019/11/02/130921
// 第1引数:元ビデオのパス
int movie_to_picture(std::string video_path)
{
    VideoCapture video(video_path);
    // 動画がない場合
    if (!video.isOpened())
    {
        return -1;
    }
    // フレーム数取得
    int frame_num = video.get(cv::CAP_PROP_FRAME_COUNT);
    // 00x.ext にするための桁数の取得
    int digit = std::to_string(frame_num).length();

    Mat frame1;
    //frame1に適当な画像を挿入する処理
    video.set(CAP_PROP_POS_FRAMES, frame_num - 10);
    video >> frame1;

    Mat frame2;

    int fps = video.get(cv::CAP_PROP_FPS);

    for (int i = 0; i < frame_num; i += fps * g_interval)
    {
        if (i > 0)
        {
            // フレームを指定した秒数分ずらす
            video.set(CAP_PROP_POS_FRAMES, i - fps * g_interval);
            // フレームを取得する
            video >> frame1;
        }
        frame1 = trimming(frame1);

        // フレームを指定した秒数分ずらす
        video.set(CAP_PROP_POS_FRAMES, i);
        // フレームを取得する
        video >> frame2;
        frame2 = trimming(frame2);

        if (frame2.empty())
        {
            return -1;
        }

        if (compare_frames(difference(frame1, frame2)))
        {
            // 00x.extの文字列作成
            std::stringstream ss;
            ss << g_save_location << std::setw(digit) << i << ".jpg";
            std::cout << ss.str() << std::endl;
            // 保存する
            imwrite(ss.str().c_str(), frame2);
        }
    }

    return 0;
}

int main(int argc, char *argv[])
{
    int opt;
    opterr = 0; //getopt()のエラーメッセージを無効にする。
    std::string input_location = "./movie.mp4";

    while ((opt = getopt(argc, argv, "i:o:t:r:a:f:")) != -1)
    {
        //コマンドライン引数のオプションがなくなるまで繰り返す
        switch (opt)
        {
        case 'i':
            input_location = optarg;
            break;

        case 'o':
            g_save_location = optarg;
            break;
        // 閾値
        case 't':
            g_threshold = atof(optarg);
            break;
        // トリミング開始位置（横）
        case 'r':
            g_trimming_point = atoi(optarg);
            break;
        // スライドのアスペクト比(0なら4:3,1なら16:9)
        case 'a':
            g_aspect_ratio = atoi(optarg);
            break;
        // フレーム取得間隔（秒）
        case 'f':
            g_interval = atoi(optarg);
            break;
        }
    }
    printf("**********設定確認**********\n");
    printf("閾値:%f\n", g_threshold);
    printf("トリミング開始位置:%d\n", g_trimming_point);
    printf("スライド取得間隔:%d秒\n", g_interval);
    printf("アスペクト比:");
    if (g_aspect_ratio == 0)
    {
        printf("4:3\n");
    }
    else
    {
        printf("16:9\n");
    }
    printf("**********設定確認終わり**********\n\n");
    movie_to_picture(input_location);
    return 0;
}