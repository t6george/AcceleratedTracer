#include <Scenes.cuh>
#include <Materials.cuh>
#include <Objects.cuh>
#include <Textures.cuh>
#include <Transformations.cuh>
#include <Light.cuh>
#include <Pdfs.cuh>

namespace scene
{
    SCENE(cornell_box)
    {
        const double fieldOfView = 40.;
        const double apertureRadius = 0.;
        const double distanceToFocus = 10.;
        const Vec3 lookFrom = Vec3{278., 278., -800.};
        const Vec3 lookAt = Vec3{278., 278., 0.};
        const double t0 = 0.;
        const double t1 = 1.;

        camera = stdSharedPointer::makeShared<Camera>(aspectR, fieldOfView, apertureRadius, distanceToFocus, lookFrom, lookAt, t0, t1);

        objects = stdSharedPointer::makeShared<HittableList>();
        sampleObjects = stdSharedPointer::makeShared<HittableList>();

        auto red = stdSharedPointer::makeShared<LambertianDiffuse>(stdSharedPointer::makeShared<SolidColor>(.65, .05, .05));
        auto white = stdSharedPointer::makeShared<LambertianDiffuse>(stdSharedPointer::makeShared<SolidColor>(.73, .73, .73));
        auto green = stdSharedPointer::makeShared<LambertianDiffuse>(stdSharedPointer::makeShared<SolidColor>(.12, .45, .15));
        auto light = stdSharedPointer::makeShared<DiffuseLight>(stdSharedPointer::makeShared<SolidColor>(15., 15., 15.));
        auto aluminum = stdSharedPointer::makeShared<Metal>(stdSharedPointer::makeShared<SolidColor>(.8, .85, .88), 0.);

        objects->add(stdSharedPointer::makeShared<FlipFace>(stdSharedPointer::makeShared<AARect<utils::Axis::X>>(0., 555., 0., 555., 555., green)));
        objects->add(stdSharedPointer::makeShared<AARect<utils::Axis::X>>(0., 555., 0., 555., 0., red));
        objects->add(stdSharedPointer::makeShared<FlipFace>(stdSharedPointer::makeShared<AARect<utils::Axis::Y>>(213., 343., 227., 332., 554., light)));
        objects->add(stdSharedPointer::makeShared<FlipFace>(stdSharedPointer::makeShared<AARect<utils::Axis::Y>>(0., 555., 0., 555., 0., white)));
        objects->add(stdSharedPointer::makeShared<AARect<utils::Axis::Y>>(0., 555., 0., 555., 555., white));
        objects->add(stdSharedPointer::makeShared<FlipFace>(stdSharedPointer::makeShared<AARect<utils::Axis::Z>>(0., 555., 0., 555., 555., white)));

        // SharedPointer<Hittable> box1 = stdSharedPointer::makeShared<Box>(Vec3{0., 0., 0.}, Vec3{165., 330., 165.}, stdSharedPointer::makeShared<Metal>(stdSharedPointer::makeShared<SolidColor>(.8, .85, .88), 0.));
        SharedPointer<Hittable> box1 = stdSharedPointer::makeShared<Box>(Vec3{0., 0., 0.}, Vec3{165., 330., 165.}, aluminum);

        box1 = stdSharedPointer::makeShared<AARotate<utils::Axis::Y>>(box1, 15.);
        box1 = stdSharedPointer::makeShared<Translate>(box1, Vec3{300., 0., 295.});

        SharedPointer<Hittable> box3 = stdSharedPointer::makeShared<Box>(Vec3{0., 0., 0.}, Vec3{165., 400., 165.}, white);

        box3 = stdSharedPointer::makeShared<AARotate<utils::Axis::Y>>(box3, -20.);
        box3 = stdSharedPointer::makeShared<Translate>(box3, Vec3{90., 0., 295.});

        SharedPointer<Hittable> box2 = stdSharedPointer::makeShared<Box>(Vec3{0., 0., 0.}, Vec3{165., 165., 165.}, white);

        box2 = stdSharedPointer::makeShared<AARotate<utils::Axis::Y>>(box2, -18.);
        box2 = stdSharedPointer::makeShared<Translate>(box2, Vec3{130., 0., 65.});

        objects->add(box1);
        objects->add(box3);
        // objects->add(stdSharedPointer::makeShared<Sphere>(Vec3{190., 390., 190.}, 90., red));
        objects->add(stdSharedPointer::makeShared<Sphere>(Vec3{190., 90., 190.}, 90., stdSharedPointer::makeShared<Dielectric>(1.5)));
        // objects->add(box2);

        sampleObjects->add(stdSharedPointer::makeShared<AARect<utils::Axis::Y>>(213., 343., 227., 332., 554., 
                stdSharedPointer::makeShared<Material>(nullptr)));
        sampleObjects->add(stdSharedPointer::makeShared<Sphere>(Vec3{190., 90., 190.}, 90., stdSharedPointer::makeShared<Material>(nullptr)));
    }

