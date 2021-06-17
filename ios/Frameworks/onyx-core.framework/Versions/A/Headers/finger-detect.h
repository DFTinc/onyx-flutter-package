#ifndef FINGER_DETECT_H_
#define FINGER_DETECT_H_

#include <vector>
#include <opencv2/core/core.hpp>

#include "dft/Finger.h"

namespace dft
{

void axisAlignImpl(
        const cv::Mat& src,
        cv::Mat& dst,
        const Finger& finger,
        bool clockwise,
        int flags,
        int borderMode
);
cv::Rect maxInscribedRectImpl(const cv::Mat& mask);
std::vector<Finger> findFingersImpl(const cv::Mat& image, const cv::Mat &mask, const cv::Mat& markers, cv::Mat &finger_mask, float size_factor);

}

#endif
