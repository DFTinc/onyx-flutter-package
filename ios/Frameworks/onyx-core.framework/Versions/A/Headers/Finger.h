/*
 * Finger.h
 *
 *  Created on: Jul 11, 2014
 *      Author: wlucas
 */

#ifndef FINGER_H_
#define FINGER_H_

#include <algorithm>
#include <vector>

#include <opencv2/core/core.hpp>
#include <opencv2/imgproc/imgproc.hpp>

namespace dft {

typedef std::vector<cv::Point> Contour;
typedef std::vector<Contour> ContourVector;

template<typename T>
T clamp(const T &value, const T &low, const T &high) {
  return std::max(low, std::min(value, high));
}

/// This class defines the physical representation of the finger in an image.
class Finger {
 public:
  /// Constructs a default Finger object.
  Finger()
      : fingerEllipse(cv::Point2f(-1.0f, -1.0f), cv::Size2f(0.0f, 0.0f), 0.0f) {}

  /// Constructs a Finger object from given contour and circle.
  /// \param[in] fingerEllipse_ a RotatedRect specifying the Finger position, size, and orientation.
  /// \param[in] fingerTip_ a Point2f specifying the (x, y) tip of the finger.
  Finger(const cv::RotatedRect& fingerEllipse_, const cv::Point2f& fingerTip_ = cv::Point2f(-1.0f, -1.0f))
      : fingerEllipse(fingerEllipse_), fingerTip(fingerTip_) {}

  /// This member function determines if the Finger object is valid.
  /// \return true if the Finger object is valid, otherwise false.
  bool isValid() const {
    return center().x >= 0.0f && center().y >= 0.0f && fingerEllipse.size.area() > 0;
  }

  /// This member function returns the mask of the Finger region.
  /// \param canvasSize the size of the canvas to draw the contour on.
  /// \return the mask containing the contour.
  cv::Mat getFingerMask(const cv::Size &canvasSize) const {
    cv::Mat mask = cv::Mat::zeros(canvasSize, CV_8UC1);
    cv::ellipse(mask, fingerEllipse, cv::Scalar(255, 255, 255), cv::FILLED);

    return mask;
  }

  /// This member function returns the cropped mask of the bounded Finger region.
  /// \param canvasSize the size of the canvas for clipping.
  /// \return the mask containing the contour.
  cv::Mat getBoundedFingerMask(const cv::Size &canvasSize) const {
    cv::Rect clampedBounds = getClampedRect(canvasSize);
    cv::Rect bounds = getRect();
    cv::Point2f croppedCenter(
        static_cast<float>(bounds.width) / 2.0f,
        static_cast<float>(bounds.height) / 2.0f
    );

    cv::RotatedRect croppedRect(croppedCenter, fingerEllipse.size, fingerEllipse.angle);
    cv::Mat mask = cv::Mat::zeros(bounds.size(), CV_8UC1);

    cv::ellipse(mask, croppedRect, cv::Scalar(255, 255, 255), cv::FILLED);

    if (!rectsEqual(clampedBounds, bounds)) {
      cv::Rect roi(
          clampedBounds.tl() - bounds.tl(),
          clampedBounds.size()
      );

      mask = mask(roi).clone();
    }

    return mask;
  }

  /// This member function returns the axis-aligned bounding box (AABB) of the finger.
  /// \return the finger's AABB.
  cv::Rect getRect() const {
    return fingerEllipse.boundingRect();
  }

  /// This member function returns the axis-aligned bounding box (AABB) of the finger.
  /// \param canvasSize the size of the canvas for clipping.
  /// \return the finger's AABB.
  cv::Rect getClampedRect(const cv::Size &canvasSize) const {
    cv::Rect bounds = fingerEllipse.boundingRect();

    return cv::Rect(
        cv::Point(
            clamp<int>(bounds.x, 0, canvasSize.width),
            clamp<int>(bounds.y, 0, canvasSize.height)
        ),
        cv::Point(
            clamp<int>(bounds.x + bounds.width, 0, canvasSize.width),
            clamp<int>(bounds.y + bounds.height, 0, canvasSize.height)
        )
    );
  }

  /// This member function returns the orientation of the finger.
  /// \return the angle of the finger in degrees.
  float angle() const {
    return fingerEllipse.angle;
  }

  /// This member function returns the size of the finger.
  /// \return the size of the finger.
  cv::Size2f size() const {
    return fingerEllipse.size;
  }

  /// This member function returns the center of the finger (x,y) location.
  /// \return the detected finger center location in (x,y) coordinates.
  cv::Point2f center() const {
    return fingerEllipse.center;
  }

  /// This member function returns the tip of the finger (x,y) location.
  /// \return the detected finger tip location in (x,y) coordinates. (-1, -1) indicates no detection.
  cv::Point2f tip() const {
    return fingerTip;
  }

  /// This member function returns if the finger should be rotated clockwise or counter-clockwise.
  /// \return true if clockwise rotation, false otherwise.
  bool rotateClockwise() const {
    if (fingerTip.x < 0.0f && fingerTip.y < 0.0f) {
      return false;
    }

    cv::Point2f diff = fingerTip - center();
    float angle = std::atan2(diff.y, diff.x);
    return angle <= -M_PI_2 || angle >= M_PI_2;
  }

  /// This member function scales the Finger's parameters by a scale factor.
  /// \param[in] scaleFactor amount to scale finger parameters by.
  void scaleFinger(float scaleFactor) {
    cv::RotatedRect scaledFingerEllipse(
        fingerEllipse.center * scaleFactor,
        cv::Size2f(fingerEllipse.size.width * scaleFactor, fingerEllipse.size.height * scaleFactor),
        fingerEllipse.angle
    );

    fingerEllipse = scaledFingerEllipse;
    fingerTip = scaleFactor * fingerTip;
  }

 private:
  cv::RotatedRect fingerEllipse;
  cv::Point2f fingerTip;

  bool rectsEqual(const cv::Rect &lhs, const cv::Rect &rhs) const {
    return lhs.x == rhs.x && lhs.y == rhs.y && lhs.width == rhs.width && lhs.height == rhs.height;
  }
};

}

#endif /* FINGER_H_ */