    SCENE(perlin_spheres)
    {
        const double fieldOfView = 40.;
        const double apertureRadius = 0.;
        const double distanceToFocus = 10.;
        const Vec3 lookFrom = Vec3{278., 278., -800.};
        const Vec3 lookAt = Vec3{278., 278., 0.};
        const double t0 = 0.;
        const double t1 = 1.;

        camera = stdSharedPointer::makeShared<Camera>(aspectR, fieldOfView, apertureRadius, distanceToFocus, lookFrom, lookAt, t0, t1);

        objects = stdSharedPointer::makeShared<HittableList>();
        sampleObjects = stdSharedPointer::makeShared<HittableList>();

        auto pertext = stdSharedPointer::makeShared<TurbulentTexture>();
        objects->add(stdSharedPointer::makeShared<Sphere>(Vec3{0., -1000., 0.}, 1000., stdSharedPointer::makeShared<LambertianDiffuse>(pertext)));
        objects->add(stdSharedPointer::makeShared<Sphere>(Vec3{0., 2., 0.}, 2., stdSharedPointer::makeShared<LambertianDiffuse>(pertext)));
    }

    SCENE(image_texture)
    {
        const double fieldOfView = 40.;
        const double apertureRadius = 0.;
        const double distanceToFocus = 10.;
        const Vec3 lookFrom = Vec3{278., 278., -800.};
        const Vec3 lookAt = Vec3{278., 278., 0.};
        const double t0 = 0.;
        const double t1 = 1.;

        camera = stdSharedPointer::makeShared<Camera>(aspectR, fieldOfView, apertureRadius, distanceToFocus, lookFrom, lookAt, t0, t1);

        objects = stdSharedPointer::makeShared<HittableList>();
        sampleObjects = stdSharedPointer::makeShared<HittableList>();

        auto imgtext = stdSharedPointer::makeShared<ImageTexture>("world.jpg");
        objects->add(stdSharedPointer::makeShared<Sphere>(Vec3{0., 0., 0.}, 2., stdSharedPointer::makeShared<LambertianDiffuse>(imgtext)));
    }

    SCENE(light_scene)
    {
        const double fieldOfView = 40.;
        const double apertureRadius = 0.;
        const double distanceToFocus = 10.;
        const Vec3 lookFrom = Vec3{278., 278., -800.};
        const Vec3 lookAt = Vec3{278., 278., 0.};
        const double t0 = 0.;
        const double t1 = 1.;

        camera = stdSharedPointer::makeShared<Camera>(aspectR, fieldOfView, apertureRadius, distanceToFocus, lookFrom, lookAt, t0, t1);

        objects = stdSharedPointer::makeShared<HittableList>();
        sampleObjects = stdSharedPointer::makeShared<HittableList>();

        auto difflight = stdSharedPointer::makeShared<DiffuseLight>(stdSharedPointer::makeShared<SolidColor>(4., 4., 4.));
        auto mat = stdSharedPointer::makeShared<LambertianDiffuse>(stdSharedPointer::makeShared<SolidColor>(1., 0., 0.));

        objects->add(stdSharedPointer::makeShared<Sphere>(Vec3{0., -1000., 0.}, 1000., mat));
        objects->add(stdSharedPointer::makeShared<Sphere>(Vec3{0., 2., 0.}, 2., mat));

        objects->add(stdSharedPointer::makeShared<Sphere>(Vec3{0., 7., 0.}, 2., difflight));
        objects->add(stdSharedPointer::makeShared<AARect<utils::Axis::Z>>(3., 5., 1., 3., -2., difflight));
    }

