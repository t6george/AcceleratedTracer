#include <Dielectric.hpp>
#include <SolidColor.hpp>

Dielectric::Dielectric(const double reflectiveIndex)
    : Material::Material{std::make_shared<SolidColor>(Vec3{1., 1., 1.})},
      reflectiveIndex{reflectiveIndex} {}

bool Dielectric::scatterRay(const Ray &ray, Hittable::HitRecord &record) const
{
    double n_over_nprime = reflectiveIndex;
    if (record.isInFront)
    {
        n_over_nprime = 1. / n_over_nprime;
    }

    double cos = fmin(1., (-ray.direction().getUnitVector()).o(record.normal));
    double sin = sqrt(1.0 - cos * cos);

    if (n_over_nprime * sin > 1. || utils::random_double() < utils::schlick(cos, n_over_nprime))
    {
        record.scatteredRay.resetDirection(ray.direction().getUnitVector().reflect(
            record.normal));
    }
    else
    {
        record.scatteredRay.resetDirection(ray.direction().getUnitVector().refract(
            record.normal, n_over_nprime));
    }

    record.attenuation = albedo->getValue(record.u, record.v, Vec3{});
    record.scatteredRay.resetOrigin(record.point);
    record.scatteredRay.setTime(ray.time());
    record.emitted = emitCol(record.u, record.v, Vec3{});

    return true;
}