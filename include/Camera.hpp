#pragma once
#include <Vec3.hpp>
#include <Ray.hpp>

class Camera
{
    class OrthoNormalBasis
    {
        Vec3 z, x, y;

    public:
        OrthoNormalBasis(Vec3 &eyes, const Vec3 &lookat, const Vec3 &vup = Vec3{0., 1., 0.});
        ~OrthoNormalBasis() noexcept = default;

        const Vec3 &getX() const;
        const Vec3 &getY() const;
        const Vec3 &getZ() const;
    };

    Ray lineOfSight;

    const double halfHeight, halfWidth;
    double lensRadius, focusDist;

    Vec3 eyes;

    OrthoNormalBasis basis;

    Vec3 corner, dimX, dimY;
    double time1, time2;

public:
    Camera(const double aspR, double fov, const double aperture, const double focusD,
           const Vec3 &lookfrom = Vec3{}, const Vec3 &lookat = Vec3{0., 0., -1.},
           double t0 = 0., double t1 = 0.);

    ~Camera() noexcept = default;
    const Ray &updateLineOfSight(double u, double v);
    const Ray &getLineOfSight() const;
    void moveCamera(const Vec3 &displacement);
};