    SCENE(volume_cornell_box)
    {
        const double fieldOfView = 40.;
        const double apertureRadius = 0.;
        const double distanceToFocus = 10.;
        const Vec3 lookFrom = Vec3{278., 278., -800.};
        const Vec3 lookAt = Vec3{278., 278., 0.};
        const double t0 = 0.;
        const double t1 = 1.;

        camera = stdSharedPointer::makeShared<Camera>(aspectR, fieldOfView, apertureRadius, distanceToFocus, lookFrom, lookAt, t0, t1);

        objects = stdSharedPointer::makeShared<HittableList>();
        sampleObjects = stdSharedPointer::makeShared<HittableList>();

        auto red = stdSharedPointer::makeShared<LambertianDiffuse>(stdSharedPointer::makeShared<SolidColor>(.65, .05, .05));
        auto white = stdSharedPointer::makeShared<LambertianDiffuse>(stdSharedPointer::makeShared<SolidColor>(.73, .73, .73));
        auto green = stdSharedPointer::makeShared<LambertianDiffuse>(stdSharedPointer::makeShared<SolidColor>(.12, .45, .15));
        auto light = stdSharedPointer::makeShared<DiffuseLight>(stdSharedPointer::makeShared<SolidColor>(15., 15., 15.));

        objects->add(stdSharedPointer::makeShared<AARect<utils::Axis::X>>(0., 555., 0., 555., 555., green));

        objects->add(stdSharedPointer::makeShared<AARect<utils::Axis::X>>(0., 555., 0., 555., 0., red));
        objects->add(stdSharedPointer::makeShared<AARect<utils::Axis::Y>>(113., 443., 127., 432., 554., light));
        objects->add(stdSharedPointer::makeShared<AARect<utils::Axis::Y>>(0., 555., 0., 555., 0., white));
        objects->add(stdSharedPointer::makeShared<AARect<utils::Axis::Y>>(0., 555., 0., 555., 555., white));
        objects->add(stdSharedPointer::makeShared<AARect<utils::Axis::Z>>(0., 555., 0., 555., 555., white));

        SharedPointer<Hittable> box1 = stdSharedPointer::makeShared<Box>(Vec3{0., 0., 0.}, Vec3{165., 330., 165.}, white);

        box1 = stdSharedPointer::makeShared<AARotate<utils::Axis::Y>>(box1, 15.);
        box1 = stdSharedPointer::makeShared<Translate>(box1, Vec3{265., 0., 295.});

        SharedPointer<Hittable> box2 = stdSharedPointer::makeShared<Box>(Vec3{0., 0., 0.}, Vec3{165., 165., 165.}, white);

        box2 = stdSharedPointer::makeShared<AARotate<utils::Axis::Y>>(box2, -18.);
        box2 = stdSharedPointer::makeShared<Translate>(box2, Vec3{130., 0., 65.});

        objects->add(stdSharedPointer::makeShared<ConstantVolume>(box1, stdSharedPointer::makeShared<SolidColor>(0., 0., 0.), .01));
        objects->add(stdSharedPointer::makeShared<ConstantVolume>(box2, stdSharedPointer::makeShared<SolidColor>(1., 1., 1.), .01));
    }

