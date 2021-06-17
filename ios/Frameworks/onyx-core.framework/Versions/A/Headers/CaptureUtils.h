#ifndef CAPTUREUTILS_H_
#define CAPTUREUTILS_H_

#include <opencv2/core/core.hpp>
#include <vector>

namespace dft {

std::vector<unsigned char> yuvCamera2ToYuvOcvImpl(
        const std::vector<unsigned char> &yuvCamera2,
        const cv::Size &imageSize,
        int yRowStride,
        int yPixelStride,
        int uvRowStride,
        int uvPixelStride);

}

#endif
