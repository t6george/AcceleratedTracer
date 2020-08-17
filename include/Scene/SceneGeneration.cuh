#pragma once

#include <memory>

#include <HittableList.cuh>
#include <Camera.cuh>
#include <Vec3.cuh>
#include <Ray.cuh>

#define SAMPLES_PER_PIXEL 10

namespace generate
{
#ifdef __CUDACC__
    __device__
#endif
    void ray_color(Ray &ray, const Vec3 &background, std::shared_ptr<HittableList> world,
        WeightedPdf& pdf, const unsigned maxReflections, Vec3 &finalColor);
    
#ifdef __CUDACC__
    __global__
#endif
    void sample_pixel(float *image, const unsigned width, const unsigned height, const unsigned maxReflections, 
		    std::shared_ptr<Camera> camera, WeightedPdf &pdf, const Vec3 &background, std::shared_ptr<HittableList> world);
        
    void scene(const unsigned width, const unsigned height,
        const unsigned maxReflections, const double aspectR);
} // namespace generate