    SCENE(summary)
    {
        const double fieldOfView = 40.;
        const double apertureRadius = 0.;
        const double distanceToFocus = 10.;
        const Vec3 lookFrom = Vec3{278., 278., -800.};
        const Vec3 lookAt = Vec3{278., 278., 0.};
        const double t0 = 0.;
        const double t1 = 1.;

        camera = stdSharedPointer::makeShared<Camera>(aspectR, fieldOfView, apertureRadius, distanceToFocus, lookFrom, lookAt, t0, t1);

        SharedPointer<HittableList> boxes1 = stdSharedPointer::makeShared<HittableList>();

        auto ground = stdSharedPointer::makeShared<LambertianDiffuse>(stdSharedPointer::makeShared<SolidColor>(.48, .83, .53));

        const int boxes_per_side = 20;
        for (int i = 0; i < boxes_per_side; ++i)
        {
            for (int j = 0; j < boxes_per_side; ++j)
            {
                auto w = 100.;
                auto x0 = -1000. + i * w;
                auto z0 = -1000. + j * w;
                auto y0 = 0.;
                auto x1 = x0 + w;
                auto y1 = utils::random_double(1., 101.);
                auto z1 = z0 + w;

                boxes1->add(stdSharedPointer::makeShared<Box>(Vec3{x0, y0, z0}, Vec3{x1, y1, z1}, ground));
            }
        }

        objects = stdSharedPointer::makeShared<HittableList>();
        sampleObjects = stdSharedPointer::makeShared<HittableList>();

        objects->add(stdSharedPointer::makeShared<BVHNode>(*boxes1.get(), 0., 1.));
        auto light = stdSharedPointer::makeShared<DiffuseLight>(stdSharedPointer::makeShared<SolidColor>(7., 7., 7.));
        objects->add(stdSharedPointer::makeShared<AARect<utils::Axis::Y>>(123., 423., 147., 412., 554., light));

        auto center1 = Vec3{400., 400., 200.};
        auto center2 = center1 + Vec3{30., 0., 0.};
        auto moving_sphere_material =
            stdSharedPointer::makeShared<LambertianDiffuse>(stdSharedPointer::makeShared<SolidColor>(.7, .3, .1));
        objects->add(stdSharedPointer::makeShared<Sphere>(center1, center2, 50., moving_sphere_material));

        objects->add(stdSharedPointer::makeShared<Sphere>(Vec3{260., 150., 45.}, 50., stdSharedPointer::makeShared<Dielectric>(1.5)));
        objects->add(stdSharedPointer::makeShared<Sphere>(
            Vec3{0., 150., 145.}, 50., stdSharedPointer::makeShared<Metal>(stdSharedPointer::makeShared<SolidColor>(Vec3{.8, .8, .9}), 10.)));

        auto boundary = stdSharedPointer::makeShared<Sphere>(Vec3{360., 150., 145.}, 70., stdSharedPointer::makeShared<Dielectric>(1.5));
        objects->add(boundary);
        objects->add(stdSharedPointer::makeShared<ConstantVolume>(
            boundary, stdSharedPointer::makeShared<SolidColor>(.2, .4, .9), .2));
        boundary = stdSharedPointer::makeShared<Sphere>(Vec3{0., 0., 0.}, 5000., stdSharedPointer::makeShared<Dielectric>(1.5));
        objects->add(stdSharedPointer::makeShared<ConstantVolume>(
            boundary, stdSharedPointer::makeShared<SolidColor>(1., 1., 1.), .0001));

        auto emat = stdSharedPointer::makeShared<LambertianDiffuse>(stdSharedPointer::makeShared<ImageTexture>("world.jpg"));
        objects->add(stdSharedPointer::makeShared<Sphere>(Vec3{400., 200., 400.}, 100., emat));
        auto pertext = stdSharedPointer::makeShared<PerlinNoiseTexture>(.1);
        objects->add(stdSharedPointer::makeShared<Sphere>(Vec3{220, 280., 300.}, 80., stdSharedPointer::makeShared<LambertianDiffuse>(pertext)));

        SharedPointer<HittableList> boxes2 = stdSharedPointer::makeShared<HittableList>();
        
        auto white = stdSharedPointer::makeShared<LambertianDiffuse>(stdSharedPointer::makeShared<SolidColor>(.73, .73, .73));
        int ns = 1000;
        for (int j = 0; j < ns; ++j)
        {
            boxes2->add(stdSharedPointer::makeShared<Sphere>(Vec3::randomVector(Vec3{}, Vec3{165., 165., 165.}), 10., white));
        }

        objects->add(stdSharedPointer::makeShared<Translate>(
            stdSharedPointer::makeShared<AARotate<utils::Axis::Y>>(
                stdSharedPointer::makeShared<BVHNode>(*boxes2.get(), 0., 1.), 15.),
            Vec3{-100., 270., 395.}));
    }

} // namespace scene
