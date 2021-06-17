/// \file core.h
/// \brief This file defines the base functionality of the onyx-core SDK.
/// \copyright Copyright 2014 Diamond Fortress Technologies, Inc. All rights reserved.
/// \author Will Lucas

#ifndef CORE_H_
#define CORE_H_

#include "Finger.h"
#include "FingerprintTemplate.h"
#include "MatchResult.h"
#include "CaptureUtils.h"
#include <vector>
#include <opencv2/core/core.hpp>

/// \namespace dft Top-level Diamond Fortress Technologies namespace.
namespace dft
{
/// This function preprocesses a fingerprint image for use with generateFingerprintTemplate.
/// \param[in] src an 8-bit grayscale fingerprint image to be preprocessed.
/// \param[out] dst an 8-bit grayscale preprocessed fingerprint image.
/// \param[in] sigma1 amount of blur for the mean calculation (default = 2)
/// \param[in] sigma2 amount of blur for the standard deviation (default = 1)
/// \param[in] channel which channel to utilize (default = -1 -> all)
/// \throws DftException if an error occurs.
/// \see generateFingerprintTemplate
void preprocessFingerprint(const cv::Mat& src, cv::Mat& dst, double sigma1 = 2.0, double sigma2 = 1.0, int channel = -1);

/// This function aligns the image with the axes
/// \param[in] src an 8-bit fingerprint image to be axis aligned.
/// \param[out] dst an 8-bit fingerprint image that's rotated to be 0 degrees.
/// \param[in] finger object describing the finger position and rotation.
/// \param[in] clockwise performance rotation in clockwise fashion? (default = false)
/// \param[in] flags interpolation types (default = cv::INTER_LINEAR)
/// \param[in] borderMode border mode (default = cv::BORDER_CONSTANT)
void axisAlign(cv::Mat& src, cv::Mat& dst, const Finger& finger, bool clockwise, int flags = cv::INTER_LINEAR, int borderMode = cv::BORDER_CONSTANT);

/// This function contrast stretches the image
/// \param[in] src an 8-bit fingerprint image
/// \param[out] dst an 8-bit constrast stretched fingerprint image
/// \param[in] alpha controls how tight the fit boundary is
void constrastStretch(const cv::Mat& src, cv::Mat& dst, float alpha = 10.0f);


/// This function feathers the image edges
/// \param[in] src an 8-bit image
/// \param[out] dst an 8-bit feathered image
/// \param[in] featherSize controls feather kernel width in pixels
void featherEdges(const cv::Mat& src, cv::Mat& dst, int featherSize = 31);


/// This function aligns the image with the axes
/// \param[in] mask an 8-bit binary mask to be analyzed
/// \returns the maximum inscribed rectangle for an axis aligned image
cv::Rect maxInscribedRect(const cv::Mat& mask);

/// This function enhances a fingerprint image for use with generateFingerprintTemplate.
/// \param[in] src an 8-bit grayscale image that has been preprocessed first.
/// \param[out] enhanced an 8-bit grayscale image that has been enhanced.
/// \param[out] energyMask an 8-bit binary mask for quality filtering purposes.
/// \throws DftException if an error occurs.
/// \see preprocessFingerprint
void enhanceFingerprint(const cv::Mat& src, cv::Mat& enhanced, cv::Mat& energyMask);

/// This function generates a fingerprint template from a preprocessed image.
/// \param[in] src an 8-bit grayscale preprocessed fingerprint image.
/// \param[in] mask an 8-bit mask used to filter the detected feature locations.
/// \return a pointer to a FingerprintTemplate.
/// \note It is up to the client to manage the returned pointer.
/// \throws DftException if an error occurs.
/// \see FingerprintTemplate
FingerprintTemplate* generateFingerprintTemplate(const cv::Mat& src, const cv::Mat& mask = cv::Mat());

/// This function generates an ISO fingerprint template from a preprocessed image.
/// \param[in] src an 8-bit grayscale preprocessed fingerprint image.
/// \param[in] mask an 8-bit mask used to filter the detected feature locations.
/// \return a pointer to an ISO formatted FingerprintTemplate.
/// \note It is up to the client to manage the returned pointer.
/// \throws DftException if an error occurs.
/// \see FingerprintTemplate
FingerprintTemplate* generateIsoFingerprintTemplate(const cv::Mat& src, const cv::Mat& mask = cv::Mat());

/// This function performs a 1:1 match on two fingerprint templates.
/// \param[in] reference the first fingerprint template to verify with.
/// \param[in] probe the second fingerprint template to verify with.
/// \return the match score between [0, 1]. Higher is better.
/// \throws DftException if an error occurs.
/// \see FingerprintTemplate
float verify(const FingerprintTemplate& reference, const FingerprintTemplate& probe);

/// This function performs a 1:1 match on two fingerprint templates.
/// \param[in] reference the first fingerprint template to verify with.
/// \param[in] probe the image to be pyramided.
/// \param[in] scales a vector of scales to increase depth tolerance.
/// \return the match score between [0, 1]. Higher is better.
/// \throws DftException if an error occurs.
/// \see FingerprintTemplate
float pyramidVerify(const FingerprintTemplate& reference, const cv::Mat& probe, const std::vector<double>& scales = std::vector<double>());

/// This function performs a 1:N match on templates supplied in the gallery.
/// \param[in] gallery a vector of FingerprintTemplates.
/// \param[in] probe a single FingerprintTemplate to match against the gallery.
/// \return the MatchResult containing the top matching score as well as the matched index in the gallery.
/// \note All matches are performed in parallel.
/// \throws DftException if an error occurs.
/// \see FingerprintTemplate
/// \see MatchResult
MatchResult identify(const std::vector<FingerprintTemplate>& gallery, const FingerprintTemplate& probe);

/// This function performs a 1:N match on templates supplied in the gallery.
/// \param[in] gallery a vector of FingerprintTemplates.
/// \param[in] probe an image to match against the gallery.
/// \param[in] scales a vector of scales to increase depth tolerance.
/// \return the MatchResult containing the top matching score as well as the matched index in the gallery.
/// \note All matches are performed in parallel.
/// \throws DftException if an error occurs.
/// \see FingerprintTemplate
/// \see MatchResult
MatchResult pyramidIdentify(const std::vector<FingerprintTemplate>& gallery, const cv::Mat& probe, const std::vector<double>& scales = std::vector<double>());

/// This function locates fingers in a CaptureNet output mask.
/// \param[in] src the 24-bit color image provided to CaptureNet
/// \param[in] mask the 8-bit mask image provided by CaptureNet
/// \param[in] markers the 8-bit markers image provided by CaptureNet
/// \param[out] fingerMask cleaned version of input mask
/// \param[in] sizeFactor how much to scale detected ellipses
/// \return an array of detected Finger locations
/// \throws DftException if an error occurs.
/// \see Finger
std::vector<Finger> findFingers(const cv::Mat& src, const cv::Mat &mask, const cv::Mat& markers, cv::Mat &fingerMask, float sizeFactor = 0.8f);

/// This member function analyzes the fingertip focus.
/// \param[in] src the 8-bit grayscale image to analyze for focus.
/// \param[in] fingerMask cleaned mask output from findFingers.
/// \return a focus measure greater than 1 means in focus, less than 1 means out of focus.
/// \throws DftException if an error occurs.
/// \see findFinger
double focusMeasure(const cv::Mat& src, const cv::Mat& fingerMask);

/// This member function gets true finger sizes
/// \param[in] image 8-bit grayscale image to use
/// \param[in] minSize minimum size of targets
/// \param[in] minCircularity minimum circularity measure to use
/// \return pixels per inch detected using dot target
double findPixelsPerInch(const cv::Mat& image, double minSize = 5000, double minCircularity = 0.8);
}


#endif /* CORE_H_ */
